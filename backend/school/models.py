from django.db import models

# Create your models here.

class School(models.Model):
    id = models.BigAutoField(primary_key=True)
    school_name = models.CharField(max_length=200)
    phone = models.CharField(unique=True, max_length=17, blank=True, null=True)
    school_domain = models.CharField(unique=True, max_length=100, blank=True, null=True)
    student_domain = models.CharField(unique=True, max_length=100, blank=True, null=True)
    time_zone = models.CharField(unique=True, max_length=50, blank=True, null=True)
    address = models.CharField(max_length=200, blank=True, null=True)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)
    terms = models.IntegerField()
    logo = models.CharField(max_length=100, blank=True, null=True)
    #admin = models.ForeignKey(Admin, models.DO_NOTHING, blank=True, null=True)
    enable_drop = models.IntegerField()
    pickup_range = models.FloatField(blank=True, null=True)
    picup_endtime = models.TimeField(db_column='picup_endTime', blank=True, null=True)  # Field name made lowercase.
    picup_starttime = models.TimeField(db_column='picup_startTime', blank=True, null=True)  # Field name made lowercase.
    visible = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'school'
