from django.db import models
from base.models import User

class Notification(models.Model):
    actor = models.ForeignKey(User, related_name='notifications_sent', on_delete=models.CASCADE)
    receiver = models.ForeignKey(User, related_name='notifications_received', on_delete=models.CASCADE)
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notification to {self.receiver.email}:- {self.message}"