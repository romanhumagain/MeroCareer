# Generated by Django 5.1.3 on 2024-12-03 15:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('job_seeker', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='careerpreference',
            name='expected_salary',
            field=models.PositiveIntegerField(blank=True, null=True),
        ),
    ]
