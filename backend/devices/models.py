from django.db import models
from account.models import Account

# Create your models here.


class Device(models.Model):
    account_id = models.ForeignKey(Account, related_name='devices', on_delete=models.CASCADE,
                                   null=True, blank=True, db_column='account_id')
    device_id = models.CharField(null=True, blank=True, max_length=200)
    device_token = models.CharField(null=True, blank=True, max_length=500)
    verified = models.BooleanField(default=False)

    def __str__(self):
        return self.device_id

    class Meta:
        db_table = "device"
