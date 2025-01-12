from rest_framework import serializers

from account.permissions_view import GroupSerializer
from account.serializer import AccountSerializer
from admin.models import Admin


class AdminSerializer(serializers.ModelSerializer):
    account = AccountSerializer(required=False),

    class Meta:
        model = Admin
        fields = '__all__'
        depth = 2


class DefaultAdminSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admin
        fields = '__all__'


class ShortAdminSerializer(serializers.ModelSerializer):
    account = AccountSerializer(required=False),

    class Meta:
        model = Admin
        fields = ['account']
        depth = 1
