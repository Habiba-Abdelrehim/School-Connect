from django.core.validators import RegexValidator
from rest_framework import serializers

from .backends import MyAuthBackend
from .models import Account




class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = '__all__'
        depth = 1

    # set_password to be encrypted to validate login later if not set can't login later
    def create(self, validated_data, ):
        print('----create account ----------')
        # try to save
        user = Account.objects.create(**validated_data)

        if user:
            user.set_password(validated_data['password'])
            user.save()
            return user
        else:
            return None


class CreateAccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['id', 'email', 'phone', 'password', 'first_name', 'last_name', 'name', 'user_image', 'birth_date',
                  'gender',
                  'term_condition', 'login_as', 'code', 'email_verified', 'phone_verified']

    # set_password to be encrypted to validate login later if not set can't login later
    def create(self, validated_data, ):
        print('----create account ----------')
        # try to save
        user = Account.objects.create(**validated_data)

        if user:
            if 'password' in validated_data:
                user.set_password(validated_data['password'])
                user.save()
            return user
        else:
            return None


class AuthSerializer(serializers.ModelSerializer):
    device_id = serializers.CharField(max_length=200, required=False)
    device_token = serializers.CharField(max_length=500, required=False)
    email = serializers.CharField(
        label="email",
        write_only=True,
        required=False
    )
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',
                                 message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")

    phone = serializers.CharField(
        label="phone",
        write_only=True,
        required=False,
        validators=[phone_regex], max_length=17,
    )
    password = serializers.CharField(
        label="Password",
        style={'input_type': 'password'},
        trim_whitespace=False,
        write_only=True
    )

    def validate(self, attrs):
        print('validating')
        email = attrs.get('email')
        phone = attrs.get('phone')
        password = attrs.get('password')

        if email and password:
            check_if_user_exists = Account.objects.filter(email=email).exists()
            print('--------------account exist-------------')
            print(check_if_user_exists)
            user = MyAuthBackend.authenticate(email=email, password=password)

            if not user:
                msg = 'Unable to log in with provided credentials.'
                raise serializers.ValidationError(msg, code='authorization')
        elif phone and password:
            check_if_user_exists = Account.objects.filter(phone=phone).exists()
            print('--------------phone account exist-------------')
            print(check_if_user_exists)
            user = MyAuthBackend.authenticate(phone=phone, password=password)

            if not user:
                msg = 'Unable to log in with provided credentials.'
                raise serializers.ValidationError(msg, code='authorization')
        else:
            msg = 'Must include "email" and "password".'
            raise serializers.ValidationError(msg, code='authorization')

        attrs['user'] = user
        return attrs

    class Meta:
        model = Account
        fields = ['email', 'phone', 'password', 'device_id', 'device_token']


class ResetPasswordSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required=False, allow_null=True)
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',
                                 message="Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")
    phone = serializers.CharField(validators=[phone_regex], max_length=17,
                                  allow_null=True, required=False)

    class Meta:
        model = Account
        fields = ['email', 'phone', 'code']


class ForgetPasswordSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['email', 'password']