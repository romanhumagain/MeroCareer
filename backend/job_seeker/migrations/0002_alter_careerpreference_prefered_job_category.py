# Generated by Django 4.2.1 on 2024-12-04 15:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('jobs', '0002_alter_job_recruiter_alter_requiredskill_job'),
        ('job_seeker', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='careerpreference',
            name='prefered_job_category',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='jobs.jobcategory'),
        ),
    ]