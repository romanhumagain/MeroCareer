from django.db import models
from base.models import User
from jobs.models import JobCategory
from datetime import date
from django.utils.timezone import now
from django.core.exceptions import ValidationError

def profile_image_upload_to(instance, filename):
  return f'profile/{instance.username}/{filename}'


class JobSeeker(models.Model):
  user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='job_seeker')
  profile_image = models.ImageField(upload_to=profile_image_upload_to, default='profile/default_profile_pic.png')
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
  
  
class EducationDetail(models.Model):
  user = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_education_details')
  degree_type = models.CharField(max_length=255)
  education_program= models.CharField(max_length=255)
  institute_name = models.CharField(max_length=255)
  start_date = models.DateField()
  end_date = models.DateField(null=True, blank=True)
  
  @property
  def is_currently_studying(self):
    if self.end_date:
        return date.today() < self.end_date
    return True
  
  def __str__(self):
    return f"{self.user.full_name} {self.degree_type} education details"
  
  class Meta:
    unique_together = ('user','degree_type', 'education_program', 'institute_name'   )

class ExperienceDetail(models.Model):
  user = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_experience_details')
  job_title = models.CharField(max_length=255)
  job_role = models.CharField(max_length=255)
  institute_name = models.CharField(max_length=255)
  start_date = models.DateField()
  end_date = models.DateField(null=True, blank=True)
  
  @property
  def duration(self):
    end_date = self.end_date or date.now()
    delta = end_date - self.start_date
    return delta.days // 30
  
  @property
  def is_currently_working(self):
    if self.end_date:
        return date.today() < self.end_date
    return True
  
  
  def __str__(self):
    return f"{self.user.full_name} {self.job_title} job details"
  
  class Meta:
    unique_together = ('user','job_title', 'institute_name' )
  
  
class ProjectDetail(models.Model):
  user = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_project_details')
  project_title = models.CharField(max_length=255)
  role = models.CharField(max_length=255)
  project_description = models.TextField()
  
  def __str__(self):
    return f"{self.user.full_name} {self.project_title} project details"
  
  class Meta:
    unique_together = ('user','project_title' )
    
class Skill(models.Model):
  user = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_skill_details')
  name = models.CharField(max_length=255)

  def __str__(self):
    return f"{self.user.username} skill: - {self.name}"

  class Meta:
    unique_together = ('user', 'name')


def resume_upload_to(instance, filename):
    return f'resume/{instance.user.username}/{filename}'

class Resume(models.Model):
    user = models.OneToOneField(
        JobSeeker, on_delete=models.CASCADE, related_name='resume'
    )
    resume_file = models.FileField(upload_to=resume_upload_to, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Resume of {self.user.full_name}"

    @property
    def is_updated_recently(self):
        return (now() - self.updated_at).days <= 30


class AccountSetting(models.Model):
  user = models.OneToOneField(JobSeeker, on_delete=models.CASCADE, related_name='job_seeker_settings')
  new_job_alert = models.BooleanField(default= True)
  job_application_status_alert = models.BooleanField(default=True)
  job_recommendation_alert = models.BooleanField(default=True)
  updated_at = models.DateTimeField(auto_now=True)
  
  def __str__(self):
    return f"{self.user.username} account settings"