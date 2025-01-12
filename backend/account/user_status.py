from rest_framework.views import APIView

from constants import api_response
from general_static_methods import ALLAvailableStatus, ActiveInactivePendingStatus, ActiveInactiveStatus


class AvailableStatus(APIView):

    def get(self, request):
        return api_response(dict(ActiveInactivePendingStatus))


class ActiveInactiveStatusView(APIView):

    def get(self, request):
        return api_response(dict(ActiveInactiveStatus))
