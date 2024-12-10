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
    user_details = RecruiterSerializer(read_only = True, source = 'recruiter')
    
    class Meta:
        model = ChatRoom
        fields = ['id', 'job_seeker', 'recruiter', 'created_at', 'user_details']
        
class RecruiterChatRoomSerializer(serializers.ModelSerializer):
    user_details = JobSeekerSerializer(read_only = True, source = 'job_seeker')
    
    class Meta:
        model = ChatRoom
        fields = ['id', 'job_seeker', 'recruiter', 'created_at', 'user_details']