# Create your views here.
from rest_framework.response import Response
from rest_framework.decorators import api_view
from admin.models import Admin
from admin.serializer import AdminSerializer
from constants import api_response

@api_view(['GET'])
def getSchoolAdmin(request, id):
    admin = Admin.objects.filter(school=id)
    admin_serializer = AdminSerializer(admin, many=True)
    return Response(admin_serializer.data)

