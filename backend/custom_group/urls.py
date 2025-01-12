from rest_framework.routers import DefaultRouter
from django.urls import path, include

from .views import AllGroupPermissions

router = DefaultRouter()
router.register(r'group', AllGroupPermissions)
urlpatterns = [
    path('', include(router.urls)),
]