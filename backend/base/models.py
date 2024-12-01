from django.db import models
from django.contrib.auth.models import AbstractBaseUser,PermissionsMixin
from utils.slug_utils import generate_slug
from .manager import UserManager

class User(AbstractBaseUser, PermissionsMixin):
  ROLE_CHOICES = [
    ('job_seeker','Job Seeker'),
    ('recruiter','Recruiter'),
    ('admin','Admin'),
  ]
  
  
  slug = models.SlugField(unique=True)
  full_name = models.CharField(max_length = 100)
  username = models.CharField(max_length=100, unique = True)
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
  REQUIRED_FIELDS = ['username', 'full_name']
  
  objects = UserManager()
  
  def save(self, *args, **kwargs):
    if not self.pk:
      self.slug = generate_slug(User, self.username)
    return super().save(*args, **kwargs)
      
  def __str__(self):
    return self.email
  
  
  
  