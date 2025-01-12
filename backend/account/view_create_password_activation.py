from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView

from account.serializer import CreateAccountSerializer, AccountSerializer
from constants import api_response, error_serialization, ApiStatus


class CreateNewPassword(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        serializer = CreateAccountSerializer(user, data=request.data, partial=True)
        if not serializer.is_valid():
            return api_response(error=error_serialization(serializer.errors), status=ApiStatus.fail)
        user.set_password(request.data['password'])
        user.save()
        return api_response()
