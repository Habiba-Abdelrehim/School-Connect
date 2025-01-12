from rest_framework import serializers
from school.models import School
from school_children.models import SchoolChildren
from admin.models import Admin
from event.models import EventEvent

class SchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = School
        fields = ['id','school_name']

class StudentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SchoolChildren
        fields = ['id', 'grade', 'school_id']

class ParentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admin
        fields = ['parent_id','school_id']

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventEvent
        fields = ['created_at', 'deliver_at', 'picked_at', 'school_id']