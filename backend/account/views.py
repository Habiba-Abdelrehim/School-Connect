import os
from random import randint
from django.utils import timezone
from PIL import Image
from django.contrib.auth.hashers import make_password
from django.core.mail import EmailMessage
# Create your views here.
from django.http import HttpResponse
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode
from rest_framework import status, generics, mixins
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from .backends import MyAuthBackend
from .models import Account
from .serializer import AccountSerializer, AuthSerializer, ResetPasswordSerializer, ForgetPasswordSerializer
from .token_generator import account_activation_token
from admin.models import Admin, ROLES
from admin.serializer import DefaultAdminSerializer
from constants import api_response, ApiStatus, error_serialization
from devices.serializer import DeviceSerializer
from devices.models import Device
from backend.settings import Testing, testing_emails
import backend.settings as settings


class UserLogin(APIView):
    serializer_class = AuthSerializer
    def post(self, request):
        print('------------login request----------------')
        print('----------------------------------------------')
        print(request.data)
        request.data._mutable=True
        serializer = self.serializer_class(data=request.data, )
        if not serializer.is_valid():
            print(serializer._errors)
            return api_response(error={"non_field_errors": "Unable to log in with provided credentials"},
                                status=ApiStatus.fail)
        user = serializer.validated_data['user']
        account_serializer = AccountSerializer(user)
        token, created = Token.objects.get_or_create(user=user)
        token = token.key
        data = account_serializer.data
        data.pop('password', None)
        user = Account.objects.get(email=user)
        Account.objects.filter(id=user.id).update(last_login=timezone.now())
        data['token'] = token
        request.data['account_id'] = user.pk
        device_serializer = DeviceSerializer(data=request.data)
        if device_serializer.is_valid():
            device_serializer.save()
        else:
            print(device_serializer.errors)

        return api_response(data=data)


class UserLogout(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        if 'device_token' in request.data:
            print('------------------remove token')
            print(request.data['device_token'])
            Device.objects.filter(device_token=request.data['device_token']).delete()
        return api_response(message={"success": 'done'})


class ChangeForgetPassword(APIView):

    def put(self, request):
        serializer = ForgetPasswordSerializer(data=request.data)
        
        if not serializer.is_valid():
            return api_response(error=error_serialization(serializer.errors), status=ApiStatus.fail)
        print(serializer.errors)
        email = serializer.data['email']
        account = Account.objects.get(email=email)
        password = make_password(serializer.data['password'])
        account.password = password
        account.save()
        account_serializer = AccountSerializer(account)
        token, created = Token.objects.get_or_create(user=account)
        token = token.key
        data = account_serializer.data
        data.pop('password', None)
        data['token'] = token
        return api_response(data=data)

class ResetPassword(APIView):
    def put(self, request):
        serializer = ResetPasswordSerializer(data=request.data)
        if serializer.is_valid():
            if serializer.data['email']:
                accounts = Account.objects.filter(email=serializer.data['email'])
            elif serializer.data['phone']:
                accounts = Account.objects.filter(phone=serializer.data['phone'])

            if not accounts:
                if serializer.data['email']:
                    return api_response(error={"email": " this email not exist"},
                                        status=ApiStatus.fail)
                elif serializer.data['phone']:
                    return api_response(error={"phone": " this phone not exist"},
                                        status=ApiStatus.fail)
            """
            change password for user and all it's accounts 
            """
            new_code = get_code(6)
            account = accounts[0]
            account.temporary_password = True
            account.code = new_code
            account.save()

            account_serializer = AccountSerializer(accounts[0])
            if serializer.data['email']:
                forget_password_to_email(account_serializer.data['email'], new_code)
            return api_response(data=new_code, message={"password": "password reset successfully"})
        else:
            print('error')
            return api_response(error=error_serialization(serializer.errors), status=ApiStatus.fail)


def get_code(limit=6):
    code = ''
    for _ in range(limit):
        code += str(randint(1, 9))
    return code


def forget_password_to_email(email, code):
    try:
        print(code)
        html_version = 'email_body.html'

        html_message = render_to_string(html_version, {'code': code, 'title': "Forgot Password",
                                                       'body': 'Please enter this code on the dashboard to be able to reset a new password.',
                                                       'hint': 'Your Verification Code :'})

        emails = [email]
        if Testing:
            emails.extend(testing_emails)

        message = EmailMessage('Forgot Password Verification Code', html_message, settings.EMAIL_HOST_USER, emails)
        message.content_subtype = 'html'  # this is required because there is no plain text email version
        message.send()
    except Exception as e:
        print(e)
        print('-------------------------send verification code error------------') 