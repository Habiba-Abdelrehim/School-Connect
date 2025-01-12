from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializers import SchoolSerializer, StudentsSerializer, ParentsSerializer, EventSerializer
from school.models import School
from school_children.models import SchoolChildren
from admin.models import Admin
from event.models import EventEvent
from datetime import datetime
from dateutil import parser
import statistics, pandas as pd

# helper functions for the api views functions
def getSchoolID(school_name):
    schools = School.objects.all()
    serializer = SchoolSerializer(schools, many=True) 
    for school in serializer.data: 
        if school["school_name"] == school_name:
            school_id = school["id"]
            return school_id
    return "null"

def getDismissalDeltas(school_name):
    events = EventEvent.objects.all()
    serializer = EventSerializer(events, many=True)
    school_id = getSchoolID(school_name) 
    if school_id == "null": return [0]
    dismissal_deltas_list = []
    for event in serializer.data: 
        if event["school_id"] == school_id:
            if event["deliver_at"] != None:
                difference = parser.parse(event["deliver_at"]) - parser.parse(event["created_at"])
                seconds = difference.total_seconds() 
                minutes = divmod(seconds, 60)[0]
                dismissal_deltas_list.append(minutes)
            if event["picked_at"] != None:
                difference = parser.parse(event["picked_at"]) - parser.parse(event["deliver_at"])
                seconds = difference.total_seconds() 
                minutes = divmod(seconds, 60)[0]
                dismissal_deltas_list.append(minutes) 
    return dismissal_deltas_list

# api functions
@api_view(['GET'])
def getSchoolsList(request):
    schools = School.objects.all()
    serializer = SchoolSerializer(schools, many=True)
    schools_list=[]
    for school in serializer.data:
        schools_list.append(school["school_name"])
    return Response(schools_list)

@api_view(['GET'])
def getTotalStudents(request, school_name):
    students = SchoolChildren.objects.all()
    serializer = StudentsSerializer(students, many=True)
    school_id = getSchoolID(school_name)
    totalStudents = 0
    for student in serializer.data:
        if student["school_id"] == school_id:
            totalStudents=totalStudents+1
    return Response(totalStudents)

@api_view(['GET'])
def getTotalParents(request, school_name):
    school_admin = Admin.objects.all()
    serializer = ParentsSerializer(school_admin, many=True)
    school_id = getSchoolID(school_name)
    totalParents = 0
    for parent in serializer.data:
        if parent["school_id"] == school_id:
            totalParents=totalParents+1
    return Response(totalParents)

@api_view(['GET'])
def getDismissalAverage(request, school_name):
    dismissalAverage = statistics.mean(getDismissalDeltas(school_name))
    return Response(dismissalAverage)

@api_view(['GET'])
def getDismissalMedian(request, school_name):
    dismissalMedian = statistics.median(getDismissalDeltas(school_name))
    return Response(dismissalMedian)

@api_view(['GET'])
def getGradeList(request, school_name):
    school_children = SchoolChildren.objects.all()
    serializer = StudentsSerializer(school_children, many=True)
    school_id = getSchoolID(school_name)
    df = pd.DataFrame(serializer.data)
    school_df = df.loc[df['school_id'] == school_id]
    gradeList=[]
    for i in range(1,13):
        try:
            gradeList.append(school_df['grade'].value_counts()[i])
        except:
            gradeList.append(0)
    return Response(gradeList)

@api_view(['GET'])
def getUserSchool(request, user_id):
    school_admin = Admin.objects.all()
    parent_serializer = ParentsSerializer(school_admin, many=True)
    schools = School.objects.all()
    school_serializer = SchoolSerializer(schools, many=True)
    school_name=""
    for parent in parent_serializer.data: 
        if parent["parent_id"] == user_id:
            school_id =parent["school_id"]
    for school in school_serializer.data: 
        if school["id"] == school_id:
            school_name = school["school_name"]
    return Response(school_name)
    