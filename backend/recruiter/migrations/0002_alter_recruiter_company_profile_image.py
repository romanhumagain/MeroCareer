# Generated by Django 4.2.1 on 2024-12-05 11:07

from django.db import migrations, models
import recruiter.models


class Migration(migrations.Migration):

    dependencies = [
        ('recruiter', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='recruiter',
            name='company_profile_image',
            field=models.ImageField(default='profile/default_company_pic.png', upload_to=recruiter.models.profile_image_upload_to),
        ),
    ]