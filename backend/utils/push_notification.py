import requests
from django.conf import settings

def send_push_notification(user, message):
    fcm_token = user.fcm_token 

    if fcm_token:
        headers = {
            'Authorization': f'key={settings.FCM_SERVER_KEY}',
            'Content-Type': 'application/json',
        }
        payload = {
            'to': fcm_token,
            'notification': {
                'title': 'New Application Status',
                'body': message,
            },
            'data': {
                'message': message,
                'actor': user.actor.username, 
            }
        }
        response = requests.post('https://fcm.googleapis.com/fcm/send', json=payload, headers=headers)
        print(response.status_code, response.json()) 