from rest_framework.serializers import ModelSerializer
from .models import JobSeekerProfile, CareerPreference

class JobSeekerProfileSerializer(ModelSerializer):
  class Meta:
    model = JobSeekerProfile
    fields = '__all__'
