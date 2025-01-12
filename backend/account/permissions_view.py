from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from django.db.models import Q, Count
from rest_framework import serializers, viewsets
from django.contrib.auth.management import create_permissions

from .models import Account
from constants import api_response, ApiStatus, error_serialization

from rest_framework.pagination import LimitOffsetPagination
from django.apps import apps

from custom_group.models import CustomGroup
from custom_group.serializer import GroupSerializer


class DefaultPagination(LimitOffsetPagination):
    page_size = 2


class PermissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = '__all__'


class DetailsPermissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = '__all__'
        depth = 1


class ContentTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContentType
        fields = '__all__'


class AllUserPermissions(viewsets.ModelViewSet):
    queryset = Permission.objects.all()
    serializer_class = DetailsPermissionSerializer

    def create(self, request):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_create(serializer)
        return api_response(data=serializer.data)

    def list(self, request):
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return api_response(data=serializer.data, count=queryset.count())

        serializer = self.get_serializer(queryset, many=True)
        return api_response(data=serializer.data, count=queryset.count())

    def retrieve(self, request, pk):
        instance = Permission.objects.filter(pk=pk)
        if not instance:
            return api_response(error='not found', status=ApiStatus.notFound)
        serializer = PermissionSerializer(instance[0])
        return api_response(data=serializer.data)

    def update(self, request, pk):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_update(serializer)
        instance = self.get_object()
        period_serializer = PermissionSerializer(instance)
        return api_response(data=period_serializer.data)


class AllContentTypePermissions(viewsets.ModelViewSet):
    queryset = ContentType.objects.all()
    serializer_class = ContentTypeSerializer

    def create(self, request):
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_create(serializer)
        return api_response(data=serializer.data)

    def list(self, request):
        queryset = self.filter_queryset(self.get_queryset())

        print('-------query count=' + str(queryset.count()))
        all_content_type = []

        content = ContentType.objects.filter(model='academic')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Academic Year'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='subject')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Subjects'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='teacher')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Employee'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='scheduleitem')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Schedule'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='schoolchild')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Students'
        all_content_type.append(data)
        content = ContentType.objects.filter(model='grade')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Grades'
        all_content_type.append(data)
        content = ContentType.objects.filter(model='schoolclass')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Class'
        all_content_type.append(data)
        content = ContentType.objects.filter(model='customgroup')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Permission Groups'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='rule')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'Roles'
        all_content_type.append(data)

        content = ContentType.objects.filter(model='school')
        data = ContentTypeSerializer(content[0]).data
        data['app_label'] = 'School account'
        all_content_type.append(data)

        queryset = self.filter_queryset(self.get_queryset())
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return api_response(data=all_content_type, count=queryset.count())

        serializer = self.get_serializer(queryset, many=True)
        return api_response(data=all_content_type, count=queryset.count())

    def retrieve(self, request, pk):
        instance = Group.objects.filter(pk=pk)
        if not instance:
            return api_response(error='not found', status=ApiStatus.notFound)
        serializer = GroupSerializer(instance[0])
        return api_response(data=serializer.data)

    def update(self, request, pk):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_update(serializer)
        instance = self.get_object()
        group_serializer = GroupSerializer(instance)
        return api_response(data=group_serializer.data)


class UserPermissions(viewsets.ModelViewSet):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer

    def create(self, request):
        groups = request.data['groups']
        users = request.data['users']
        for item in users:
            user = Account.objects.get(pk=item)
            user.groups.set(groups)
        return api_response()

    def retrieve(self, request, pk):
        user = Account.objects.get(pk=pk)
        queryset = user.groups

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return api_response(data=serializer.data, count=queryset.count())

        serializer = self.get_serializer(queryset, many=True)
        return api_response(data=serializer.data, count=queryset.count())
