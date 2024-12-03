from django.db import models
from base.models import User

def profile_image_upload_to(instance, filename):
  return f'company/{instance.company_name}/{filename}'

class RecruiterProfile(models.Model):
  user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='recruiter_profile')
  company_profile_image = models.ImageField(upload_to=profile_image_upload_to, default='profile/default_profile_pic.webp' )
  company_name = models.CharField(max_length=200)
  phone_number = models.CharField(max_length=15)
  address = models.TextField()
  company_type = models.CharField(max_length=255)
  registration_number = models.CharField(max_length=50)
  pan_number = models.CharField(max_length=50)
  company_summary = models.TextField(null=True, blank=True)
  is_approved = models.BooleanField(default=True)
  
  
  def __str__(self):
    return f"{self.company_name} Profile"