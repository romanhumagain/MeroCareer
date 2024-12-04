from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.views import APIView
from base.models import User
from base.serializers import RegisterUserSerializer
from django.db import transaction
from .models import RecruiterProfile

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

                    RecruiterProfile.objects.create(
                        user=user,
                        company_profile_image = data['company_profile_image'],
                        company_name = data['company_name'],
                        phone_number = data['phone_number'],
                        address = data['address'],
                        company_type = data['company_type'],
                        registration_number = data['registration_number'],
                        pan_number = data['pan_number'],
                           
                    )

                return Response({'detail': 'Successfully Registered Job Seeker'}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'detail': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
