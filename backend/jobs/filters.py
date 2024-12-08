import django_filters
from .models import Job

class JobFilter(django_filters.FilterSet):
    job_title = django_filters.CharFilter(lookup_expr='icontains') 
    category = django_filters.CharFilter(field_name='category__category', lookup_expr='icontains') 
    job_level = django_filters.CharFilter(lookup_expr='icontains') 
    job_type = django_filters.CharFilter(lookup_expr='icontains')
    experience = django_filters.NumberFilter(field_name='experience', lookup_expr='gte') 

    class Meta:
        model = Job
        fields = ['job_title', 'category', 'job_level', 'job_type', 'experience']
