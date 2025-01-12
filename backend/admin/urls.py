from django.urls import path

# use this api to login using email and password
from . import views

urlpatterns = [
    path('<int:id>/', views.getSchoolAdmin)
]
