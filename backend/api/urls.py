from django.urls import path
from base.views import ( RegisterUserAPIView, 
                        LoginAPIView)

urlpatterns = [
  path('user/register/', RegisterUserAPIView.as_view(), name='register_user'),
  path('user/login/', LoginAPIView.as_view(), name='login_user'),
  
]