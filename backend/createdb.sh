#!/bin/bash

# Nama file database SQLite
DATABASE_FILE="mortar_database.db"

# Hapus database jika sudah ada (opsional)
# rm -f "$DATABASE_FILE"

# Buat database baru
sqlite3 "$DATABASE_FILE" <<EOF

-- Membuat tabel users
CREATE TABLE IF NOT EXISTS users (
 user_id INTEGER PRIMARY KEY AUTOINCREMENT,
 username TEXT UNIQUE NOT NULL,
 password TEXT NOT NULL,
 role TEXT,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel material_data
CREATE TABLE IF NOT EXISTS material_data (
 data_id INTEGER PRIMARY KEY AUTOINCREMENT,
 user_id INTEGER REFERENCES users(user_id),
 fly_ash DECIMAL(5,2),
 tanah_putih DECIMAL(5,2),
 naoh DECIMAL(5,2),
 air DECIMAL(5,2),
 pasir DECIMAL(5,2),
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel calculation_results
CREATE TABLE IF NOT EXISTS calculation_results (
 result_id INTEGER PRIMARY KEY AUTOINCREMENT,
 data_id INTEGER REFERENCES material_data(data_id),
 compressive_strength DECIMAL(8,2),
 tensile_strength DECIMAL(8,2),
 porosity DECIMAL(5,2),
 density DECIMAL(8,2),
 absorption DECIMAL(5,2),
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Membuat tabel simulation_results (opsional, jika ada fitur simulasi)
CREATE TABLE IF NOT EXISTS simulation_results (
 sim_id INTEGER PRIMARY KEY AUTOINCREMENT,
 data_id INTEGER REFERENCES material_data(data_id),
 sim_type TEXT,
 sim_result TEXT, -- Menggunakan TEXT untuk menyimpan JSON sebagai string
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

EOF

echo "Database dan tabel berhasil dibuat."
