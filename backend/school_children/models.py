from django.db import models
from school.models import School
from admin.models import Admin
from grade.models import Grade

# Create your models here.
class SchoolChildren(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    age = models.IntegerField(blank=True, null=True)
    email = models.CharField(unique=True, max_length=254, blank=True, null=True)
    parent_email = models.CharField(max_length=254, blank=True, null=True)
    gender = models.CharField(max_length=200, blank=True, null=True)
    birth_date = models.DateField(blank=True, null=True)
    code = models.IntegerField(blank=True, null=True)
    child_image = models.CharField(max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=17, blank=True, null=True)
    parent_phone = models.CharField(max_length=17, blank=True, null=True)
    removed = models.IntegerField()
    status = models.CharField(max_length=50)
    can_resend_activation = models.IntegerField()
    admin = models.ForeignKey(Admin, models.DO_NOTHING, blank=True, null=True)
    #children_classes = models.ForeignKey(Class, models.DO_NOTHING, db_column='children_classes', blank=True, null=True)
    grade = models.ForeignKey(Grade, models.DO_NOTHING, db_column='grade', blank=True, null=True)
    #relation = models.ForeignKey(Relation, models.DO_NOTHING, blank=True, null=True)
    school = models.ForeignKey(School, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'school_children'