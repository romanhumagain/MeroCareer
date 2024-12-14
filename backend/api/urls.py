from django.urls import path, include
from base.views import ( 
                        LoginAPIView, 
                        SendOTPAPIView, 
                        VerifyOTP, 
                        ChangePasswordAPIView, 
                        DeactivateAccountAPIView, 
                        PasswordResetAPIView,
                        ConfirmPasswordResetAPIView,
                        VerifyPasswordResetTokenAPIView
                        )
from rest_framework import routers

from jobs.views import (JobCategoryViewSet, 
                        JobPostAPIView, 
                        JobRetrieveUpdateDeleteAPI, 
                        JobListByCategoryView, 
                        JobRetriveAPIView, 
                        ExpiringJobAPIView, 
                        OrganizationBasedJob, 
                        ActiveJobListAPIView, 
                        ListRecruiterJobPost, 
                        MatchedJobAPIView, 
                        JobViewSet, 
                        RecentSearchAPIView, 
                        ClearAllSearchAPIView, 
                        RemoveFromRecentSearchAPIView)

from job_seeker.views import (RegisterJobSeekerAPIView,
                              JobSeekerRetriveUpdateDeleteAPIView, 
                              CareerPreferenceAPIView, 
                              EducationDetailViewSet, 
                              ExperienceDetailViewSet,
                              ProjectDetailViewSet,
                              SkillAPIView,
                              ResumeViewSet,
                              ProfileSetupAnalysis,
                              JobSeekerRetriveAPIView,
                              GetRecruiterDetailsAPI,
                              AccountSettingUpdateAPIView, 
                              GetAccountSettingAPIView, 
                              GetProfileCompletionRate
                              )

from recruiter.views import (RegisterRecruiterAPIView, 
                             RetrieveUpdateDeleteRecruiterAPI, 
                             RecruiterStatsView, 
                             RecruiterApplicantsView, 
                             ApplicantsForJobView, 
                             ActiveJobsWithApplicantsView)

from applications.views import (ApplicationAPIView, 
                                ApplicationDeleteAPIView, 
                                SaveJobAPIView, 
                                UnsaveJobAPIView, 
                                SavedPostListView, 
                                RecruiterApplicantsDetailAPIView)

from notification.views import (NotificationListView, UnreadNotificationListView,MarkAllNotificationsReadView  )
from chat.views import ( 
                        ChatRoomAPIView, 
                        ChatRoomMessageAPIView,
                        GetChatRoomWithJobSeeker,
                        MarkAllMessagesAsReadView,
                        UnreadChatRoomsCountView,
                        ChatRoomWithJobseekerAPIView
                        )


