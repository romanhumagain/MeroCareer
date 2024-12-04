from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.views import APIView
from .models import User
from job_seeker.models import JobSeeker, CareerPreference
from base.serializers import RegisterUserSerializer
from django.db import transaction
from jobs.models import JobCategory
from rest_framework.exceptions import ValidationError

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