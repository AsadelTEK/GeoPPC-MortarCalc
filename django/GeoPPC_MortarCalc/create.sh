#!/bin/bash

# Membuat virtual environment
python -m venv venv

# Mengaktifkan virtual environment
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    source venv/bin/activate
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    venv\Scripts\activate
else
    echo "OS tidak dikenali. Harap aktifkan virtual environment secara manual."
    exit 1
fi

# Menginstal dependensi dari requirements.txt jika ada, atau instal Django secara manual
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
else
    pip install django
fi

# Menyiapkan database dan melakukan migrasi
python manage.py makemigrations
python manage.py migrate

# Menjalankan server Django
python manage.py runserver 0.0.0.0:8000
