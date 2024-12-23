from rest_framework.serializers import ModelSerializer
from .models import (JobSeeker, 
                     CareerPreference, 
                     EducationDetail,
                     ExperienceDetail,
                     ProjectDetail,
                     Skill, 
                     Resume, 
                     AccountSetting
                     )
from rest_framework import serializers

from recruiter.serializers import RecruiterSerializer
from jobs.models import Job, RequiredSkill
from applications.models import SavedJob
from recruiter.serializers import UserSerializer
from recruiter.models import Recruiter
from applications.models import Applicant
from django.db.models import Q

class JobSeekerJobSerializer(serializers.ModelSerializer):
  
    skills_display = serializers.SerializerMethodField()
    recruiter_details = RecruiterSerializer(read_only=True, source='recruiter')
    category_name = serializers.SerializerMethodField(read_only=True)
    is_saved = serializers.SerializerMethodField(read_only=True)
    email = serializers.SerializerMethodField(read_only = True)
    is_applied = serializers.SerializerMethodField(read_only = True)
    application_status = serializers.SerializerMethodField(read_only = True)
    
    class Meta:
        model = Job
        fields = [
            'id', 'recruiter', 'category', 'job_title', 'no_of_vacancy', 'degree',
            'deadline', 'job_type', 'job_level', 'job_requirement', 'experience',
            'salary_range', 'skills_display', 'recruiter_details', 'is_active', 'category_name','email', 'is_saved','is_applied', 'application_status'
        ]
        read_only_fields = ['id', 'skills_display', 'recruiter_details', 'is_active', 'email', 'application_status']

    def get_skills_display(self, obj):
        skills = RequiredSkill.objects.filter(job=obj)
        return [skill.name for skill in skills]
      
    def get_category_name(self, obj):
        return obj.category.category
    
    def get_is_saved(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
          user = request.user 
          return SavedJob.objects.filter(user=user.job_seeker, job=obj).exists()
        return False
      
    def get_is_applied(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
          user = request.user
          return Applicant.objects.filter(user = user.job_seeker, job = obj).exists()
        return False
      
    def get_application_status(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
          user = request.user
          applicantInst =  Applicant.objects.filter(user = user.job_seeker, job = obj).first()
          if applicantInst:
            return applicantInst.status
          return "Not Applied"
          
        return None
      
    def get_email(self, obj):
      return obj.recruiter.user.email


class JobSeekerSerializer(ModelSerializer):
  email = serializers.SerializerMethodField(read_only = True)
  prefered_job_category = serializers.SerializerMethodField(read_only = True)
  applied_job = serializers.SerializerMethodField(read_only = True)
  application_under_review = serializers.SerializerMethodField(read_only = True)
  
  
  class Meta:
    model = JobSeeker
    fields = ['id','user', 'profile_image','full_name','username','phone_number','address', 'profile_headline', 'profile_summary', 'email', 'prefered_job_category', 'applied_job', 'application_under_review']
    read_only_fields = ['user', 'email']

  def get_email(self, obj):
    if obj is not None:
      return obj.user.email
    return None
    
  def get_prefered_job_category(self,obj):
    if obj is not None:
      return obj.job_seeker_career_preference.prefered_job_category.id
    return None
  
  def get_application_under_review(self, obj):
    return Applicant.objects.filter(Q(user=obj) & (Q(status="Under Review") | Q(status="Reviewed"))).count()

  def get_applied_job(self, obj):
    return Applicant.objects.filter(user = obj).count()
  

    
class CareerPreferenceSerializer(ModelSerializer):
  prefered_job_category_name = serializers.SerializerMethodField(read_only = True)
  is_all_pref_added = serializers.SerializerMethodField(read_only = True)
  
  class Meta:
    model = CareerPreference
    fields = ['id', 'prefered_job_category', 'prefered_job_title', 'prefered_job_location', 'expected_salary', 'prefered_job_level', 'prefered_job_type', 'prefered_job_category_name', 'is_all_pref_added']
    
    read_only_fields = ['prefered_job_category','prefered_job_category_name' ]
    
  def get_prefered_job_category_name(self, obj):
    if obj is not None:
      return obj.prefered_job_category.category
    return None
  
  def get_is_all_pref_added(self, obj):
   
    all_pref_added = all([
        obj.prefered_job_title is not None and obj.prefered_job_title != '',
        obj.prefered_job_location is not None and obj.prefered_job_location != '',
        obj.expected_salary is not None and obj.expected_salary != '',
        obj.prefered_job_level is not None and obj.prefered_job_level != '',
        obj.prefered_job_type is not None and obj.prefered_job_type != ''
    ])
    
    return all_pref_added
  
  
class EducationDetailSerializer(serializers.ModelSerializer):
  class Meta:
    model = EducationDetail
    fields = ['id','user', 'degree_type', 'education_program', 'institute_name', 'start_date', 'end_date', 'is_currently_studying']
    read_only_fields = ['user', 'is_currently_studying']
    


class ExperienceDetailSerializer(serializers.ModelSerializer):
  class Meta:
    model = ExperienceDetail
    fields = ['id','user', 'job_title', 'job_role', 'institute_name', 'start_date', 'end_date', 'is_currently_working']
    read_only_fields = ['is_currently_working', 'duration', 'user']


class ProjectDetailSerializer(serializers.ModelSerializer):
  class Meta:
    model = ProjectDetail
    fields = ['id', 'user', 'project_title', 'role', 'project_description']
    read_only_fields = ['user']

class SkillSerializer(serializers.ModelSerializer):
  class Meta:
    model = Skill
    fields = ['id', 'user', 'name']

class ResumeSerializer(serializers.ModelSerializer):
  class Meta:
    model = Resume
    fields = ['id', 'user', 'resume_file', 'updated_at', 'created_at', 'is_updated_recently' ]
    read_only_fields = ['is_updated_recently']
    
    
class AccountSettingSerializer(serializers.ModelSerializer):
  class Meta:
    model = AccountSetting
    fields = ['id','user','new_job_alert', 'job_application_status_alert', 'job_recommendation_alert', 'updated_at' ]
    read_only_fields = ['id', 'updated_at', 'user']
    
    
    
#  serializer to get all user linked details for profile preview
class JobSeekerDetailedSerializer(serializers.ModelSerializer):
    email = serializers.SerializerMethodField(read_only=True)
    prefered_job_category = CareerPreferenceSerializer(read_only=True, source='job_seeker_career_preference')
    job_seeker_education_details = EducationDetailSerializer(read_only=True, many=True)
    job_seeker_experience_details = ExperienceDetailSerializer(read_only=True, many=True)
    job_seeker_project_details = ProjectDetailSerializer(read_only=True, many=True)
    job_seeker_skill_details = SkillSerializer(read_only=True, many=True)
    resume_details = serializers.SerializerMethodField(read_only=True)
    

    class Meta:
        model = JobSeeker
        fields = [
            'id', 'user', 'profile_image', 'full_name', 'username', 'phone_number',
            'address', 'profile_headline', 'profile_summary', 'email',
            'prefered_job_category', 'job_seeker_education_details', 
            'job_seeker_experience_details', 'job_seeker_project_details','resume_details',
            'job_seeker_skill_details'
        ]
        read_only_fields = ['user', 'email']

    def get_email(self, obj):
        return obj.user.email if obj else None
      
    def get_resume_details(self, obj):
      try:
          resume = Resume.objects.get(user=obj)
          serializer = ResumeSerializer(resume)
          return serializer.data
      except Resume.DoesNotExist:
          return {"resume_file": ""}



# ====== serializer to fetch the recruiter details along with the job posting by the recruiter
class RecruiterJobSerializer(serializers.ModelSerializer):
  
    is_saved = serializers.SerializerMethodField(read_only=True)
  
    class Meta:
        model = Job
        fields = [
            'id', 'category', 'job_title', 'no_of_vacancy', 'degree',
            'deadline', 'job_type', 'job_level', 'job_requirement', 'experience',
            'salary_range', 'is_active', 'is_saved'
        ]
        read_only_fields = ['id', 'is_active']
    
    def get_is_saved(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
          user = request.user 
          return SavedJob.objects.filter(user=user.job_seeker, job=obj).exists()
        return False


class RecruiterDetailedSerializer(ModelSerializer):
  user_details = UserSerializer(read_only = True, source = 'user')
  recruiter_job_posts = RecruiterJobSerializer(read_only = True, many = True)
  class Meta:
    model = Recruiter
    fields = ['id','user','company_profile_image','company_name','phone_number', 'address','company_type', 'registration_number','pan_number','company_summary', 'linkedin_link','website_link' ,'is_approved', 'user_details', 'recruiter_job_posts']
    
    read_only_fields = [
      'id', 'is_approved', 'user', 'recruiter_job_posts'
    ]
