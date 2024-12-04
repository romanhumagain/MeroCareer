from rest_framework.serializers import ModelSerializer
from .models import JobSeeker, CareerPreference

class JobSeekerSerializer(ModelSerializer):
  class Meta:
    model = JobSeeker
    fields = '__all__'
