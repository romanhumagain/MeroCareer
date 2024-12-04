from django.db import models
from base.models import User
from jobs.models import JobCategory

def profile_image_upload_to(instance, filename):
  return f'profile/{instance.username}/{filename}'

class JobSeeker(models.Model):
  user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='job_seeker')
  profile_image = models.ImageField(upload_to=profile_image_upload_to, default='profile/default_profile_pic.webp')
  full_name = models.CharField(max_length=150)
  username = models.CharField(max_length=150)
  phone_number = models.CharField(max_length=15)
  address = models.TextField()
  profile_headline = models.CharField(max_length=255, blank=True, null=True)
  profile_summary = models.TextField( blank=True, null=True)
  
  def __str__(self):
    return f"{self.full_name} Profile"
  
  
class CareerPreference(models.Model):
  user = models.OneToOneField(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_career_preference')
  prefered_job_category = models.ForeignKey(JobCategory, on_delete=models.CASCADE)
  prefered_job_title = models.CharField(max_length=225, null=True,blank=True)
  prefered_job_location = models.CharField(max_length=225, null=True,blank=True)
  expected_salary = models.PositiveIntegerField(null=True,blank=True)
  prefered_job_level = models.CharField(max_length=225, null=True,blank=True)
  prefered_job_type = models.CharField(max_length=225, null=True,blank=True)
  
  def __str__(self):
    return f"{self.user.full_name} preference for {self.prefered_job_category.category}"