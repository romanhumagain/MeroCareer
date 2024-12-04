from rest_framework.viewsets import ModelViewSet
from .serializers import JobCategorySerializer, JobSerializer, RequiredSkillSerializer
from .models import JobCategory, RequiredSkill, Job
from rest_framework.generics import GenericAPIView, CreateAPIView, ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from recruiter.models import Recruiter

class JobCategoryViewSet(ModelViewSet):
    serializer_class = JobCategorySerializer
    queryset = JobCategory.objects.all()
    
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
        jobsInst = Job.objects.filter(recruiter=recruiter)
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


class JobRetrieveUpdateDeleteAPI(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = JobSerializer
    lookup_field = 'id'

    def get_queryset(self):
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
