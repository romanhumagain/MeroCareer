from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView, ListCreateAPIView, DestroyAPIView, ListAPIView
from rest_framework.views import APIView
from jobs.models import Job
from job_seeker.models import JobSeeker
from .serializers import ApplicantSerializer, SavedJobSerializer
from rest_framework.permissions import IsAuthenticated
from applications.models import Applicant, SavedJob
from rest_framework.exceptions import NotFound
from django.utils import timezone
from django_filters.rest_framework import DjangoFilterBackend
from.filters import ApplicationFilter


class ApplicationAPIView(ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ApplicantSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_class = ApplicationFilter

    def get(self, request, *args, **kwargs):
        print(request.query_params)
        try:
            job_seeker = request.user.job_seeker
        except AttributeError:
            return Response({'detail': 'Job Seeker profile not found!'}, status=status.HTTP_400_BAD_REQUEST)
        
        applicants = Applicant.objects.filter(user=job_seeker).order_by('-applied_on')
        applicants = self.filter_queryset(applicants)
        serializer = self.get_serializer(applicants, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        try:
            job_seeker = request.user.job_seeker
        except AttributeError:
            return Response({'detail': 'Job Seeker profile not found!'}, status=status.HTTP_400_BAD_REQUEST)
        
        data = request.data
        
        if Applicant.objects.filter(job = data['job'],user = job_seeker ).exists():
            return Response({'detail':'Already Applied !'}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = self.get_serializer(data=data)
        if serializer.is_valid():
            serializer.save(user=job_seeker)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ApplicationDeleteAPIView(DestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = ApplicantSerializer
    lookup_field = 'id'
  
    def destroy(self, request, *args, **kwargs):
        job_id = self.kwargs.get('id')
      
        try:
            job = Job.objects.get(id=job_id)
        except Job.DoesNotExist:
            return Response({'detail': "Job doesn't exist."}, status=status.HTTP_400_BAD_REQUEST)
      
        try:
            applicant = Applicant.objects.get(user=request.user.job_seeker, job=job)
            applicant.delete()
            return Response({'detail': 'Successfully deleted application!'}, status=status.HTTP_204_NO_CONTENT)
        except Applicant.DoesNotExist:
            return Response({'detail': "Application doesn't exist!"}, status=status.HTTP_400_BAD_REQUEST)


#  ========== VIEW TO HANDLE THE JOB SAVE =============
class SaveJobAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        user = request.user
        if user.role != "job_seeker":
            return Response({'detail':'You are not authorized for this !'}, status=status.HTTP_403_FORBIDDEN)
        
        job_seeker = user.job_seeker
        job_id = request.data.get('job')
        
        if not job_id:
            return Response({'detail': 'Job ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            job = Job.objects.get(id=job_id)
        except Job.DoesNotExist:
            return Response({'detail': 'Job not found'}, status=status.HTTP_404_NOT_FOUND)
        
        saved_job, created = SavedJob.objects.get_or_create(user=job_seeker, job=job)

        if created:
            return Response({'detail': 'Job saved successfully'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'detail': 'Job already saved'}, status=status.HTTP_400_BAD_REQUEST)

    
#  ============ VIEW TO HANDLE THE UNSAVE JOB POSTS ==========
class UnsaveJobAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, *args, **kwargs):
        user = request.user
        if user.role != "job_seeker":
            return Response({'detail':'You are not authorized for this !'}, status=status.HTTP_403_FORBIDDEN)
        
        job_seeker = user.job_seeker
        
        job_id = self.kwargs.get('id')
        
        if not job_id:
            return Response({'detail': 'Job ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            job = Job.objects.get(id=job_id)
        except Job.DoesNotExist:
            return Response({'detail': 'Job not found'}, status=status.HTTP_404_NOT_FOUND)
        
        try:
            saved_job = SavedJob.objects.get(user=job_seeker, job=job)
            saved_job.delete()
            return Response({'detail': 'Job unsaved successfully'}, status=status.HTTP_204_NO_CONTENT)
        except SavedJob.DoesNotExist:
            return Response({'detail': 'Job not found in saved jobs'}, status=status.HTTP_404_NOT_FOUND)
        

class SavedPostListView(ListAPIView):
    serializer_class = SavedJobSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user

        queryset = SavedJob.objects.filter(user=user.job_seeker, job__deadline__gte=timezone.now()).order_by('-saved_at')

    
        include_closed = self.request.query_params.get('include_closed', 'false') == 'true'
        
        if include_closed:
            queryset = SavedJob.objects.filter(user=user.job_seeker, job__deadline__lte=timezone.now()).order_by('-saved_at')

        return queryset

    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
    
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)