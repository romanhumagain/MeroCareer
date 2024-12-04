from django.db import models
from base.models import User
from recruiter.models import Recruiter

def category_image_upload_to(instance, filename):
  return f"job_category/{filename}"

class JobCategory(models.Model):
  category = models.CharField(max_length=100, unique=True);
  image = models.ImageField(upload_to=category_image_upload_to)
  
  def __str__(self):
    return self.category

  
class Job(models.Model):
  recruiter = models.ForeignKey(Recruiter, on_delete=models.CASCADE, related_name='recruiter_job_posts')
  category = models.ForeignKey(JobCategory, on_delete=models.CASCADE, related_name='job_post')
  job_title = models.CharField(max_length=255)
  no_of_vacancy = models.PositiveIntegerField()
  degree = models.CharField(max_length=255)
  deadline = models.DateTimeField()
  job_type = models.CharField(max_length=255)
  job_level = models.CharField(max_length=255)
  job_requirement = models.TextField()
  experience = models.PositiveIntegerField(null=True, blank=True)
  salary_range = models.CharField(max_length=255, null=True, blank=True)
  
  def __str__(self):
    return self.job_title
  
  
class RequiredSkill(models.Model):
  name = models.CharField(max_length=255)
  job = models.ForeignKey(Job, on_delete=models.CASCADE)
  
  def __str__(self):
    return self.name
  

