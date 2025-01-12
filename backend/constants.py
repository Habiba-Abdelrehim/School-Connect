import enum
from rest_framework.response import Response
from rest_framework import status as stat


class ApiStatus(enum.Enum):
    success = 200
    fail = 400
    notFound = 404
    parametersNotValid = 400
    applicationException = 500
    sessionExists = 400
    unauthorized = 401
    oTPRequired = 401
    emailVerifyRequired = 400


def api_response(data=None, status=ApiStatus.success, message=None, error=None, count=None):
    print(count)
    if error:
        status = ApiStatus.fail
    data = {"data": data, "message": message, "status": status.name, "errors": error}
    if count:
        data['count'] = count
    return Response(data, status=stat.HTTP_200_OK)


def error_serialization(error):
    print(error)
    data = {}
    for item in error:
        print(item, error[item][0])
        data[item] = error[item][0]
    return dict(data)
