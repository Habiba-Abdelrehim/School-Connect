import django_filters
from django.contrib.auth.models import Permission
from django.db.models import Count, Q
# Create your views here.
from rest_framework import viewsets

from account.models import Account
from constants import api_response, ApiStatus, error_serialization
from .models import CustomGroup
from .serializer import GroupSerializer
from school.models import School


class AllGroupPermissions(viewsets.ModelViewSet):
    queryset = CustomGroup.objects.all()
    serializer_class = GroupSerializer
    filter_backends = [django_filters.rest_framework.DjangoFilterBackend]
    filterset_fields = ['school']

    def create(self, request):
        print(request.data)
        serializer = self.get_serializer(data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_create(serializer)
        return api_response(data=serializer.data)

    def list(self, request):
        keys = dict(request.GET)
        order_direction = 'ASC'
        group = CustomGroup.objects.filter(school=keys['school'][0])
        print('group------=')
        if not group:
            school = School.objects.get(pk=keys['school'][0])
            group = CustomGroup.objects.create(name='Owner',school=school)
            permissions_list = Permission.objects.all()
            group.permissions.set(permissions_list)
        queryset = self.filter_queryset(self.get_queryset())
        if 'search_text' in keys:
            queryset = queryset.filter(Q(name__icontains=keys['search_text'][0]))

        if 'order_by' in keys:
            if 'order_direction' in keys:
                order_direction = keys['order_direction'][0]
            order = ''
            if keys['order_by'][0] == 'users':
                if order_direction == 'DESC':
                    order = '-q_count'
                else:
                    order = 'q_count'
                queryset = queryset.annotate(q_count=Count('user'))
            if keys['order_by'][0] == 'title':
                if order_direction == 'DESC':
                    order = '-name'
                else:
                    order = 'name'
            queryset = queryset.order_by(order)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            for item in serializer.data:
                accounts = Account.objects.filter(groups=item['id']).values_list('id', flat=True)
                item['users'] = accounts
            return api_response(data=serializer.data, count=queryset.count())

        serializer = self.get_serializer(queryset, many=True)
        return api_response(data=serializer.data, count=queryset.count())

    def retrieve(self, request, pk):
        instance = CustomGroup.objects.filter(pk=pk)
        if not instance:
            return api_response(error='not found', status=ApiStatus.notFound)
        serializer = GroupSerializer(instance[0])
        return api_response(data=serializer.data)

    def destroy(self, request, *args, **kwargs):
        group = self.get_object()
        group.delete()
        return api_response()

    def update(self, request, pk):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data)
        if not serializer.is_valid():
            return api_response(status=ApiStatus.fail, error=error_serialization(serializer.errors))
        self.perform_update(serializer)
        instance = self.get_object()
        group_serializer = GroupSerializer(instance)
        return api_response(data=group_serializer.data)
