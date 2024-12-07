# Generated by Django 4.2.1 on 2024-12-07 10:17

from django.db import migrations, models
import job_seeker.models


class Migration(migrations.Migration):

    dependencies = [
        ('job_seeker', '0005_accountsetting'),
    ]

    operations = [
        migrations.AlterField(
            model_name='careerpreference',
            name='expected_salary',
            field=models.CharField(blank=True, max_length=225, null=True),
        ),
        migrations.AlterField(
            model_name='jobseeker',
            name='profile_image',
            field=models.ImageField(default='profile/default_profile_pic.png', upload_to=job_seeker.models.profile_image_upload_to),
        ),
    ]