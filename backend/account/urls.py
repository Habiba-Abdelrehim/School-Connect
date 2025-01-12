from django.urls import path, include

from rest_framework.authtoken import views
from rest_framework.routers import DefaultRouter

# use this api to login using email and password
from account.permissions_view import AllUserPermissions, AllContentTypePermissions, \
    UserPermissions
from account.user_status import AvailableStatus, ActiveInactiveStatusView
from account.view_create_password_activation import CreateNewPassword
from account.views import UserLogin, UserLogout, ChangeForgetPassword, ResetPassword


router = DefaultRouter()
router.register(r'permission', AllUserPermissions)
router.register(r'models_type', AllContentTypePermissions)
router.register(r'user/permissions', UserPermissions)

urlpatterns = [
    path('login', UserLogin.as_view()),
    path('logout', UserLogout.as_view()),
    path('reset/password', ChangeForgetPassword.as_view()),
    path('send/code', ResetPassword.as_view()) 
]