router = routers.DefaultRouter()
router.register(r'jobs-category', JobCategoryViewSet, basename='jobs_category')
router.register(r'education-details', EducationDetailViewSet, basename='education-detail')
router.register(r'experience-details', ExperienceDetailViewSet, basename='experience-detail')
router.register(r'project-details', ProjectDetailViewSet, basename='project-detail')
router.register(r'resume', ResumeViewSet, basename='resume')
router.register(r'job', JobViewSet, basename='jobs')

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
  path('profile-completion/<int:id>/', GetProfileCompletionRate.as_view(), name='profile_setup_analysis'),
  
  path('recruiter/job/<int:id>/', GetRecruiterDetailsAPI.as_view(), name='recruiter_with_posted_job_details'),
  path('joblist/<int:id>/', ListRecruiterJobPost.as_view(), name='recruiter_job_details'),
  path('account/settings/', GetAccountSettingAPIView.as_view(), name='get_account_settings'),

  path('settings/', AccountSettingUpdateAPIView.as_view(), name='update_account_settings'),
  path('deactivate-account/', DeactivateAccountAPIView.as_view(), name='deactivate'),
  
  
  
  path('application/', ApplicationAPIView.as_view(), name='application_list_create'),
  path('application/<int:id>/', ApplicationDeleteAPIView.as_view(), name='application_delete'),
  path('save-job/', SaveJobAPIView.as_view(), name='save-job'),
  path('unsave-job/<int:id>/', UnsaveJobAPIView.as_view(), name='unsave-job'),
  path('saved-post/', SavedPostListView.as_view(), name='saved-job-post'),
  path('applicants/<int:id>/', RecruiterApplicantsDetailAPIView.as_view(), name='applicant-detail'),
  
  
  path('user/login/', LoginAPIView.as_view(), name='login_user'),
  path("send-otp/", SendOTPAPIView.as_view(), name="send-otp-auth"),
  path("verify-otp/<str:otp>/", VerifyOTP.as_view(), name="verify-otp"),
  path('change-password/', ChangePasswordAPIView.as_view(), name='change-password'),
  
  path('jobs/', JobPostAPIView.as_view(), name='list_create_job'),
  path('jobs/<int:id>/', JobRetrieveUpdateDeleteAPI.as_view(), name='retrive_update_delete_job'),
  path('jobs/category/<int:id>/', JobListByCategoryView.as_view(), name='job-list-by-category'),
  path('get-job-details/<int:id>/', JobRetriveAPIView.as_view(), name='get_job_details'),
  path('jobs/expiring-soon/', ExpiringJobAPIView.as_view(), name='expiring-jobs'),
  path('jobs/organization/', OrganizationBasedJob.as_view(), name='job_post_by_organization'),
  path('active/jobs/', ActiveJobListAPIView.as_view(), name='active_job_list'),
  path('matched/jobs/', MatchedJobAPIView.as_view(), name='matched_job_list'),
  
  
  path('recent-search/', RecentSearchAPIView.as_view(), name='recent-search'),
  path('remove-recent-search/<int:id>/', RemoveFromRecentSearchAPIView.as_view(), name='remove-recent-search'),
  path('clear-all-search/', ClearAllSearchAPIView.as_view(), name='clearall-search'),
  
  path('recruiter-stats/', RecruiterStatsView.as_view(), name='recruiter_stats'),
  path('recruiter/applicants/', RecruiterApplicantsView.as_view(), name='recruiter-applicants'),
  path('jobs/<int:job_id>/applicants/', ApplicantsForJobView.as_view(), name='job-applicants'),
  path('active-jobs-with-applicants/', ActiveJobsWithApplicantsView.as_view(), name='active-jobs-with-applicants'),
  
  
  path('notifications/', NotificationListView.as_view(), name='notification-list'),
  path('notifications/unread/', UnreadNotificationListView.as_view(), name='unread-notifications'),
  path('notifications/mark-all-read/', MarkAllNotificationsReadView.as_view(), name='mark-all-read'),
  

 # Chat room endpoints
  path('chat-room/', ChatRoomAPIView.as_view(), name='chat-room-list'),
  path('chat-room/<int:job_seeker_id>/', ChatRoomAPIView.as_view(), name='chat-room-create'),
  path('messages/mark-as-read/', MarkAllMessagesAsReadView.as_view(), name='mark_all_messages_as_read'),
  path('messages/unread-chat-rooms-count/', UnreadChatRoomsCountView.as_view(), name='unread_chat_rooms_count'),
  path('chat-room/<int:chat_room_id>/messages/', ChatRoomMessageAPIView.as_view(), name='chat-room-messages'),
  path('jobseeker-chat-room/<int:job_seeker_id>/messages/', GetChatRoomWithJobSeeker.as_view(), name='chat-room-messages-jobseeker'),
  path('chat-with-jobseeker/<int:job_seeker_id>/', ChatRoomWithJobseekerAPIView.as_view(), name='chat-room-messages-jobseeker'),
  
    
  #  forgot password
  path("password-reset/", PasswordResetAPIView.as_view(), name="password-reset"),
  path("verify-password-reset-token/<str:token>/", VerifyPasswordResetTokenAPIView.as_view(), name="verify-password-reset-token",),
  path("confirm-password-reset/", ConfirmPasswordResetAPIView.as_view(), name="confirm-password-reset",),

  path('', include(router.urls))
  
]