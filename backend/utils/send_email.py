import pyotp
from django.utils import timezone
from datetime import timedelta
from base.models import OTP
from django.core.mail import EmailMultiAlternatives
from django.conf import settings

def send_application_status_changed_email(user, full_name, job_title, status, recruiter_name):
    email = user.email
    message = f"""
                <p>Hi {full_name},</p>
                <p> Thank you for applying. Your applcation for the {job_title} was {status} by {recruiter_name}  </p>
               
                <p></p>
                <p>Best regards,<br>
                MeroCareer </p>
        """
    subject = "Job Application"

    email = EmailMultiAlternatives(
        subject=subject,
        body=message,
        to=(email,),
        from_email=settings.EMAIL_HOST_USER
        )
    email.content_subtype = 'html' 
    email.send()
    
        
        
def send_email(subject, message, to):
    email = EmailMultiAlternatives(
        subject=subject,
        body=message,
        to=[to],
        from_email=settings.EMAIL_HOST_USER
    )
    email.content_subtype = 'html' 
    email.send()