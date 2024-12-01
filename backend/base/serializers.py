import re
from rest_framework import serializers
from .models import User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        
        token['slug'] = user.slug
        token['email'] = user.email
        token['full_name'] = user.full_name
      
        return token
      
class RegisterUserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ['full_name', 'username', 'email', 'password', 'role']
    
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
  
  def valdate_username(self, value):
    if User.objects.filter(username = value).exists():
      raise serializers.ValidationError("Username not found !")
    return value
    
class LoginSerializer(serializers.Serializer):
   email = serializers.EmailField()
   password = serializers.CharField(write_only=True)

    
class UserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ['slug', 'full_name', 'username', 'email', 'password', 'is_verified', 'date_joined', 'last_login', 'role' ]
    
    extra_kwargs = {
                    'password': {'write_only': True}, 
                    'slug' : {'read_only':True}
                  }
    
    