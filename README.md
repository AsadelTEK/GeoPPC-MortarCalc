# GeoPPC-MortarCalc
## Sistem Aplikasi Komputer untuk Perhitungan dan Analisis Sifat Mekanik Mortar PPC dan Geopolimer dengan Aktivator NaOH Berbasis Web dan Python

## Bidang
Sistem aplikasi komputer yang digunakan untuk menghitung dan menganalisis sifat mekanis dari berbagai jenis mortar, lebih khusus lagi invensi ini berhubungan dengan perhitungan sifat mekanis mortar PPC dan mortar geopolimer dengan aktivator NaOH pada kondisi rendaman air laut.

## Latar Belakang
Pembangunan infrastruktur di wilayah pesisir dan laut memerlukan material konstruksi yang tahan terhadap pengaruh air laut yang mengandung garam dan sulfat. Portland pozzolan cement (PPC) digunakan karena memiliki ketahanan tinggi, tetapi tetap menghasilkan emisi karbon dioksida yang berdampak negatif terhadap lingkungan. Alternatif yang lebih ramah lingkungan adalah material geopolimer. Namun, proses perhitungan sifat mekanis mortar PPC dan geopolimer memerlukan aplikasi yang dapat mempermudah dan mempercepat analisis data.
Invensi teknologi yang berkaitan dengan perhitungan sifat mekanis mortar dimana diungkapkan perhitungan sifat mekanis mortar menggunakan metode tradisional yang memerlukan waktu dan proses yang panjang. Namun, invensi tersebut masih terdapat kekurangan dalam hal efisiensi dan kepraktisan.

## Uraian Singkat
Tujuan utama dari aplikasi ini adalah untuk mengatasi permasalahan yang telah ada sebelumnya khususnya dalam perhitungan dan analisis sifat mekanis mortar PPC dan geopolimer dengan mengembangkan suatu sistem aplikasi komputer berbasis web dan Python. Sistem aplikasi ini terdiri dari modul input data material, modul perhitungan sifat mekanis, dan modul pengujian mekanis. Sistem ini dicirikan dengan kemampuan untuk menghitung kekuatan tekan, kekuatan tarik, porositas, densitas, dan absorpsi dari berbagai jenis mortar.
Tujuan lain dari aplikasi ini adalah untuk menyediakan antarmuka pengguna yang intuitif dan mudah digunakan, serta menyediakan hasil perhitungan dan analisis dalam bentuk grafik dan tabel yang informatif.

# Tutorial Penggunaan GeoPPC-MortarCalc
Sistem Perhitungan dan Analisis Sifat Mekanik Mortar

## Deskripsi
GeoPPC-MortarCalc adalah aplikasi web yang dirancang untuk menghitung dan menganalisis sifat mekanik mortar berdasarkan data material yang dimasukkan pengguna.

## Persyaratan
- Python 3.x
- Django

## Instalasi dan Menjalankan Aplikasi (cara 1)
## Penggunaan Script `create.sh` untuk Menjalankan Django di Codespace GitHub

### Persiapan Awal

1. **Buat Codespace di GitHub:**
   - Masuk ke repository GitHub Anda.
   - Klik tombol `Code` di kanan atas, lalu pilih `Codespaces`.
   - Klik `Create codespace on main` (atau cabang lain yang relevan).

2. **Pastikan Skrip `create.sh` Tersedia:**
   - Skrip `create.sh` sudah tersedia di root directory project Anda.

### Menjalankan Skrip `create.sh`

1. **Buat Skrip `create.sh` Dapat Dieksekusi:**
   - Buka terminal di Codespace Anda dan jalankan perintah berikut untuk membuat skrip `create.sh` dapat dieksekusi:

     ```sh
     chmod +x create.sh
     ```

2. **Jalankan Skrip:**
   - Di terminal, jalankan skrip dengan perintah berikut:

     ```sh
     ./create.sh
     ```

3. **Akses Server Django:**
   - Setelah skrip selesai dijalankan, server Django akan berjalan pada alamat `0.0.0.0` di port `8000`.
   - Buka browser Anda dan akses server Django melalui URL yang disediakan oleh Codespace (misalnya, `https://<codespace-id>.github.dev`).

Dengan mengikuti langkah-langkah di atas, Anda dapat dengan mudah mengatur environment dan menjalankan server Django di GitHub Codespace menggunakan skrip `create.sh`.



## Instalasi dan Menjalankan Aplikasi (cara 2)
### 1. Membuat Codespace di GitHub
1. Masuk ke repository GitHub Anda.
2. Klik tombol `Code` di kanan atas, lalu pilih `Codespaces`.
3. Klik `Create codespace on main` (atau cabang lain yang relevan).

### 2. Mengatur Virtual Environment
1. Setelah Codespace terbuka, buka terminal baru.
2. Buat virtual environment dengan menjalankan perintah berikut:
    ```sh
    python -m venv venv
    ```

3. Aktifkan virtual environment:
    - Di Windows:
      ```sh
      venv\Scripts\activate
      ```
    - Di macOS/Linux:
      ```sh
      source venv/bin/activate
      ```

4. Instal semua dependensi yang diperlukan dari `requirements.txt` (jika ada). Jika tidak ada, Anda perlu menginstal Django secara manual:
    ```sh
    pip install django
    ```

### 3. Menyiapkan Database dan Migrasi
1. Buat migrasi untuk model Django Anda:
    ```sh
    python manage.py makemigrations
    ```

2. Terapkan migrasi tersebut ke database:
    ```sh
    python manage.py migrate
    ```

### 4. Menjalankan Server Django
1. Jalankan server Django dengan perintah berikut:
    ```sh
    python manage.py runserver
    ```

2. Buka browser dan akses aplikasi Anda di `http://127.0.0.1:8000/`.

### 5. Langkah Tambahan (Opsional)
- Buat superuser untuk mengakses admin panel:
  ```sh
  python manage.py createsuperuser

