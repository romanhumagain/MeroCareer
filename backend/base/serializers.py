import re
from rest_framework import serializers
from .models import User, OTP
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        
        token['email'] = user.email
        return token
      
class RegisterUserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ['email', 'password', 'role']
    
  def create(self, validated_data):
        password = validated_data.pop('password', None) 
        if password:
            user = User(**validated_data)
            user.set_password(password)
            user.save()
            return user
        raise serializers.ValidationError("Password is required.")
    
  def validate_email(self, value ):
    email_regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    
    if User.objects.filter(email = value).exists():
      raise serializers.ValidationError("Email already taken.")

    if not re.match(email_regex, value):
      raise serializers.ValidationError("Enter a valid email address.")
    return value
  
    
class LoginSerializer(serializers.Serializer):
   email = serializers.EmailField()
   password = serializers.CharField(write_only=True)

 
class OTPSerializer(serializers.ModelSerializer):
  class Meta:
    model = OTP
    fields = ['otp']
    
    
class ChangePasswordSerializer(serializers.Serializer):
    current_password = serializers.CharField(write_only=True)
    new_password = serializers.CharField(write_only=True)
    confirm_new_password = serializers.CharField(write_only=True)
    
    def validate(self, data):
        if data['new_password'] != data['confirm_new_password']:
            raise serializers.ValidationError("New password and confirm password do not match.")
      
        return data