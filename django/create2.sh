#!/bin/bash

# Nama project dan aplikasi Django
PROJECT_NAME="GeoPPC_MortarCalc"
APP_NAME="mortar_calc"

# Fungsi untuk memeriksa keberhasilan eksekusi perintah
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Buat virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
check_success "Failed to create virtual environment"

# Aktifkan virtual environment
echo "Activating virtual environment..."
source venv/bin/activate
check_success "Failed to activate virtual environment"

# Instal Django
echo "Installing Django..."
pip install django
check_success "Failed to install Django"

# Buat project Django
echo "Creating Django project..."
django-admin startproject $PROJECT_NAME
check_success "Failed to create Django project"

# Pindah ke direktori project
cd $PROJECT_NAME

# Buat aplikasi Django
echo "Creating Django app..."
python manage.py startapp $APP_NAME
check_success "Failed to create Django app"

# Update settings.py untuk mendaftarkan aplikasi dan mengatur database
echo "Updating settings.py..."
SETTINGS_FILE="$PROJECT_NAME/settings.py"
sed -i "/INSTALLED_APPS = \[/ a\    '$APP_NAME'," $SETTINGS_FILE

# Buat model di models.py
echo "Creating models.py..."
cat <<EOL > $APP_NAME/models.py
from django.db import models

class MaterialData(models.Model):
    fly_ash = models.DecimalField(max_digits=5, decimal_places=2)
    tanah_putih = models.DecimalField(max_digits=5, decimal_places=2)
    naoh = models.DecimalField(max_digits=5, decimal_places=2)
    air = models.DecimalField(max_digits=5, decimal_places=2)
    pasir = models.DecimalField(max_digits=5, decimal_places=2)

class CalculationResult(models.Model):
    material_data = models.OneToOneField(MaterialData, on_delete=models.CASCADE)
    compressive_strength = models.DecimalField(max_digits=8, decimal_places=2)
    tensile_strength = models.DecimalField(max_digits=8, decimal_places=2)
    porosity = models.DecimalField(max_digits=5, decimal_places=2)
    density = models.DecimalField(max_digits=8, decimal_places=2)
    absorption = models.DecimalField(max_digits=5, decimal_places=2)
EOL

# Buat form di forms.py
echo "Creating forms.py..."
cat <<EOL > $APP_NAME/forms.py
from django import forms
from .models import MaterialData

class MaterialDataForm(forms.ModelForm):
    class Meta:
        model = MaterialData
        fields = ['fly_ash', 'tanah_putih', 'naoh', 'air', 'pasir']
EOL

# Buat view di views.py
echo "Creating views.py..."
cat <<EOL > $APP_NAME/views.py
from django.shortcuts import render, redirect
from .forms import MaterialDataForm
from .models import MaterialData, CalculationResult

def calculate_mechanical_properties(data):
    fly_ash = float(data.fly_ash)
    tanah_putih = float(data.tanah_putih)
    naoh = float(data.naoh)
    air = float(data.air)
    pasir = float(data.pasir)

    compressive_strength = fly_ash * 1.5
    tensile_strength = tanah_putih * 2.0
    porosity = naoh * 0.1
    density = air * 1.1
    absorption = pasir * 0.05
    return compressive_strength, tensile_strength, porosity, density, absorption

def material_data_create(request):
    if request.method == 'POST':
        form = MaterialDataForm(request.POST)
        if form.is_valid():
            material_data = form.save()
            compressive_strength, tensile_strength, porosity, density, absorption = calculate_mechanical_properties(material_data)
            CalculationResult.objects.create(
                material_data=material_data,
                compressive_strength=compressive_strength,
                tensile_strength=tensile_strength,
                porosity=porosity,
                density=density,
                absorption=absorption
            )
            return redirect('result', pk=material_data.pk)
    else:
        form = MaterialDataForm()
    return render(request, '$APP_NAME/material_data_form.html', {'form': form})

def calculation_result(request, pk):
    result = CalculationResult.objects.get(material_data__pk=pk)
    return render(request, '$APP_NAME/calculation_result.html', {'result': result})

def dashboard(request):
    return render(request, '$APP_NAME/dashboard.html')
EOL

# Buat urls.py di aplikasi
echo "Creating urls.py..."
cat <<EOL > $APP_NAME/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('create/', views.material_data_create, name='create'),
    path('result/<int:pk>/', views.calculation_result, name='result'),
]
EOL

# Update urls.py di project utama
echo "Updating project urls.py..."
cat <<EOL > $PROJECT_NAME/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('$APP_NAME/', include('$APP_NAME.urls')),
]
EOL

# Buat template directory dan file template
echo "Creating templates..."
mkdir -p $APP_NAME/templates/$APP_NAME

cat <<EOL > $APP_NAME/templates/$APP_NAME/base.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}GeoPPC MortarCalc{% endblock %}</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="{% url 'dashboard' %}">GeoPPC MortarCalc</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="{% url 'create' %}">Input Data</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Results</a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container mt-4">
        {% block content %}
        {% endblock %}
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
EOL

cat <<EOL > $APP_NAME/templates/$APP_NAME/dashboard.html
{% extends '$APP_NAME/base.html' %}

{% block title %}Dashboard{% endblock %}

{% block content %}
<h1>Welcome to GeoPPC MortarCalc Dashboard</h1>
<p>Use the navigation bar to input data or view results.</p>
{% endblock %}
EOL

cat <<EOL > $APP_NAME/templates/$APP_NAME/material_data_form.html
{% extends '$APP_NAME/base.html' %}

{% block title %}Input Data{% endblock %}

{% block content %}
<h1>Enter Material Data</h1>
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit" class="btn btn-primary">Submit</button>
</form>
{% endblock %}
EOL

cat <<EOL > $APP_NAME/templates/$APP_NAME/calculation_result.html
{% extends '$APP_NAME/base.html' %}

{% block title %}Calculation Result{% endblock %}

{% block content %}
<h1>Calculation Result</h1>
<p>Compressive Strength: {{ result.compressive_strength }}</p>
<p>Tensile Strength: {{ result.tensile_strength }}</p>
<p>Porosity: {{ result.porosity }}</p>
<p>Density: {{ result.density }}</p>
<p>Absorption: {{ result.absorption }}</p>
{% endblock %}
EOL

# Jalankan migrasi untuk membuat database SQLite3
echo "Running initial migrations..."
python manage.py makemigrations
python manage.py migrate
check_success "Failed to run migrations"

# Buat superuser untuk admin
echo "Creating superuser..."
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')" | python manage.py shell
check_success "Failed to create superuser"

# Selesai
echo "Django project created successfully!"
