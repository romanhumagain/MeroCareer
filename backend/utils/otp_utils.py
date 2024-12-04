import pyotp
from django.utils import timezone
from datetime import timedelta
from base.models import OTP
from django.core.mail import EmailMultiAlternatives
from django.conf import settings


def generate_otp(user):
    try:
        totp = pyotp.TOTP(pyotp.random_base32(), interval=300)
        otp = totp.now()
        expires_at = timezone.now() + timedelta(minutes=5)
        
        while OTP.objects.filter(otp = otp).exists():
            totp = pyotp.TOTP(pyotp.random_base32(), interval=300)
            otp = totp.now()
        
        otpInstance = OTP.objects.create(user=user, otp=otp, expires_at=expires_at)
        return otp
    except Exception as err:
        return None
    
    
def send_otp_token_email(subject, message, to):
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
    
def send_email_for_otp(user):
    otp_code = generate_otp(user)
    name = ""
    role = user.role
    if role == 'job_seeker':
      name = user.job_seeker.full_name
    elif role == 'recruiter':
      name = user.recruiter.company_name

    if otp_code is not None:
        message = f"""
                    <p>Hi {name},</p>
                    <p> Thank you for registering. Please use the following OTP to complete your verification: </p>
                    <h2>{otp_code}</h2>
                    
                    <p></p>
                    <p>Best regards,<br>
                    The Blogify Team</p>
            """
        subject = "OTP Verification🔒"
        email = user.email

        send_otp_token_email(subject=subject, message=message, to=email)
        return True

    return False