from django.core.mail import EmailMultiAlternatives
from django.conf import settings
from django.utils import timezone
from datetime import timedelta
from base.models import OTP, PasswordResetToken
import secrets


def generate_password_reset_token(user):
    try:
        token = secrets.token_urlsafe(30)
        expires_at = timezone.now() + timedelta(minutes=5)
        
        while PasswordResetToken.objects.filter(token=token).exists():
            token = secrets.token_urlsafe(30)
            
        passwordResetToken = PasswordResetToken.objects.create(user = user, token = token, expires_at = expires_at)
        return passwordResetToken.token
    except Exception as err:
        print(err)
        return None
      
def send_password_reset_email(subject, message, to):
    try:
        email = EmailMultiAlternatives(
        subject=subject,
        body=message,
        to=[to],
        from_email=settings.EMAIL_HOST_USER
        )
        email.content_subtype = 'html' 
        email.send()
        return True
    
    except Exception as err:
        print(err)
        return False
    