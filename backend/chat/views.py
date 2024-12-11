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
from rest_framework.views import APIView


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
        
        
        chat_rooms = chat_rooms.annotate(
            most_recent_message_timestamp=Max('messages__timestamp')
        ).order_by('-most_recent_message_timestamp')

    
        if user.role == "recruiter":
            serializer = RecruiterChatRoomSerializer(chat_rooms, many=True, context={'request': request})
        else:
            serializer = JobSeekerChatRoomSerializer(chat_rooms, many=True, context={'request': request})

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
 
 
class MarkAllMessagesAsReadView(APIView):
    permission_class = [IsAuthenticated]

    def post(self, request):
        chat_room_id = request.data.get('room_id')

        if not chat_room_id:
            return Response({"error": "chat_room_id is required"}, status=status.HTTP_400_BAD_REQUEST)

        room = ChatRoom.objects.get(id = chat_room_id)
        
        unread_messages = Message.objects.filter(chat_room=room, receiver=request.user, is_read=False)
        if not unread_messages.exists():
            return Response({"message": "No unread messages to mark"}, status=status.HTTP_200_OK)

        unread_messages.update(is_read=True)
        return Response({"message": "All unread messages marked as read"}, status=status.HTTP_200_OK)
  
  
class UnreadChatRoomsCountView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
       
        user = request.user
        if user.role == "job_seeker": 
            chat_rooms = ChatRoom.objects.filter(job_seeker=request.user.job_seeker) 
        elif user.role == "recruiter":
            chat_rooms = ChatRoom.objects.filter(recruiter=request.user.recruiter) 
            
        unread_chat_rooms = chat_rooms.filter(
            messages__receiver=request.user,
            messages__is_read=False
        ).distinct()

        count = unread_chat_rooms.count()

        return Response({"unread_chat_rooms_count": count}, status=status.HTTP_200_OK)
      
 
class GetChatRoomWithJobSeeker(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = MessageSerializer

    def list(self, request, *args, **kwargs):
        job_seeker_id = self.kwargs.get('job_seeker_id')
        try:
            jobSeekerInst = JobSeeker.objects.get(id = job_seeker_id)
        except JobSeeker.DoesNotExist:
            return Response({'detail':'Job seeker not found'}, status=404)
        chat_room = get_object_or_404(ChatRoom, job_seeker=jobSeekerInst, recruiter = request.user.recruiter)

        messages = Message.objects.filter(chat_room=chat_room).order_by('timestamp')
        serializer = MessageSerializer(messages, many=True, context={'request': request})
        return Response(serializer.data, status=200)
    
class ChatRoomWithJobseekerAPIView(generics.CreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = MessageSerializer

    
    def post(self, request, *args, **kwargs):
        job_seeker_id = self.kwargs.get('job_seeker_id')
        
        try:
            jobSeekerInst = JobSeeker.objects.get(id=job_seeker_id)
        except JobSeeker.DoesNotExist:
            return Response({'detail': 'Job seeker not found'}, status=404)
        
    
        chat_room, created = ChatRoom.objects.get_or_create(
            job_seeker=jobSeekerInst,
            recruiter=request.user.recruiter
        )
        
        message = Message.objects.create(
            chat_room=chat_room,
            sender=request.user,
            receiver=jobSeekerInst.user,
            content=request.data['content']
        )
        
        message.save()
        return Response({'detail': 'Successfully sent message!'}, status=201)