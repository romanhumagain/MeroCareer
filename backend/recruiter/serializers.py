from rest_framework.serializers import ModelSerializer
from .models import Recruiter
from rest_framework import serializers
from base.models import User


class UserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ['id','email', 'role', 'is_verified']
    
class RecruiterSerializer(ModelSerializer):
  user_details = UserSerializer(read_only = True, source = 'user')
  class Meta:
    model = Recruiter
    fields = ['id','user','company_profile_image','company_name','phone_number', 'address','company_type', 'registration_number','pan_number','company_summary', 'linkedin_link','website_link' ,'is_approved', 'user_details']
    
    read_only_fields = [
      'id', 'is_approved', 'user'
    ]
