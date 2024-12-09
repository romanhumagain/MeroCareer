from django.contrib import admin
from .models import JobCategory, Job, RequiredSkill, RecentSearch

admin.site.register(JobCategory)
admin.site.register(Job)
admin.site.register(RequiredSkill)
admin.site.register(RecentSearch)


