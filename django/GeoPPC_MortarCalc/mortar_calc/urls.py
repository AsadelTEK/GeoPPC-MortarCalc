from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('create/', views.material_data_create, name='create'),
    path('result/<int:pk>/', views.calculation_result, name='result'),
]
