from django.db import models
from account.models import Account
from school.models import School
from school_children.models import SchoolChildren

# Create your models here.
class EventEvent(models.Model):
    id = models.BigAutoField(primary_key=True)
    status = models.CharField(max_length=50, blank=True, null=True)
    created_at = models.DateTimeField()
    deliver_at = models.DateTimeField(blank=True, null=True)
    note = models.CharField(max_length=200, blank=True, null=True)
    picked_at = models.DateTimeField(blank=True, null=True)
    child = models.ForeignKey(SchoolChildren, models.DO_NOTHING, blank=True, null=True)
    parent = models.ForeignKey(Account, models.DO_NOTHING, blank=True, null=True)
    school = models.ForeignKey(School, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'event_event'
