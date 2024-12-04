from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from .serializers import (RegisterUserSerializer, LoginSerializer, OTPSerializer)
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from .models import User, OTP
from job_seeker.models import JobSeekerProfile, CareerPreference
from recruiter.models import RecruiterProfile
from utils.otp_utils import send_email_for_otp


class LoginAPIView(generics.CreateAPIView):
  permission_classes = [AllowAny]
  serializer_class = LoginSerializer
  
  def post(self, request, *args, **kwargs):
    data = request.data
    serializer = self.get_serializer(data = data)
    if serializer.is_valid():
      email = serializer.validated_data['email']
      password = serializer.validated_data['password']
      
      if not User.objects.filter(email = email).exists():
        return Response({'detail':'Invalid Credentials email !'}, status=status.HTTP_401_UNAUTHORIZED)
      
      user = authenticate(email = email, password = password)
      
      if user is not None:
        refresh = RefreshToken.for_user(user)
        refresh['id'] = user.id
        refresh['slug'] = user.slug
        refresh['email'] = user.slug
        
        access_token = str(refresh.access_token)
        
        response_data = {
        'detail':'User loggedin successfully !',
        'refresh':str(refresh),
        'access':access_token,
        'role':user.role
        }
        if user.role == 'job_seeker':
            return Response({"message": "Job Seeker Dashboard", **response_data}, status=status.HTTP_200_OK)
        elif user.role == 'recruiter':
            return Response({"message": "Recruiter Dashboard", **response_data}, status=status.HTTP_200_OK)
        elif user.role == 'admin':
            return Response({"message": "Admin Dashboard", **response_data}, status=status.HTTP_200_OK)
        else:
            return Response({"message": "Invalid role."}, status=status.HTTP_400_BAD_REQUEST)

      else:
          return Response({"message": "Invalid credentials."}, status=status.HTTP_401_UNAUTHORIZED)
        
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
  
  
class SendOTPAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            user = request.user
            if user is not None:
                otp = OTP.objects.filter(user = user)
                if otp:
                  otp.delete()
                  
                email_sent = send_email_for_otp(user)
                if email_sent:
                    return Response(
                        {"message": "Successfully sent email."},
                        status=status.HTTP_200_OK,
                    )
                else:
                    return Response(
                        {"message": "Failed to send OTP email."},
                        status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    )
            else:
                return Response(
                    {"message": "User not authenticated."},
                    status=status.HTTP_401_UNAUTHORIZED,
                )
        except Exception as e:
            print(f"Error in sending OTP: {str(e)}")
            return Response(
                {"message": "Internal server error."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
              
class VerifyOTP(generics.RetrieveUpdateAPIView):
  serializer_class = OTPSerializer
  lookup_field = 'otp'
  
  def get_queryset(self):
    otp = self.kwargs.get('otp')
    return OTP.objects.get(user = self.request.user, otp = otp)
   
   
  def update(self, request, *args, **kwargs):
    otp = self.get_queryset()
    if not otp:
      return Response(
                {"detail": "OTP not found"}, status=status.HTTP_404_NOT_FOUND
            )
    
    if otp.has_expired or otp.is_expired:
            return Response(
                {"detail": "OTP has expired."}, status=status.HTTP_400_BAD_REQUEST
            )
    otp.user.is_verified = True;
    otp.user.save()
    
    otp.delete()
    return Response(
            {"detail": "User verified successfully."}, status=status.HTTP_200_OK
        )