from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView

from constants import api_response
from .models import Device


class RemoveAllDevices(APIView):

    def delete(self, request):
        Device.objects.all().delete()
        return api_response()
