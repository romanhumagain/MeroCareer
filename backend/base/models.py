from django.db import models
from django.contrib.auth.models import AbstractBaseUser,PermissionsMixin
from utils.slug_utils import generate_slug
from .manager import UserManager
from django.utils import timezone
from datetime import timedelta

class User(AbstractBaseUser, PermissionsMixin):
  ROLE_CHOICES = [
    ('job_seeker','Job Seeker'),
    ('recruiter','Recruiter'),
    ('admin','Admin'),
  ]
  
  email = models.EmailField(unique = True)
  password = models.CharField(max_length = 255)
  is_verified = models.BooleanField(default = False)
  role = models.CharField(max_length=100, choices=ROLE_CHOICES, default='job_seeker')
  
  is_active = models.BooleanField(default = True)
  is_staff = models.BooleanField(default = False)
  is_superuser = models.BooleanField(default = False)
  
  date_joined = models.DateTimeField(auto_now_add = True)
  last_login = models.DateTimeField(auto_now = True)
  
  USERNAME_FIELD = 'email'
  REQUIRED_FIELDS = []
  
  objects = UserManager()
      
  def __str__(self):
    return self.email
  
  
class OTP(models.Model):
  user = models.ForeignKey(User, on_delete=models.CASCADE)
  otp = models.CharField(max_length=6)
  created_at = models.DateTimeField(auto_now_add=True)
  expires_at = models.DateTimeField()
  is_expired = models.BooleanField(default=False)
  
  def save(self, *args, **kwargs):
    OTP.objects.filter(user = self.user, is_expired = False).update(is_expired = True, expires_at = timezone.now())
    return super(OTP, self).save(*args, **kwargs)
  
  @property
  def has_expired(self):
    return timezone.now() > self.expires_at
  
  def __str__(self):
        return f"OTP for {self.user.email} - {self.otp}"