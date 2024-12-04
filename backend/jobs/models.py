from django.db import models

def category_image_upload_to(instance, filename):
  return f"job_category/{filename}"

class JobCategory(models.Model):
  category = models.CharField(max_length=100, unique=True);
  image = models.ImageField(upload_to=category_image_upload_to)
  
  def __str__(self):
    return self.category
