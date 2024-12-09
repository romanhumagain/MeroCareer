from django_filters import FilterSet
import django_filters
from .models import Applicant

class ApplicationFilter(FilterSet):
  status = django_filters.CharFilter(lookup_expr='icontains', field_name='status')
  
  class Meta:
    model = Applicant
    fields = ['status']
  