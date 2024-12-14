from django.db.models.signals import post_save
from django.dispatch import receiver
from applications.models import Applicant
from .models import Notification
from utils.send_email import send_application_status_changed_email
from chat.models import ChatRoom

@receiver(post_save, sender = Applicant)
def handle_application_status(sender, instance, created, **kwargs):
    if not created:
        job_title = instance.job.job_title
        actor = instance.job.recruiter.user
        receiver = instance.user.user
        full_name = instance.user.full_name
        
        message = f"Your application status for the job {job_title} has been updated to {instance.status}."
        notification = Notification.objects.create(receiver = receiver, actor =  actor, message = message)
        notification.save()
        
        
        if instance.user.job_seeker_settings.job_application_status_alert == True:
            try:
                send_application_status_changed_email(user = receiver,full_name=full_name,  job_title=job_title, status=instance.status, recruiter_name=instance.job.recruiter.company_name)
                print("done")
            except Exception as e:
                print(f"Error sending application status change email: {e}")
        
    elif created:
         job_title = instance.job.job_title
         receiver = instance.job.recruiter.user
         actor = instance.user.user
         
         message = f"{instance.user.full_name} applied for the {job_title}"
         notification = Notification.objects.create(receiver = receiver, actor = actor, message = message)
         notification.save()
         
    
@receiver(post_save, sender = ChatRoom)
def handle_chat_room_creation(sender, instance, created, **kwargs):
    if created:
        receiver = instance.job_seeker.user
        actor = instance.recruiter.user
        
        message = f"{instance.recruiter.company_name} has sent you a message."
        notification = Notification.objects.create(
            receiver = receiver, actor = actor, message = message
        )
        notification.save()