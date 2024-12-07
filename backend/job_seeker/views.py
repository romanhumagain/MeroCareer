from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.views import APIView
from base.models import User
from job_seeker.models import (JobSeeker, 
                               CareerPreference, 
                               EducationDetail,
                               ExperienceDetail,
                               ProjectDetail,
                               Skill,
                               Resume)
from base.serializers import RegisterUserSerializer
from django.db import transaction
from jobs.models import JobCategory
from rest_framework.exceptions import ValidationError
from .serializers import (JobSeekerSerializer, 
                          CareerPreferenceSerializer, 
                          EducationDetailSerializer, 
                          ExperienceDetailSerializer, 
                          ProjectDetailSerializer,
                          SkillSerializer, 
                          ResumeSerializer,
                          AccountSettingSerializer, 
                          JobSeekerDetailedSerializer)
from rest_framework.exceptions import NotFound, PermissionDenied
from django.shortcuts import get_object_or_404
from rest_framework import viewsets
from job_seeker.permissions   import IsJobSeeker
from .models import AccountSetting

class RegisterJobSeekerAPIView(generics.CreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterUserSerializer

    def create(self, request, *args, **kwargs):
        data = request.data
        serializer = self.get_serializer(data=data)

        try:
            if serializer.is_valid():
                with transaction.atomic():
                    
                    user = serializer.save()

                    jobSeekerInst = JobSeeker.objects.create(
                        user=user,
                        full_name=data['full_name'],
                        username=data['username'],
                        phone_number=data['phone_number'],
                        address=data['address'],
                    )
                    
                    accountSetting = AccountSetting.objects.create(user = jobSeekerInst)
                    accountSetting.save()
                    
                    try:
                        jobCategory = JobCategory.objects.get(id=data['prefered_job_category'])
                        
                        CareerPreference.objects.create(
                            user=jobSeekerInst,
                            prefered_job_category=jobCategory
                        )
                    except JobCategory.DoesNotExist:
                        raise ValidationError({"detail": "Job category doesn't exist."})

                return Response({'detail': 'Successfully Registered Job Seeker'}, status=status.HTTP_201_CREATED)
            
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        
class JobSeekerRetriveUpdateDeleteAPIView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSeekerSerializer
    
    def get_object(self):
        if self.request.user.role != "job_seeker":
            raise PermissionDenied("You are not a authorized user for this !")
        try:
            jobSeekerInst =  JobSeeker.objects.get(user = self.request.user)
            return jobSeekerInst
        except JobSeeker.DoesNotExist:
            raise NotFound("User not found !")
    
    def retrieve(self, request, *args, **kwargs):
        jobSeekerInst = self.get_object()

        serializer = self.get_serializer(jobSeekerInst)
        return Response(serializer.data, status=status.HTTP_200_OK)
     
    
    def update(self, request, *args, **kwargs):
        jobSeekerInst = self.get_object()
        data = request.data
        
        serializer = self.get_serializer(instance = jobSeekerInst, data = request.data, partial =True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

              
    def delete(self, request, *args, **kwargs):
        jobSeekerInst = self.get_object()
        jobSeekerInst.user.is_active = False
        jobSeekerInst.user.save()
        jobSeekerInst.save()
        
        return Response({'detail':'Successfully deactivated your account !'}, status=status.HTTP_200_OK)


class JobSeekerRetriveAPIView(generics.RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSeekerDetailedSerializer
    lookup_field = 'id'
    
    def retrieve(self, request, *args, **kwargs):
        id = self.kwargs.get('id')
        
        try:
            jobSeekerInst = JobSeeker.objects.get(id = id)
        except JobSeeker.DoesNotExist:
            return Response({'detail':"Job seeker doesn't exists !"})
            
        serializer = self.get_serializer(jobSeekerInst)
        return Response(serializer.data, status=status.HTTP_200_OK)
     
             
class CareerPreferenceAPIView(generics.RetrieveUpdateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = CareerPreferenceSerializer
    
    def get_object(self):
        if self.request.user.role != "job_seeker":
            raise PermissionDenied("You are not a authorized user for this !")
        try:
            jobSeekerInst =  JobSeeker.objects.get(user = self.request.user)
            try:
                careerPrefInst =  CareerPreference.objects.get(user = jobSeekerInst)
                return careerPrefInst
            except CareerPreference.DoesNotExist:
                raise NotFound("Career Preference Not Found !")
        except JobSeeker.DoesNotExist:
            raise NotFound("User not found !")
        
        
    def retrieve(self, request, *args, **kwargs):
        careerPrefInst = self.get_object()
        serializer = self.get_serializer(careerPrefInst)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def update(self, request, *args, **kwargs):
        careerPrefInst = self.get_object()
        data = request.data
        print(data)
        
        prefered_job_category = data.get('prefered_job_category', None)
        
        with transaction.atomic():
            if prefered_job_category:
                try:
                    jobCategoryInst = JobCategory.objects.get(id = prefered_job_category )
                    careerPrefInst.prefered_job_category = jobCategoryInst
                except JobCategory.DoesNotExist:
                    return Response({'detail':'Job Category not Found !'}, status=status.HTTP_400_BAD_REQUEST)
            
            serializer = self.get_serializer(instance = careerPrefInst, data = data, partial = True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

class EducationDetailViewSet(viewsets.ModelViewSet):
    serializer_class = EducationDetailSerializer
    queryset = EducationDetail.objects.all()
    permission_classes = [IsAuthenticated, IsJobSeeker]
    lookup_field = 'id'

    def get_queryset(self):
        return EducationDetail.objects.filter(user=self.request.user.job_seeker).order_by('-start_date')
        

    def perform_create(self, serializer):
        serializer.save(user=self.request.user.job_seeker)
        
class ExperienceDetailViewSet(viewsets.ModelViewSet):
    serializer_class = ExperienceDetailSerializer
    queryset = ExperienceDetail.objects.all()
    permission_classes = [IsAuthenticated, IsJobSeeker]
    lookup_field = 'id'

    def get_queryset(self):
        return ExperienceDetail.objects.filter(user=self.request.user.job_seeker).order_by('-start_date')
       
    def perform_create(self, serializer):
        serializer.save(user=self.request.user.job_seeker)
    
        
    
class ProjectDetailViewSet(viewsets.ModelViewSet):
    serializer_class = ProjectDetailSerializer
    queryset = ProjectDetail.objects.all()
    permission_classes = [IsAuthenticated, IsJobSeeker]
    lookup_field = 'id'

    def get_queryset(self):
        return ProjectDetail.objects.filter(user=self.request.user.job_seeker).order_by('-id')
       
    def perform_create(self, serializer):
        serializer.save(user=self.request.user.job_seeker)
        
class SkillAPIView(APIView):
    permission_classes = [IsAuthenticated]  

    def get(self, request, *args, **kwargs):
        """Retrieve all skills of the logged-in user."""
        if not hasattr(request.user, 'job_seeker'):
            return Response({'detail': 'JobSeeker profile not found.'}, status=status.HTTP_400_BAD_REQUEST)

        skills = Skill.objects.filter(user=request.user.job_seeker)
        serializer = SkillSerializer(skills, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        """Add new skills."""
        if not hasattr(request.user, 'job_seeker'):
            return Response({'detail': 'JobSeeker profile not found.'}, status=status.HTTP_400_BAD_REQUEST)

        data = request.data.get('skills', [])
        if not isinstance(data, list):
            return Response({'detail': 'Invalid data format. Provide a list of skills.'}, status=status.HTTP_400_BAD_REQUEST)

        responses = []
        job_seeker = request.user.job_seeker

        for skill_name in data:
            skill_data = {
                'user': job_seeker.id,
                'name': skill_name.strip().lower()
            }
            serializer = SkillSerializer(data=skill_data)
            if serializer.is_valid():
                serializer.save()
            else:
                responses.append({skill_name: serializer.errors})

        if responses:
            return Response({'errors': responses}, status=status.HTTP_400_BAD_REQUEST)

        return Response({'detail': 'Successfully added skills'}, status=status.HTTP_201_CREATED)

    def put(self, request, *args, **kwargs):
        if not hasattr(request.user, 'job_seeker'):
            return Response({'detail': 'JobSeeker profile not found.'}, status=status.HTTP_400_BAD_REQUEST)

        skills = request.data.get('skills', [])
        if not isinstance(skills, list):
            return Response({'detail': 'Invalid data format. Provide a list of skills.'}, status=status.HTTP_400_BAD_REQUEST)

        job_seeker = request.user.job_seeker
        Skill.objects.filter(user=job_seeker).delete() 

        responses = []
        for skill_name in skills:
            skill_data = {
                'user': job_seeker.id,
                'name': skill_name.strip().lower()
            }
            serializer = SkillSerializer(data=skill_data)
            if serializer.is_valid():
                serializer.save()
            else:
                responses.append({skill_name: serializer.errors})

        if responses:
            return Response({'errors': responses}, status=status.HTTP_400_BAD_REQUEST)

        return Response({'detail': 'Successfully replaced skills'}, status=status.HTTP_200_OK)

    def delete(self, request, *args, **kwargs):

        if not hasattr(request.user, 'job_seeker'):
            return Response({'detail': 'JobSeeker profile not found.'}, status=status.HTTP_400_BAD_REQUEST)

        job_seeker = request.user.job_seeker
        Skill.objects.filter(user=job_seeker).delete()
        return Response({'detail': 'All skills deleted successfully.'}, status=status.HTTP_200_OK)
       
class ResumeViewSet(viewsets.ModelViewSet):
    serializer_class = ResumeSerializer
    queryset = Resume.objects.all()
    permission_classes = [IsAuthenticated, IsJobSeeker]
    lookup_field = 'id'

    def get_queryset(self):
        return Resume.objects.filter(user=self.request.user.job_seeker)
       
    def perform_create(self, serializer):
        serializer.save(user=self.request.user.job_seeker) 
        

#  ============ for handeling the job seeker account settings =========
class AccountSettingUpdateAPIView(generics.UpdateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = AccountSettingSerializer
    queryset = AccountSetting.objects.all()

    def get_object(self):
        try:
            account_setting = AccountSetting.objects.get(user=self.request.user.job_seeker)
            return account_setting

        except AccountSetting.DoesNotExist:
            raise NotFound(detail="Account settings not found.")

    def patch(self, request, *args, **kwargs):
        account_setting = self.get_object()

        serializer = self.get_serializer(account_setting, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ProfileSetupAnalysis(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        try:
            job_seeker = JobSeeker.objects.get(user=user)
        except JobSeeker.DoesNotExist:
            return Response({'detail': "Job Seeker doesn't exist."}, status=404)

        percentage_count = 10
        missing_details_count = 0

        # Check for resume
        has_resume_uploaded = hasattr(job_seeker, 'resume') and job_seeker.resume.resume
        if has_resume_uploaded:
            percentage_count += 20
        else:
            missing_details_count += 1

        # Check for profile image
        has_profile_image = job_seeker.profile_image and job_seeker.profile_image.name not in [
            'profile/default_profile_pic.webp', 
            'profile/default_profile_pic.png'
        ]
        if has_profile_image:
            percentage_count += 10
        else:
            missing_details_count += 1

        # Check for profile summary
        has_profile_summary = bool(job_seeker.profile_summary)
        if has_profile_summary:
            percentage_count += 10
        else:
            missing_details_count += 1

        # Check for education details
        has_education_details = EducationDetail.objects.filter(user=job_seeker).exists()
        if has_education_details:
            percentage_count += 10
        else:
            missing_details_count += 1
        
        # Check for experience details
        has_experience_details = ExperienceDetail.objects.filter(user=job_seeker).exists()
        if has_experience_details:
            percentage_count += 10
        else:
            missing_details_count += 1
            
        # Check for project details
        has_project_details = ProjectDetail.objects.filter(user=job_seeker).exists()
        if has_project_details:
            percentage_count += 10  
        else:
            missing_details_count += 1

        # Check for skills
        has_skills = Skill.objects.filter(user=job_seeker).exists()
        if has_skills:
            percentage_count += 10
        else:
            missing_details_count += 1

        # Check for career preferences
        has_career_preference = False
        career_preference = job_seeker.job_seeker_career_preference
        if career_preference:
            if career_preference.prefered_job_title and career_preference.prefered_job_location and career_preference.expected_salary and career_preference.prefered_job_level and career_preference.prefered_job_type:
                has_career_preference = True
                percentage_count += 10
        else:
            missing_details_count += 1

        # Ensure the percentage does not exceed 100
        if percentage_count > 100:
            percentage_count = 100

        return Response({
            'percentage': percentage_count,
            'missing_details': missing_details_count,
            'has_resume_uploaded': has_resume_uploaded,
            'has_profile_image': has_profile_image,
            'has_profile_summary': has_profile_summary,
            'has_education_details': has_education_details,
            'has_experience_details': has_experience_details,
            'has_project_details': has_project_details,
            'has_skills': has_skills,
            'has_career_preference': has_career_preference,
        }, status=200)
