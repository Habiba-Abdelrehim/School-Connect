# Generated by Django 4.1.4 on 2022-12-31 00:13

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Grade',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=100)),
                ('slot_duration', models.CharField(blank=True, max_length=50, null=True)),
                ('slots', models.IntegerField(blank=True, null=True)),
                ('enable_slots_on_classes', models.IntegerField()),
                ('removed', models.IntegerField()),
                ('status', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'grade',
                'managed': False,
            },
        ),
    ]