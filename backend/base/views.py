from rest_framework.response import Response
from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from .serializers import (RegisterUserSerializer, LoginSerializer)
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from django.contrib.auth import authenticate
from .models import User
 
class RegisterUserAPIView(generics.CreateAPIView):
  permission_classes = [AllowAny]
  serializer_class = RegisterUserSerializer
  
  def create(self, request, *args, **kwargs):
    data = request.data
    serializer = self.get_serializer(data = data)
    try:
      if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
      return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    except Exception as e:
      return Response({'detail':str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

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