from rest_framework.serializers import ModelSerializer
from .models import Recruiter
from rest_framework import serializers
from base.models import User
from applications.models import Applicant


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


class RecruiterApplicantSerializer(serializers.ModelSerializer):
  from job_seeker.serializers import JobSeekerSerializer
  
  job_title = serializers.SerializerMethodField(read_only = True)
  deadline = serializers.SerializerMethodField(read_only = True)
  applicant_details = JobSeekerSerializer(read_only = True, source = 'user')
  
  class Meta:
    model = Applicant
    fields = ['id', 'user', 'job', 'status', 'applied_on', 'job_title', 'deadline', 'applicant_details' ]
    read_only_fields = ['user', 'job_details']
    
  def get_job_title(self, obj):
    if obj is not None:
      return obj.job.job_title
    return None
  
  def get_deadline(self, obj):
    if obj is not None:
      return obj.job.deadline
    return None
  
from jobs.models import Job
from job_seeker.serializers import JobSeekerSerializer
class ActiveJobWithApplicantsSerializer(serializers.ModelSerializer):
    application = serializers.SerializerMethodField()

    class Meta:
        model = Job
        fields = ['id', 'job_title', 'deadline', 'no_of_vacancy', 'job_type', 'is_active', 'application']

    def get_application(self, obj):
        # Fetch applicants specific to the job
        applications = Applicant.objects.filter(job=obj).select_related('user')

        # Serialize using RecruiterApplicantSerializer
        return RecruiterApplicantSerializer(applications, many=True).data
