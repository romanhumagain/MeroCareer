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
    
    
def send_registration_email(email, full_name):
    email = email       
    message = f"""
                <p>Hi {full_name},</p>
                <p>Welcome to <strong>MeroCareer</strong>! Your account has been successfully created.</p>
                <p>You can now log in, search for jobs, or post opportunities if you're a recruiter.</p>
                <p>If you have any questions or need assistance, feel free to contact us.</p>
                
                <p>Best regards,<br>
                The <strong>MeroCareer Team</strong> </p>
            """
    subject = "Welcome to MeroCareer"

    email = EmailMultiAlternatives(
        subject=subject,
        body=message,
        to=(email,),
        from_email=settings.EMAIL_HOST_USER
    )
    email.content_subtype = 'html'
    email.send()
    
    
    
def send_company_registration_email(email, company_name):
    email = email       
    message = f"""
                <p>Dear {company_name},</p>
                <p>Congratulations and welcome to <strong>MeroCareer</strong>! Your account has been successfully created, and you are now part of our growing community.</p>
                <p>Currently, your account is under review by our admin team. Once approved, you will be able to log in, explore exciting career opportunities, and post job listings as a recruiter.</p>
                <p>Thank you for choosing MeroCareer to be a part of your professional journey.</p>
                
                <p>Best regards,<br>
                The MeroCareer Team</p>
            """
    subject = "Welcome to MeroCareer!"

    email = EmailMultiAlternatives(
        subject=subject,
        body=message,
        to=(email,),
        from_email=settings.EMAIL_HOST_USER
    )
    email.content_subtype = 'html'
    email.send()
