from django.contrib.auth.models import Permission
from django.db import models

# Create your models here.
from django.db.models import UniqueConstraint
from django.utils.translation import gettext_lazy as _
from school.models import School

class CustomGroup(models.Model):
    name = models.CharField(_("name"), max_length=150)
    description = models.CharField(max_length=150, null=True,blank=True)
    school = models.ForeignKey(School, on_delete=models.CASCADE, db_column='school_id', null=True)
    permissions = models.ManyToManyField(
        Permission,
        verbose_name=_("permissions"),
        related_name='custom_group_permissions',
        blank=True,
    )

    class Meta:
        db_table = "custom_group"
        constraints = [
            UniqueConstraint(
                fields=['name', 'school'],
                name='group_unique_error',
            ),
        ]
