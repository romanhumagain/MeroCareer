from django.db import models
from job_seeker.models import JobSeeker
from recruiter.models import Recruiter
from base.models import User


class ChatRoom(models.Model):
    job_seeker = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='chat_room')
    recruiter = models.ForeignKey(Recruiter, on_delete=models.CASCADE, related_name='chat_rooms')
    created_at = models.DateTimeField(auto_now_add=True)
    is_approved = models.BooleanField(default=True) 

    def __str__(self):
        return f"Chat Room between {self.job_seeker.full_name} and {self.recruiter.company_name}"

class Message(models.Model):
    chat_room = models.ForeignKey(ChatRoom, on_delete=models.CASCADE, related_name='messages')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_messages')
    receiver = models.ForeignKey(User, on_delete=models.CASCADE, related_name='received_messages')
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)

    def __str__(self):
        return f"Message from {self.sender.email} to {self.receiver.email} at {self.timestamp}"