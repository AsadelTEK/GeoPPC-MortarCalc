from flask import Flask, render_template, request, jsonify
import sqlite3

app = Flask(__name__)

# Konfigurasi database
DATABASE = 'mortar_database.db'

# Fungsi untuk koneksi ke database
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

# Rute utama: Menampilkan halaman utama
@app.route('/')
def index():
    return render_template('index.html')

# Rute untuk menghitung dan menyimpan data
@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.get_json()

    # Validasi data (contoh sederhana)
    required_fields = ['fly_ash', 'tanah_putih', 'naoh', 'air', 'pasir']
    if not all(field in data for field in required_fields):
        return jsonify({'error': 'Data tidak lengkap'}), 400

    # Lakukan perhitungan (sesuai rumus yang ditentukan)
    # ...

    # Simpan data ke database
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Simpan data material
        cursor.execute('INSERT INTO material_data (fly_ash, tanah_putih, naoh, air, pasir) VALUES (?, ?, ?, ?, ?)',
                       (data['fly_ash'], data['tanah_putih'], data['naoh'], data['air'], data['pasir']))
        data_id = cursor.lastrowid

        # Simpan hasil perhitungan
        cursor.execute('INSERT INTO calculation_results (data_id, compressive_strength, tensile_strength, porosity, density, absorption) VALUES (?, ?, ?, ?, ?, ?)',
                       (data_id, compressive_strength, tensile_strength, porosity, density, absorption))

        conn.commit()
        return jsonify({'message': 'Data berhasil disimpan'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    finally:
        conn.close()

# Rute untuk mengambil data hasil perhitungan
@app.route('/results')
def get_results():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM calculation_results')
    results = cursor.fetchall()
    conn.close()

    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)
