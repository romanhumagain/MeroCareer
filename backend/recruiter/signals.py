from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import Recruiter
from base.models import User
from utils.send_email import send_registration_email


@receiver(post_save, sender = Recruiter)
def send_company_registration_message(sender, instance, created,**kwargs ):
    if created:
        try:
            send_registration_email(email=instance.user.email, full_name= instance.company_name)
        except Exception as e:
            print(f"Error sending registration email: {e}")