from django.conf import settings
from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.core.validators import RegexValidator
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _
from rest_framework.authtoken.models import Token

from custom_group.models import CustomGroup


class CustomUserManager(BaseUserManager):
    """
    Custom user model manager where email is the unique identifiers
    for authentication instead of usernames.
    """

    def create_user(self, email, password, **extra_fields):
        """
        Create and save a User with the given email and password.
        """
        if not email:
            raise ValueError(_('The Email must be set'))
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email, password, **extra_fields):
        """
        Create and save a SuperUser with the given email and password.
        """
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))
        return self.create_user(email, password, **extra_fields)


def user_directory_path(instance, filename):
    # file will be uploaded to MEDIA_ROOT / user_<id>/<filename>
    return 'user_{0}/{1}'.format(instance.id, filename)


GENDER_CHOICES = (
    ('male', 'male'),
    ('female', 'female'),
    ('prefer_not', 'prefer not to say'),
)

LOGIN_AS = (
    ('school', 'school'),
    ('employee', 'employee'),
    ('parent', 'parent'),
)


class Account(AbstractUser):
    id = models.BigAutoField(primary_key=True)
    username = None
    name = models.CharField(max_length=100, null=True)
    email = models.EmailField(_('email address'), unique=False, null=True)
    secondary_email = models.EmailField(_('email address'), null=True)
    password_regex = RegexValidator(regex=r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$.!%*?&#-])[A-Za-z\d@$.!%*?&#-]{8,16}$',
                                    message="Minimum eight and maximum 16 characters, at least one uppercase letter, one lowercase letter, one number and one special character")

    password = models.CharField(max_length=300, validators=[password_regex], null=True)
    marital_status = models.CharField(max_length=200, null=True)
    gender = models.CharField(max_length=200, choices=GENDER_CHOICES, null=True)
    login_as = models.CharField(max_length=200, choices=LOGIN_AS, null=True)
    temporary_password = models.BooleanField(default=False)
    alternative_password = models.CharField(max_length=300, null=True)
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',
                                 message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    phone = models.CharField(_('phone number'), validators=[phone_regex], max_length=17,
                             null=True, unique=True)  # validators should be a list
    secondary_phone = models.CharField(_('phone number'), validators=[phone_regex], max_length=17,
                                       null=True)  # validators should be a list
    birth_date = models.DateField(null=True)
    activated = models.BooleanField(null=True)
    email_verified = models.BooleanField(default=False, null=True)
    phone_verified = models.BooleanField(default=False, null=True)
    term_condition = models.BooleanField(default=False, null=True)
    user_image = models.ImageField(upload_to=user_directory_path, null=True, blank=True)
    code = models.IntegerField(null=True)
    search_text = models.CharField(max_length=50, null=True)
    search_user_id = models.IntegerField(null=True)
    groups = models.ManyToManyField(CustomGroup, related_name='custom_group',
                                    db_column='group')

    class Meta:
        db_table = "account"

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def save(self, *args, **kwargs):
        print('------------------saving------------')
        super(Account, self).save(*args, **kwargs)
        return self.pk


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        print('----------token created---------------')
        Token.objects.create(user=instance)
