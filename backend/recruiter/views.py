from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.views import APIView
from base.models import User
from base.serializers import RegisterUserSerializer
from django.db import transaction

from .serializers import RecruiterSerializer, RecruiterApplicantSerializer, ActiveJobWithApplicantsSerializer
from .models import Recruiter
from rest_framework.exceptions import NotFound, PermissionDenied
from jobs.models import Job
from applications.models import Applicant
from django.utils import timezone

from applications.models import Applicant
from applications.filters import ApplicationFilter
from django_filters.rest_framework import DjangoFilterBackend




class RegisterRecruiterAPIView(generics.CreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterUserSerializer

    def create(self, request, *args, **kwargs):
        data = request.data
        serializer = self.get_serializer(data=data)

        try:
            if serializer.is_valid():
                with transaction.atomic():
                  
                    user = serializer.save()

                    Recruiter.objects.create(
                        user=user,
                        company_profile_image = data['company_profile_image'],
                        company_name = data['company_name'],
                        phone_number = data['phone_number'],
                        address = data['address'],
                        company_type = data['company_type'],
                        registration_number = data['registration_number'],
                        pan_number = data['pan_number'],
                           
                    )

                return Response({'detail': 'Successfully Registered Recruiter'}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        
from rest_framework.exceptions import NotFound, PermissionDenied

class RetrieveUpdateDeleteRecruiterAPI(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = RecruiterSerializer
    
    def get_object(self):
        if self.request.user.role != "recruiter":
            raise PermissionDenied("You are not associated with a recruiter.")
        
        try:
    
            return Recruiter.objects.get(user=self.request.user)
        except Recruiter.DoesNotExist:
            raise NotFound("Recruiter not found!")

    def retrieve(self, request, *args, **kwargs):
        recruiterInst = self.get_object()
        serializer = self.get_serializer(recruiterInst)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    def update(self, request, *args, **kwargs):
        recruiterInst = self.get_object()
        serializer = self.get_serializer(instance=recruiterInst, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    def delete(self, request, *args, **kwargs):
        recruiterInst = self.get_object()
        recruiterInst.delete()
        return Response({'detail': 'Successfully deleted account!'}, status=status.HTTP_200_OK)




# =============  To get stats for recruiter=======
class RecruiterStatsView(APIView):
    permission_classes = [IsAuthenticated] 

    def get(self, request, *args, **kwargs):
        try:
           
            recruiter = request.user.recruiter


            active_job_posting = Job.objects.filter(recruiter=recruiter, deadline__gte=timezone.now()).count()
            total_job_posting = Job.objects.filter(recruiter=recruiter).count()
            application_received = Applicant.objects.filter(job__recruiter=recruiter).count()
            applicant_under_review = Applicant.objects.filter(job__recruiter=recruiter, status="Under Review").count()
            accepted_applicant = Applicant.objects.filter(job__recruiter=recruiter, status="Accepted").count()
            shortlisted_applicant = Applicant.objects.filter(job__recruiter=recruiter, status="Shortlisted").count()
            reviewed_applicant = Applicant.objects.filter(job__recruiter=recruiter, status="Reviewed").count()
            rejected_applicant = Applicant.objects.filter(job__recruiter=recruiter, status="Rejected").count()

            data = {
                "recruiter_id": recruiter.id,
                "active_job_posting": active_job_posting,
                "total_job_posting": total_job_posting,
                "application_received": application_received,
                "applicant_under_review": applicant_under_review,
                "accepted_applicant": accepted_applicant,
                "shortlisted_applicant": shortlisted_applicant,
                "reviewed_applicant": reviewed_applicant,
                "rejected_applicant": rejected_applicant,
            }
            return Response(data, status=200)

        except AttributeError:
            return Response({"error": "Recruiter account not found for the user"}, status=404)



#  to get the all applicants lists 
class RecruiterApplicantsView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = RecruiterApplicantSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_class = ApplicationFilter  # Use your existing filterset

    def get_queryset(self):
        recruiter = self.request.user.recruiter
        jobs = Job.objects.filter(recruiter=recruiter)
        return Applicant.objects.filter(job__in=jobs).order_by('-user__total_experience')

    

# to get the  applicants lists of specific job posts 
class ApplicantsForJobView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = RecruiterApplicantSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_class = ApplicationFilter

    def get_queryset(self):
        job_id = self.kwargs.get('job_id')
        try:
            job = Job.objects.get(id=job_id, recruiter=self.request.user.recruiter)
        except Job.DoesNotExist:
            raise PermissionDenied("You do not have permission to view this job's applicants.")
        
        # Return the raw queryset without applying `filter_queryset` here
        return Applicant.objects.filter(job=job).order_by('-user__total_experience')

    

class ActiveJobsWithApplicantsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        recruiter = request.user.recruiter 

        job_status = request.query_params.get('status', 'active').lower()

        if job_status == 'closed':
            jobs = Job.objects.filter(recruiter=recruiter, deadline__lte=timezone.now())
        else:
            jobs = Job.objects.filter(recruiter=recruiter, deadline__gt=timezone.now())

        serializer = ActiveJobWithApplicantsSerializer(jobs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
    
