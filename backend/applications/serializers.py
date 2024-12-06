from rest_framework import serializers
from applications.models import Applicant
from jobs.serializers import JobSerializer


class ApplicantSerializer(serializers.ModelSerializer):
  job_details = JobSerializer(read_only = True, source ='job' )
  
  class Meta:
    model = Applicant
    fields = ['id', 'user', 'job', 'status', 'applied_on', 'job_details' ]
    read_only_fields = ['user']
    