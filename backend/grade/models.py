from django.db import models
from school.models import School

# Create your models here.
class Grade(models.Model):
    id = models.BigAutoField(primary_key=True)
    title = models.CharField(max_length=100)
    slot_duration = models.CharField(max_length=50, blank=True, null=True)
    slots = models.IntegerField(blank=True, null=True)
    enable_slots_on_classes = models.IntegerField()
    removed = models.IntegerField()
    status = models.CharField(max_length=50)
    #academic = models.ForeignKey(Academic, models.DO_NOTHING)
    #grad_period = models.ForeignKey('Period', models.DO_NOTHING, db_column='grad_period', blank=True, null=True)
    school = models.ForeignKey(School, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'grade'
        unique_together = (('title', 'school'),)