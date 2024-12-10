from rest_framework.generics import ListAPIView, UpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Notification
from .serializer import NotificationSerializer
from datetime import timedelta
from django.utils.timezone import now

class NotificationListView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
    
        user = request.user

        current_time = now()

        unread_notifications = Notification.objects.filter(
            receiver=user, is_read=False
        ).order_by('-created_at')

        last_7_days_notifications = Notification.objects.filter(
            receiver=user, created_at__gte=current_time - timedelta(days=7), is_read = True
        ).order_by('-created_at')

        last_30_days_notifications = Notification.objects.filter( is_read = True, 
            receiver=user, created_at__gte=current_time - timedelta(days=30)
        ).exclude(created_at__gte=current_time - timedelta(days=7)).order_by('-created_at')

    
        unread_data = NotificationSerializer(unread_notifications, many=True, context={'request': request}).data
        last_7_days_data = NotificationSerializer(last_7_days_notifications, many=True, context={'request': request}).data
        last_30_days_data = NotificationSerializer(last_30_days_notifications, many=True, context={'request': request}).data


        response = {
            "new": unread_data,
            "last_7_days": last_7_days_data,
            "last_30_days": last_30_days_data,
        }

        return Response(response)

class UnreadNotificationListView(ListAPIView):
    serializer_class = NotificationSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Notification.objects.filter(receiver=self.request.user, is_read=False).order_by('-created_at')

    def get_serializer_context(self):
     return {'request':self.request}

class MarkAllNotificationsReadView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        notifications = Notification.objects.filter(receiver=request.user, is_read=False)
        notifications.update(is_read=True)
        
        print("okey !")
        return Response({'message': 'All notifications marked as read.'}, status=200)

    def get_serializer_context(self):
     return {'request':self.request}