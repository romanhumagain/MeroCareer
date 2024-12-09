from rest_framework import serializers
from applications.models import Applicant, SavedJob
from job_seeker.serializers import JobSeekerJobSerializer
from jobs.serializers import JobSerializer


class ApplicantSerializer(serializers.ModelSerializer):
  job_details = JobSeekerJobSerializer(read_only = True, source ='job' )
  
  class Meta:
    model = Applicant
    fields = ['id', 'user', 'job', 'status', 'applied_on', 'job_details' ]
    read_only_fields = ['user', 'job_details']
    
class SavedJobSerializer(serializers.ModelSerializer):
    job = JobSeekerJobSerializer()

    class Meta:
        model = SavedJob
        fields = ['id', 'user', 'job', 'saved_at']
        
        
        
