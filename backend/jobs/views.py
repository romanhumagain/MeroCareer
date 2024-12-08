from django.utils import timezone
from rest_framework.viewsets import ModelViewSet
from .serializers import JobCategorySerializer, JobSerializer, RequiredSkillSerializer
from .models import JobCategory, RequiredSkill, Job
from rest_framework.generics import ListAPIView, GenericAPIView, CreateAPIView, RetrieveAPIView, ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from recruiter.models import Recruiter
from django_filters.rest_framework import DjangoFilterBackend
from .serializers import JobSerializer
from rest_framework.exceptions import NotFound, PermissionDenied
from datetime import timedelta
from django.utils import timezone
from job_seeker.models import JobSeeker, CareerPreference
from rest_framework.views import APIView
from recruiter.serializers import RecruiterSerializer
from job_seeker.serializers import JobSeekerJobSerializer
from .filters import JobFilter

# --------------------------------J O B  S E E K E R--------------------------------

#  ===== API VIEW FOR JOB CATEGORY =======
class JobCategoryViewSet(ModelViewSet):
    serializer_class = JobCategorySerializer
    queryset = JobCategory.objects.all()
    
 
# ======= TO BROWSE THE JOB BASED ON TEH JOB CATEGORY ========   
class JobListByCategoryView(ListAPIView):
    serializer_class = JobSeekerJobSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request, *args, **kwargs):
        job_cat_id = self.kwargs.get('id')
        
        try:
            jobCategoryInst = JobCategory.objects.get(id=job_cat_id)
        except JobCategory.DoesNotExist:
            return Response({'detail': "Job Category doesn't exist."}, status=status.HTTP_400_BAD_REQUEST)
        
        
        jobInst = Job.objects.filter(category=jobCategoryInst)
        
        job_status = self.request.query_params.get('status', None)
        if job_status == "active":
            jobInst = jobInst.filter(deadline__gte = timezone.now())
        
        elif job_status == "closed":
            jobInst = jobInst.filter(deadline__lt = timezone.now())
        
        serializer = self.get_serializer(jobInst, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get_serializer_context(self):
     return {'request':self.request}


# ======= TO BROWSE THE JOB BASED ON The JOB SEEKER PREFERENCE ========   
class MatchedJobAPIView(ListAPIView):
    serializer_class = JobSeekerJobSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request, *args, **kwargs):
        user = request.user
        
        jobSeekerPreCatInst = user.job_seeker.job_seeker_career_preference.prefered_job_category
    
        # try:
        #     jobCategoryInst = JobCategory.objects.get()
        # except JobCategory.DoesNotExist:
        #     return Response({'detail': "Job Category doesn't exist."}, status=status.HTTP_400_BAD_REQUEST)
        
        
        jobInst = Job.objects.filter(category=jobSeekerPreCatInst,deadline__gte = timezone.now() )
        serializer = self.get_serializer(jobInst, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get_serializer_context(self):
     return {'request':self.request}

# ======== TO GET ALL ACTIVE JOBS OF ALL CATEGORY =========
class ActiveJobListAPIView(ListAPIView):
    serializer_class = JobSeekerJobSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request, *args, **kwargs):
        jobInst = Job.objects.filter(deadline__gt= timezone.now()).order_by('-id')
        
        serializer = self.get_serializer(jobInst, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get_serializer_context(self):
     return {'request':self.request}


# ========= TO GET THE SELECTED JOB DETAILS BY THE JOB SEEKER =========
class JobRetriveAPIView(RetrieveAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSeekerJobSerializer
    lookup_field = 'id'
    
    def get_queryset(self):
        return Job.objects.all()
    
    def retrieve(self, request, *args, **kwargs):
        try:
            jobInst = self.get_queryset().get(id=kwargs.get('id'))
            serializer = self.get_serializer(jobInst)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Job.DoesNotExist:
            return Response({'detail': "Job doesn't exist!"}, status=status.HTTP_404_NOT_FOUND)
        
    def get_serializer_context(self):
     return {'request':self.request}


# ========= TO GET THE EXPIRING JOB DETAILS (USER PREFERENCE JOB CATEGORY) =====================
class ExpiringJobAPIView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSeekerJobSerializer
    
    def get(self, request, *args, **kwargs):
        try:
            job_seeker = request.user.job_seeker
        except JobSeeker.DoesNotExist:
            return Response({'detail': 'Job Seeker profile not found!'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            preferred_category = job_seeker.job_seeker_career_preference.prefered_job_category
        except CareerPreference.DoesNotExist:
            return Response({'detail': 'Preferred job category not set for this Job Seeker!'}, status=status.HTTP_400_BAD_REQUEST)

        current_time = timezone.now()
        soon_expiry_time = current_time + timedelta(days=10)
        
        jobs = Job.objects.filter(category=preferred_category, deadline__gte=current_time, deadline__lte=soon_expiry_time)

        # Serialize and return the filtered jobs
        serializer = self.get_serializer(jobs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def get_serializer_context(self):
     return {'request':self.request}

# ========= TO GET ALL THE JOBS BASED ON THE ORGANIZATION =========
class OrganizationBasedJob(APIView):
    
    def get(self, request, *args, **kwargs):
        response_data = []
        
        categories = JobCategory.objects.all()
        
        for category in categories:
            recruiters = Recruiter.objects.filter(recruiter_job_posts__category=category).distinct()
            
            category_data = {
                'category':category.category,
                'recruiters':RecruiterSerializer(recruiters, many=True).data
            }
            response_data.append(category_data)
    
        return Response(response_data, status=status.HTTP_200_OK)
    
    
    
# ======== TO SEARCH FOR ALL ACTIVE JOBS OF ALL CATEGORY =========
class ActiveJobSearchAPIView(ListAPIView):
    serializer_class = JobSeekerJobSerializer
    permission_classes = [IsAuthenticated]
    
    def get(self, request, *args, **kwargs):
        jobInst = Job.objects.filter(deadline__gt= timezone.now()).order_by('-id')
        
        serializer = self.get_serializer(jobInst, many=True)
        
        return Response(serializer.data, status=status.HTTP_200_OK)
    
 
# ----------------------------------R E C R U I T E R-------------------------------------


#  ====== JOB POST VIEW FOR RECRUITER ===========
class JobPostAPIView(ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSerializer
    

    def get(self, request, *args, **kwargs):
        
        if not request.user.role == 'recruiter':
            return Response(
                {"detail": "You are not associated with a recruiter."},
                status=status.HTTP_403_FORBIDDEN
            )
        recruiter = request.user.recruiter
        jobsInst = Job.objects.filter(recruiter=recruiter).order_by('-id')
        
        filter_by = self.request.query_params.get('filter_by', None)
        
        if filter_by == 'all':
            jobsInst = Job.objects.filter(recruiter=recruiter).order_by('-id')
        
        elif filter_by == 'active':
            jobsInst = jobsInst.filter(deadline__gt = timezone.now())
                
        elif filter_by == "closed":
            jobsInst = jobsInst.filter(deadline__lt = timezone.now())
            
        
        serializer = self.get_serializer(jobsInst, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

        

    def post(self, request, *args, **kwargs):
        data = request.data
        user = request.user

        if user.role == "recruiter":
            user = request.user
            recruiterInst = Recruiter.objects.get(user = user)
            
            data['recruiter'] = recruiterInst.id
            category = data['category']
            
            required_job_skills = data.pop('required_skills', [])
            
            category_inst = JobCategory.objects.get(id = category)
            data['category'] = category_inst.id
            
            serializer = self.get_serializer(data=data)
            if serializer.is_valid():
                try:
                    job = serializer.save()
                    
                    for skill_name in required_job_skills:
                        skill_name = skill_name.strip().capitalize()
                        skill = RequiredSkill.objects.create(name=skill_name, job=job)
                        skill.save()
                    
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
                except Exception as e:
                    return Response({'detail': 'Something went wrong!', 'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        return Response(
                {"detail": "You are not associated with a recruiter."},
                status=status.HTTP_403_FORBIDDEN
            )


#  ===== JOB RETRIVE UPDATE DELETE API VIEW FOR RECRUITER
class JobRetrieveUpdateDeleteAPI(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSerializer
    lookup_field = 'id'

    def get_queryset(self):
        if self.request.user.role != "recruiter":
            raise PermissionDenied("You are not associated with a recruiter.")
        return Job.objects.filter(recruiter=self.request.user.recruiter)
      
    
    def retrieve(self, request, *args, **kwargs):
        try:
            jobInst = self.get_queryset().get(id=kwargs.get('id'))
            serializer = self.get_serializer(jobInst)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Job.DoesNotExist:
            return Response({'detail': "Job doesn't exist!"}, status=status.HTTP_404_NOT_FOUND)

    def update(self, request, *args, **kwargs):
        try:
            data = request.data
            jobInst = self.get_queryset().get(id=kwargs.get('id'))
            
            required_skills = data.get('required_skills', None)
            if required_skills is not None:
                if not isinstance(required_skills, list):
                    return Response({'detail': "required_skills must be a list!"}, status=status.HTTP_400_BAD_REQUEST)
                
                RequiredSkill.objects.filter(job=jobInst).delete()

                for skill_name in required_skills:
                    skill_name = skill_name.strip().capitalize()
                    RequiredSkill.objects.create(name=skill_name, job=jobInst)
                    
                  
            serializer = self.get_serializer(instance=jobInst, data=request.data, partial=True)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Job.DoesNotExist:
            return Response({'detail': "Job doesn't exist!"}, status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, *args, **kwargs):
        try:
            jobInst = self.get_queryset().get(id=kwargs.get('id'))
            jobInst.delete()
            return Response({'detail': 'Successfully deleted your job!'}, status=status.HTTP_200_OK)
        except Job.DoesNotExist:
            return Response({'detail': "Job doesn't exist!"}, status=status.HTTP_404_NOT_FOUND)


# ========== JOB POST LIST OF SPCEIFIC RECRUTIER ========
class ListRecruiterJobPost(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSeekerJobSerializer
    lookup_field = 'id'

    def get(self, request, *args, **kwargs):
        recruiterId = self.kwargs.get('id')

        # Assuming you want to filter by recruiter_id, not the job id
        jobsInst = Job.objects.filter(recruiter_id=recruiterId).order_by('-id')

        filter_by = self.request.query_params.get('filter_by', None)

        # Apply filtering if the filter_by parameter is present
        if filter_by is not None:
            if filter_by == 'active':
                jobsInst = jobsInst.filter(deadline__gt=timezone.now())

            elif filter_by == "closed":
                thirty_days_ago = timezone.now() - timedelta(days=30)
                jobsInst = jobsInst.filter(
                    deadline__lt=timezone.now(),
                    deadline__gte=thirty_days_ago
                )

        # Return serialized job data
        serializer = self.get_serializer(jobsInst, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    

class JobViewSet(ModelViewSet):
    queryset = Job.objects.filter(deadline__gte = timezone.now())
    serializer_class = JobSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_class = JobFilter