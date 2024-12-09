from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import ExperienceDetail, JobSeeker

@receiver(post_save, sender=ExperienceDetail)
def update_total_experience(sender, instance, created, **kwargs):
    """
    Update the total experience for a JobSeeker when an ExperienceDetail is saved.
    """
    job_seeker = instance.user 
    total_experience = sum([exp.duration for exp in ExperienceDetail.objects.filter(user=job_seeker)])
    job_seeker.total_experience = total_experience
    job_seeker.save()

@receiver(post_delete, sender=ExperienceDetail)
def update_total_experience_on_delete(sender, instance, **kwargs):
    """
    Update the total experience for a JobSeeker when an ExperienceDetail is deleted.
    """
    job_seeker = instance.user 
    total_experience = sum([exp.duration for exp in ExperienceDetail.objects.filter(user=job_seeker)])
    job_seeker.total_experience = total_experience
    job_seeker.save()
