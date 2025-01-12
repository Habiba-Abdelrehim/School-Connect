from django.urls import path
from . import views

urlpatterns = [
    path('', views.getSchoolsList),
    path('<int:user_id>', views.getUserSchool),
    path('<str:school_name>/students/total', views.getTotalStudents),
    path('<str:school_name>/parents/total', views.getTotalParents),
    path('<str:school_name>/dismissal/average', views.getDismissalAverage),
    path('<str:school_name>/dismissal/median', views.getDismissalMedian),
    path('<str:school_name>/students/totalpergrade', views.getGradeList)
]