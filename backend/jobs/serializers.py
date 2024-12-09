from rest_framework.serializers import ModelSerializer
from .models import JobCategory, Job, RequiredSkill,RecentSearch
from rest_framework import serializers
from recruiter.serializers import RecruiterSerializer
from recruiter.models import Recruiter


class JobCategorySerializer(ModelSerializer):
  class Meta:
    model = JobCategory
    fields = '__all__'
    
class RequiredSkillSerializer(ModelSerializer):
  class Meta:
    model = RequiredSkill
    fields = '__all__'
    
# ===== Recruiter Profile Serializer for showing specific details in the job details
class RecruiterSerializer(ModelSerializer):
  class Meta:
    model = Recruiter
    fields = ['company_profile_image','company_name','address','company_type','company_summary', 'linkedin_link','website_link']

class JobSerializer(ModelSerializer):
    skills_display = serializers.SerializerMethodField()
    recruiter_details = RecruiterSerializer(read_only=True, source = 'recruiter')
    category_name = serializers.SerializerMethodField(read_only = True)
    class Meta:
        model = Job
        fields = [
            'id', 'recruiter', 'category', 'job_title', 'no_of_vacancy', 'degree',
            'deadline', 'job_type', 'job_level', 'job_requirement', 'experience',
            'salary_range', 'skills_display', 'recruiter_details', 'is_active','category_name'
        ]
        read_only_fields = ['id', 'skills_display', 'recruiter_details', 'is_active']

    def get_skills_display(self, obj):
        skills = RequiredSkill.objects.filter(job=obj)
        return [skill.name for skill in skills]
      
    def get_category_name(self, obj):
      return obj.category.category
    
    
# ====== OrganizationBasedJob =============
class OrganizationBasedJob(serializers.ModelSerializer):
  
  class Meta:
    model = JobCategory
    fields = ['id', 'name']
    
    
class RecentSearchSerializer(ModelSerializer):
    searched_job_details = JobSerializer(read_only = True, source ='searched_job')
    
    class Meta:
        model = RecentSearch
        fields = ['searched_by', 'searched_at', 'searched_job', 'searched_job_details'] 
        

        