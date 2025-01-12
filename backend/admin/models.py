from django.db import models
from account.models import Account
from school.models import School


ROLES = (('admin', 'admin'), ('employee', 'employee'), ('teacher', 'teacher'), ('child', 'child'))

# Create your models here.
class Admin(models.Model):
    id = models.BigAutoField(primary_key=True)
    role = models.CharField(max_length=100, choices=ROLES)
    parent = models.ForeignKey(Account, models.DO_NOTHING, blank=True, null=True)
    school = models.ForeignKey(School, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        db_table = 'admin'