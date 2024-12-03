from rest_framework.serializers import ModelSerializer
from .models import JobCategory

class JobCategorySerializer(ModelSerializer):
  class Meta:
    model = JobCategory
    fields = '__all__'