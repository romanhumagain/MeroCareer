from rest_framework import serializers
from .models import ChatRoom, Message
from job_seeker.models import JobSeeker
from recruiter.models import Recruiter
from job_seeker.serializers import JobSeekerSerializer
from recruiter.serializers import RecruiterSerializer

class MessageSerializer(serializers.ModelSerializer):
    is_sent_by_me = serializers.SerializerMethodField(read_only = True)
    
    class Meta:
        model = Message
        fields = ['id', 'chat_room', 'sender', 'receiver', 'content', 'timestamp', 'is_read', 'is_sent_by_me']
        read_only_fields = ['id', 'chat_room', 'sender', 'receiver', 'timestamp', 'is_read']

    def get_is_sent_by_me(self, obj):
        request = self.context.get('request')
        return obj.sender == request.user
        

class ChatRoomSerializer(serializers.ModelSerializer):
    job_seeker = JobSeekerSerializer(read_only=True)
    recruiter = RecruiterSerializer(read_only=True)
    messages = MessageSerializer(many=True, read_only=True)

    class Meta:
        model = ChatRoom
        fields = ['id', 'job_seeker', 'recruiter', 'created_at', 'messages']

class JobSeekerChatRoomSerializer(serializers.ModelSerializer):
    last_message = serializers.SerializerMethodField(read_only = True)
    is_unread = serializers.SerializerMethodField(read_only = True)
    last_message_date = serializers.SerializerMethodField(read_only = True)
    profile_image = serializers.SerializerMethodField(read_only = True)
    sender_name = serializers.SerializerMethodField(read_only = True)
    
    
    class Meta:
        model = ChatRoom
        fields = ['id', 'job_seeker', 'recruiter', 'created_at', 'last_message', 'is_unread', 'last_message_date', 'sender_name', 'profile_image']
        
        
    def get_last_message(self, obj):
        messageInst =  Message.objects.filter(chat_room = obj).order_by('-timestamp').first()
        return messageInst.content
    
    def get_is_unread(self, obj):
        request = self.context.get('request') 
        return Message.objects.filter(chat_room = obj, is_read = False, receiver = request.user ).exists()
    
    def get_last_message_date(self, obj):
        messageInst =  Message.objects.filter(chat_room = obj).order_by('-timestamp').first()
        return messageInst.timestamp 
    
    def get_sender_name(self, obj):
        return obj.recruiter.company_name
    
    def get_profile_image(self, obj):
        request = self.context.get('request') 
        profile_image = obj.recruiter.company_profile_image
        return request.build_absolute_uri(profile_image.url) if request else profile_image.url
    

    
class RecruiterChatRoomSerializer(serializers.ModelSerializer):
    last_message = serializers.SerializerMethodField(read_only = True)
    is_unread = serializers.SerializerMethodField(read_only = True)
    last_message_date = serializers.SerializerMethodField(read_only = True)
    profile_image = serializers.SerializerMethodField(read_only = True)
    sender_name = serializers.SerializerMethodField(read_only = True)
    
    class Meta:
        model = ChatRoom
        fields = ['id', 'job_seeker', 'recruiter', 'created_at','last_message', 'is_unread', 'last_message_date', 'sender_name', 'profile_image']
        
    def get_last_message(self, obj):
        messageInst =  Message.objects.filter(chat_room = obj).order_by('-timestamp').first()
        return messageInst.content
    
    def get_is_unread(self, obj):
        request = self.context.get('request') 
        return Message.objects.filter(chat_room = obj, is_read = False, receiver = request.user ).exists()
    
    def get_last_message_date(self, obj):
        messageInst =  Message.objects.filter(chat_room = obj).order_by('-timestamp').first()
        return messageInst.timestamp 
    
    def get_sender_name(self, obj):
        return obj.job_seeker.full_name

    def get_profile_image(self, obj):
        request = self.context.get('request') 
        profile_image = obj.job_seeker.profile_image
        return request.build_absolute_uri(profile_image.url) if request else profile_image.url
    
