# Generated by Django 4.1.4 on 2022-12-30 22:30

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='EventEvent',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('status', models.CharField(blank=True, max_length=50, null=True)),
                ('created_at', models.DateTimeField()),
                ('deliver_at', models.DateTimeField(blank=True, null=True)),
                ('note', models.CharField(blank=True, max_length=200, null=True)),
                ('picked_at', models.DateTimeField(blank=True, null=True)),
            ],
            options={
                'db_table': 'event_event',
                'managed': False,
            },
        ),
    ]
