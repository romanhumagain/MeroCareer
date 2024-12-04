from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.views import APIView
from base.models import User
from base.serializers import RegisterUserSerializer
from django.db import transaction

from .serializers import RecruiterSerializer
from .models import Recruiter
from rest_framework.exceptions import NotFound, PermissionDenied

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
