from django.urls import path, include
from base.views import ( 
                        LoginAPIView, 
                        SendOTPAPIView, 
                        VerifyOTP)
from rest_framework import routers

from jobs.views import (JobCategoryViewSet, 
                        JobPostAPIView, 
                        JobRetrieveUpdateDeleteAPI)
from job_seeker.views import (RegisterJobSeekerAPIView)
from recruiter.views import (RegisterRecruiterAPIView, RetrieveUpdateDeleteRecruiterAPI)

router = routers.DefaultRouter()
router.register(r'jobs-category', JobCategoryViewSet)

urlpatterns = router.urls


urlpatterns = [
  path('jobseeker/register/', RegisterJobSeekerAPIView.as_view(), name='register_job_seeker'),
  path('recruiter/register/', RegisterRecruiterAPIView.as_view(), name='register_recruiter'),
  path('recruiter/', RetrieveUpdateDeleteRecruiterAPI.as_view(), name='retrive_update_delete_recruiter'),
  
  
  
  path('user/login/', LoginAPIView.as_view(), name='login_user'),
  path("send-otp/", SendOTPAPIView.as_view(), name="send-otp-auth"),
  path("verify-otp/<str:otp>/", VerifyOTP.as_view(), name="verify-otp"),
  
  
  path('jobs/', JobPostAPIView.as_view(), name='list_create_job'),
  path('jobs/<int:id>/', JobRetrieveUpdateDeleteAPI.as_view(), name='retrive_update_delete_job'),
  
  path('', include(router.urls))
  
]