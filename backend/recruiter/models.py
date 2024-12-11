from django.db import models
from base.models import User

def profile_image_upload_to(instance, filename):
  return f'company/{instance.company_name}/{filename}'

class Recruiter(models.Model):
  user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='recruiter')
  company_profile_image = models.ImageField(upload_to=profile_image_upload_to, default='profile/default_company_pic.png' )
  company_name = models.CharField(max_length=200)
  phone_number = models.CharField(max_length=15)
  address = models.TextField()
  company_type = models.CharField(max_length=255)
  registration_number = models.CharField(max_length=50)
  pan_number = models.CharField(max_length=50)
  company_summary = models.TextField(null=True, blank=True)
  linkedin_link = models.CharField(max_length=255, null=True, blank=True, unique=True)
  website_link = models.CharField(max_length=255, null=True, blank=True, unique=True)
  
  is_approved = models.BooleanField(default=False)
  
  
  def __str__(self):
    return f"{self.company_name} Profile"