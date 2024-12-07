from django.urls import path, include
from base.views import ( 
                        LoginAPIView, 
                        SendOTPAPIView, 
                        VerifyOTP, 
                        ChangePasswordAPIView)
from rest_framework import routers

from jobs.views import (JobCategoryViewSet, 
                        JobPostAPIView, 
                        JobRetrieveUpdateDeleteAPI, 
                        JobListByCategoryView, 
                        JobRetriveAPIView, 
                        ExpiringJobAPIView, 
                        OrganizationBasedJob, 
                        ActiveJobListAPIView)

from job_seeker.views import (RegisterJobSeekerAPIView,
                              JobSeekerRetriveUpdateDeleteAPIView, 
                              CareerPreferenceAPIView, 
                              EducationDetailViewSet, 
                              ExperienceDetailViewSet,
                              ProjectDetailViewSet,
                              SkillAPIView,
                              ResumeViewSet,
                              ProfileSetupAnalysis,
                              JobSeekerRetriveAPIView
                              )

from recruiter.views import (RegisterRecruiterAPIView, RetrieveUpdateDeleteRecruiterAPI)

from applications.views import (ApplicationAPIView, ApplicationDeleteAPIView, SaveJobAPIView, UnsaveJobAPIView)

router = routers.DefaultRouter()
router.register(r'jobs-category', JobCategoryViewSet, basename='jobs_category')
router.register(r'education-details', EducationDetailViewSet, basename='education-detail')
router.register(r'experience-details', ExperienceDetailViewSet, basename='experience-detail')
router.register(r'project-details', ProjectDetailViewSet, basename='project-detail')
router.register(r'resume', ResumeViewSet, basename='resume')
urlpatterns = router.urls


urlpatterns = [
  path('jobseeker/register/', RegisterJobSeekerAPIView.as_view(), name='register_job_seeker'),
  path('recruiter/register/', RegisterRecruiterAPIView.as_view(), name='register_recruiter'),
  path('recruiter/', RetrieveUpdateDeleteRecruiterAPI.as_view(), name='retrive_update_delete_recruiter'),
  path('jobseeker/', JobSeekerRetriveUpdateDeleteAPIView.as_view(), name='retrive_update_delete_jobseeker'),
  path('jobseeker-details/<int:id>/', JobSeekerRetriveAPIView.as_view(), name='retrive_jobseeker'),
  path('career-preference/', CareerPreferenceAPIView.as_view(), name='career_preference'),
  path('skill/', SkillAPIView.as_view(), name='skill_api'),
  path('profile-setup-analysis/', ProfileSetupAnalysis.as_view(), name='profile_setup_analysis'),
  
  
  path('application/', ApplicationAPIView.as_view(), name='application_list_create'),
  path('application/<int:id>/', ApplicationDeleteAPIView.as_view(), name='application_delete'),
  path('save-job/', SaveJobAPIView.as_view(), name='save-job'),
  path('unsave-job/<int:id>/', UnsaveJobAPIView.as_view(), name='unsave-job'),
  
  path('user/login/', LoginAPIView.as_view(), name='login_user'),
  path("send-otp/", SendOTPAPIView.as_view(), name="send-otp-auth"),
  path("verify-otp/<str:otp>/", VerifyOTP.as_view(), name="verify-otp"),
  path('change-password/', ChangePasswordAPIView.as_view(), name='change-password'),
  
  path('jobs/', JobPostAPIView.as_view(), name='list_create_job'),
  path('jobs/<int:id>/', JobRetrieveUpdateDeleteAPI.as_view(), name='retrive_update_delete_job'),
  path('jobs/category/<int:id>/', JobListByCategoryView.as_view(), name='job-list-by-category'),
  path('get-job-details/<int:id>/', JobRetriveAPIView.as_view(), name='get_job_details'),
  path('jobs/expiring-soon/', ExpiringJobAPIView.as_view(), name='expiring-jobs'),
  path('jobs/expiring-soon/', ExpiringJobAPIView.as_view(), name='expiring-jobs'),
  path('jobs/organization/', OrganizationBasedJob.as_view(), name='job_post_by_organization'),
  path('active/jobs/', ActiveJobListAPIView.as_view(), name='active_job_list'),
  
  
  
  path('', include(router.urls))
  
]