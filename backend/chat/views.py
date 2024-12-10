from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import ChatRoom, Message
from .serializers import ChatRoomSerializer, MessageSerializer, JobSeekerChatRoomSerializer, RecruiterChatRoomSerializer
from django.db.models import Q
from recruiter.models import Recruiter
from job_seeker.models import JobSeeker
from django.shortcuts import get_object_or_404
from django.db.models import Max

class ChatRoomView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ChatRoomSerializer

    def get_queryset(self):
        user = self.request.user
        recruiter_id = self.kwargs.get('recruiter_id')
        job_seeker_id = self.kwargs.get('job_seeker_id')

        if recruiter_id:
            recruiter = Recruiter.objects.get(id=recruiter_id)
            chat_room = ChatRoom.objects.filter(job_seeker__user=user, recruiter=recruiter).first()
        elif job_seeker_id:
            job_seeker = JobSeeker.objects.get(id=job_seeker_id)
            chat_room = ChatRoom.objects.filter(job_seeker=job_seeker, recruiter__user=user).first()
        else:
            return ChatRoom.objects.none()

        return [chat_room] if chat_room else ChatRoom.objects.none()

    def list(self, request, *args, **kwargs):
        chat_room = self.get_queryset().first()
        if chat_room:
            messages = Message.objects.filter(chat_room=chat_room).order_by('timestamp')
            serialized_messages = MessageSerializer(messages, many=True).data
            return Response({
                'chat_room': ChatRoomSerializer(chat_room).data,
                'messages': serialized_messages
            })
        return Response({'message': 'No chat room found.'}, status=status.HTTP_404_NOT_FOUND)

    def perform_create(self, serializer):
        user = self.request.user
        recruiter_id = self.kwargs.get('recruiter_id')
        job_seeker_id = self.kwargs.get('job_seeker_id')

        if recruiter_id:
            recruiter = Recruiter.objects.get(id=recruiter_id)
            job_seeker = JobSeeker.objects.get(user=user)
        else:
            recruiter = Recruiter.objects.get(user=user)
            job_seeker = JobSeeker.objects.get(id=job_seeker_id)

        is_approved = user == recruiter.user  
        serializer.save(job_seeker=job_seeker, recruiter=recruiter, is_approved=is_approved)


class SendMessageView(generics.CreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = MessageSerializer

    def perform_create(self, serializer):
        user = self.request.user
        chat_room = ChatRoom.objects.get(id=self.kwargs['chat_room_id'])

       
        receiver = chat_room.recruiter.user if chat_room.job_seeker.user == user else chat_room.job_seeker.user

        serializer.save(sender=user, receiver=receiver, chat_room=chat_room)

        if user == chat_room.recruiter.user:
            chat_room.is_approved = True
            chat_room.save()

class ChatRoomListView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ChatRoomSerializer

    def get_queryset(self):
        user = self.request.user
        return ChatRoom.objects.filter(Q(job_seeker__user=user) | Q(recruiter__user=user))

class DeleteChatRoomView(generics.DestroyAPIView):
    permission_classes = [IsAuthenticated]
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer

#  -------------

class ChatRoomAPIView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]

    def list(self, request, *args, **kwargs):
        user = request.user

        if user.role == "recruiter":
            chat_rooms = ChatRoom.objects.filter(recruiter=user.recruiter)
        elif user.role == "job_seeker":
            chat_rooms = ChatRoom.objects.filter(job_seeker=user.job_seeker)
        else:
            return Response({'detail': 'Invalid user role'}, status=400)
        
        # Annotate each chat room with the timestamp of its most recent message
        chat_rooms = chat_rooms.annotate(
            most_recent_message_timestamp=Max('messages__timestamp')
        ).order_by('-most_recent_message_timestamp')

        # Serialize the data
        if user.role == "recruiter":
            serializer = RecruiterChatRoomSerializer(chat_rooms, many=True)
        else:
            serializer = JobSeekerChatRoomSerializer(chat_rooms, many=True)

        return Response(serializer.data, status=200)

    def post(self, request, *args, **kwargs):
        job_seeker_id = self.kwargs.get('job_seeker_id')
        recruiter = get_object_or_404(Recruiter, user=request.user)
        job_seeker = get_object_or_404(JobSeeker, id=job_seeker_id)

        # Get or create the chat room
        chat_room, created = ChatRoom.objects.get_or_create(recruiter=recruiter, job_seeker=job_seeker)
        
        if not created:
            # If the chat room already exists, return its messages
            messages = Message.objects.filter(chat_room=chat_room).order_by('timestamp')
            serializer = MessageSerializer(messages, many=True, context={'request': request})
            return Response(serializer.data, status=200)
        
        # If the chat room was newly created, serialize and return the chat room details
        serializer = RecruiterChatRoomSerializer(chat_room, context={'request': request})
        return Response(serializer.data, status=201)

class ChatRoomMessageAPIView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = MessageSerializer

    def list(self, request, *args, **kwargs):
        chat_room_id = self.kwargs.get('chat_room_id')
        chat_room = get_object_or_404(ChatRoom, id=chat_room_id)

        messages = Message.objects.filter(chat_room=chat_room).order_by('timestamp')
        serializer = MessageSerializer(messages, many=True, context={'request': request})
        return Response(serializer.data, status=200)

    def post(self, request, *args, **kwargs):
        chat_room_id = self.kwargs.get('chat_room_id')
        chat_room = get_object_or_404(ChatRoom, id=chat_room_id)

        user = request.user
        if user.role == "job_seeker":
            receiver = chat_room.recruiter.user
        elif user.role == "recruiter":
            receiver = chat_room.job_seeker.user
        else:
            return Response({'detail': 'Invalid user role'}, status=400)

        message = Message.objects.create(
            chat_room=chat_room,
            sender=user,
            receiver=receiver,
            content=request.data['content']
        )
        return Response({'detail': 'Successfully sent message!'}, status=201)
    
    def get_serializer_context(self):
     return {'request':self.request}
 
 
class GetChatRoomWithJobSeeker(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = MessageSerializer

    def list(self, request, *args, **kwargs):
        job_seeker_id = self.kwargs.get('job_seeker_id')
        try:
            jobSeekerInst = JobSeeker.objects.get(id = job_seeker_id)
        except JobSeeker.DoesNotExist:
            return Response({'detail':'Job seeker not found'}, status=404)
        chat_room = get_object_or_404(ChatRoom, job_seeker=jobSeekerInst)

        messages = Message.objects.filter(chat_room=chat_room).order_by('timestamp')
        serializer = MessageSerializer(messages, many=True, context={'request': request})
        return Response(serializer.data, status=200)