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

echo "running server..."
python manage.py runserver
check_success "Failed to run"