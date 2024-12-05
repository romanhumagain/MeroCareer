import django_filters
from django.utils import timezone
from .models import Job

class JobFilter(django_filters.FilterSet):
  job_type  = django_filters.CharFilter(lookup_expr='icontains')
  
  is_active = django_filters.BooleanFilter(method='filter_is_active')
  
  def filter_is_active(self, queryset, name, value):
    """
    Filters jobs based on whether they are active.
    If 'is_active' is True, it filters for jobs with a future deadline.
    If 'is_active' is False, it filters for jobs with a past deadline.
    """
    if value:
        return queryset.filter(deadline__gt=timezone.now())
    else:
        return queryset.filter(deadline__lt=timezone.now())

  class Meta:
        model = Job
        fields = ['job_type', 'is_active'] 