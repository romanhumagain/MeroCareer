from rest_framework.viewsets import ModelViewSet
from .serializers import JobCategorySerializer
from .models import JobCategory

class JobCategoryViewSet(ModelViewSet):
    serializer_class = JobCategorySerializer
    queryset = JobCategory.objects.all()