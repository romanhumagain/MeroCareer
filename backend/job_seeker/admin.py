from django.contrib import admin
from .models import JobSeeker, CareerPreference, EducationDetail, ExperienceDetail, Skill, Resume, ProjectDetail

admin.site.register(JobSeeker)
admin.site.register(CareerPreference)
admin.site.register(EducationDetail)
admin.site.register(ExperienceDetail)
admin.site.register(ProjectDetail)
admin.site.register(Skill)
admin.site.register(Resume)



