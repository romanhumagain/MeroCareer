from django.db import models
from jobs.models import Job
from job_seeker.models import JobSeeker


class Applicant(models.Model):
  STATUS_CHOICES = [
        ('Under Review', 'Under Review'),
        ('Reviewed', 'Reviewed'),
        ('Shortlisted', 'Shortlisted'),
        ('Interview Scheduled', 'Interview Scheduled'),
        ('Accepted', 'Accepted'),
        ('Rejected', 'Rejected'),
    ]
  user = models.ForeignKey(JobSeeker, on_delete = models.CASCADE, related_name='applied_jobs')
  job = models.ForeignKey(Job, on_delete = models.CASCADE, related_name='applicants')
  applied_on = models.DateTimeField(auto_now_add=True)
  status = models.CharField(
        max_length=50,
        choices=STATUS_CHOICES,
        default='Under Review'
    )
  
  class Meta:
    unique_together = ('user', 'job')
    
  def __str__(self):
        return f"{self.user.username} - {self.job.job_title} ({self.status})"
  
  
class SavedJob(models.Model):
  user = models.ForeignKey(JobSeeker, on_delete=models.CASCADE, related_name='saved_posts')
  job = models.ForeignKey(Job, on_delete=models.CASCADE, related_name='saved_by_user')
  saved_at = models.DateTimeField(auto_now_add=True)
  
  def __str__(self) -> str:
     return f"{self.job.job_title} saved by {self.user.full_name} "
   
  class Meta:
    unique_together = ('user', 'job')
    ordering = ['-saved_at']