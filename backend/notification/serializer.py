from rest_framework.serializers import ModelSerializer
from .models import Notification
from rest_framework import serializers

class NotificationSerializer(ModelSerializer):
    unread_notification_count = serializers.SerializerMethodField(read_only = True)
    profile_image = serializers.SerializerMethodField(read_only = True)
  
    class Meta:
        model = Notification
        fields = ['id','actor', 'receiver', 'message', 'is_read', 'created_at', 'unread_notification_count', 'profile_image' ]
        read_only_fields = ['unread_notification_count']
        
    def get_unread_notification_count(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
          user = request.user
          return Notification.objects.filter(receiver = user, is_read = False).count()
      
        return None
      
    from django.utils.functional import SimpleLazyObject

    def get_profile_image(self, obj):
        request = self.context.get('request')
        user = obj.actor
        
        if user.role == "job_seeker":
            profile_image = user.job_seeker.profile_image
        elif user.role == "recruiter":
            profile_image = user.recruiter.company_profile_image
        else:
            return None
        
        if profile_image:
            return request.build_absolute_uri(profile_image.url) if request else profile_image.url
        return None