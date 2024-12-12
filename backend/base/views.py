from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from .serializers import (RegisterUserSerializer, 
                          LoginSerializer, 
                          OTPSerializer, 
                          ChangePasswordSerializer, 
                          PasswordResetTokenSerializer,
                          PasswordResetSerializer)
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from .models import User, OTP
from job_seeker.models import JobSeeker, CareerPreference
from recruiter.models import Recruiter
from utils.otp_utils import send_email_for_otp
from utils.forgot_password_utils import generate_password_reset_token, send_password_reset_email
from django.utils import timezone
from datetime import timedelta
from .models import PasswordResetToken
from utils.send_email import send_email
from django.db import transaction


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
        refresh['email'] = user.email
        
        access_token = str(refresh.access_token)
        
        
        response_data = {
        'detail':'User loggedin successfully !',
        'refresh':str(refresh),
        'access':access_token,
        'role':user.role, 
        'is_verified':user.is_verified
        }
        
        if user.role == "recruiter":
            response_data['is_approved'] = user.recruiter.is_approved
            
        return Response(response_data, status=status.HTTP_200_OK)   

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
              
from rest_framework.exceptions import NotFound

class VerifyOTP(generics.UpdateAPIView):
    serializer_class = OTPSerializer
    lookup_field = 'otp'

    def get_object(self):
        otp = self.kwargs.get(self.lookup_field)
        try:
            otp_instance = OTP.objects.get(user=self.request.user, otp=otp)
        except OTP.DoesNotExist:
            raise NotFound({"detail": "OTP doesn't exist."})
        return otp_instance

    def update(self, request, *args, **kwargs):
        otp_instance = self.get_object()

       
        if otp_instance.has_expired or otp_instance.is_expired:
            return Response(
                {"detail": "OTP has expired."}, status=status.HTTP_400_BAD_REQUEST
            )

        # Mark user as verified
        otp_instance.user.is_verified = True
        otp_instance.user.save()

       
        otp_instance.delete()

        return Response(
            {"detail": "User verified successfully."}, status=status.HTTP_200_OK
        )

class ChangePasswordAPIView(APIView):
    permission_classes = [IsAuthenticated]
    def post(self, request):
        data = request.data
        serializer = ChangePasswordSerializer(data=data)
        
        if serializer.is_valid():
            user = request.user
            
            new_password = serializer.validated_data['new_password']
            current_password = serializer.validated_data['current_password']
            
            if not user.check_password(current_password):
                return Response({"detail": "Current password is incorrect."}, status=status.HTTP_400_BAD_REQUEST)
            
            if user.check_password(new_password):
                return Response({"detail": "New password cannot be similar to current password !"}, status=status.HTTP_400_BAD_REQUEST)
            
            new_password = serializer.validated_data['new_password']
            user.set_password(new_password)
            user.save()

            return Response({"detail": "Password updated successfully."}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class DeactivateAccountAPIView(APIView):
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        data = request.data
        user = request.user
        
        if not user.check_password(data['password']):
            return Response({"detail": "Invalid Credentials"}, status=status.HTTP_400_BAD_REQUEST)
            
        user.is_active = False
        user.save()
        
        return Response({'detail':'Successfully deactivated your account !'}, status=status.HTTP_200_OK)
    
    
    
       
def send_password_reset_token_email(user):
    token = generate_password_reset_token(user)
    reset_link = f"http://localhost:5173/forgot-password/{token}"
    expiration_time = timezone.now() + timedelta(minutes=5)
    if user.role == "job_seeker":
        full_name = user.job_seeker.full_name
    elif user.role == "recruiter":
        full_name = user.recruiter.company_name

    if token is not None:
        subject = "Password Reset Request"
        message = (
            f"<p>Hello {full_name},</p>"
            "<p>You have requested a password reset. Please click on the link below to reset your password:</p>"
            f"<p>{reset_link}</p>"
            "<p>This link will expire in 5 minutes.</p>"
            "<p>If you did not request this reset, please ignore this email.</p>"
            "<p>Thank you!"
        )
        email = user.email

        send_password_reset_email(subject=subject, message=message, to=email)
        return True

    return False


class PasswordResetAPIView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            data = request.data


            try:
                user = User.objects.get(email=data["email"])
            except User.DoesNotExist:
                return Response(
                    {
                        "detail": "Email not found ! Please use your registered email address."
                    },
                    status=status.HTTP_404_NOT_FOUND,
                )
                
            PasswordResetToken.objects.filter(user = user).delete()

            email_sent = send_password_reset_token_email(user)
            if email_sent:
                return Response(
                    {"detail": "Successfully sent email."}, status=status.HTTP_200_OK
                )
            else:
                return Response(
                    {"detail": "Failed to send password reset email."},
                    status=status.HTTP_500_INTERNAL_SERVER_ERROR,
                )

        except Exception as e:
            print(f"Error in sending Password Reset Token: {str(e)}")
            return Response(
                {"detail": "Internal server error."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class VerifyPasswordResetTokenAPIView(generics.RetrieveAPIView):
    serializer_class = PasswordResetTokenSerializer
    permission_classes = [AllowAny]
    lookup_field = "token"
    lookup_url_kwarg = "token"

    def get(self, request, *args, **kwargs):
        token = self.kwargs.get(self.lookup_url_kwarg)
        try:
            token_instance = PasswordResetToken.objects.get(token=token)
            if token_instance.is_expired:
                return Response(
                    {"detail": "Token Expired, Resend new token!"},
                    status=status.HTTP_404_NOT_FOUND,
                )
            return Response({"detail": "Token verified!"}, status=status.HTTP_200_OK)
        except PasswordResetToken.DoesNotExist:
            return Response(
                {"detail": "Invalid Token!"}, status=status.HTTP_400_BAD_REQUEST
            )


class ConfirmPasswordResetAPIView(generics.UpdateAPIView):
    serializer_class = PasswordResetSerializer
    permission_classes = [AllowAny]

    def put(self, request, *args, **kwargs):
        print(request.data)
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            data = serializer.validated_data
            try:
                token = PasswordResetToken.objects.get(token=data["token"])
                if not token.is_expired:
                    with transaction.atomic():
                        user = token.user
                        user.set_password(data["password"])
                        user.save()
                        token.delete()
                        send_email(
                            "Password Reset Successfull ",
                            """
                                   <p>Your password has been successfully changed !</p>
                                   <p>If you did not initiate this request, please contact our support team immediately</p>
                                   <p>Thank you for being a valued user.</p>
                                   <p>Best regards,</p>
                                   <p><strong>MeroCareer</strong></p>
                                   """,
                            user.email,
                        )

                        return Response(
                            {"detail": "Successfully changed password!"},
                            status=status.HTTP_200_OK,
                        )
                else:
                    return Response(
                        {"detail": "Token already expired!"},
                        status=status.HTTP_400_BAD_REQUEST,
                    )
            except PasswordResetToken.DoesNotExist:
                return Response(
                    {"detail": "Token doesn't exist!"}, status=status.HTTP_404_NOT_FOUND
                )
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
