# use this api to login using email and password
from django.urls import path

from .views import RemoveAllDevices

urlpatterns = [
    path('delete/all/devices', RemoveAllDevices.as_view()),

]
