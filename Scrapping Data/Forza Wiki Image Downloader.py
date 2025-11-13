# ==============================================================================
# Forza Fandom Wiki Image Downloader
#
# Deskripsi:
# Program ini membaca file CSV yang dihasilkan oleh scraper spesifikasi,
# lalu mengunjungi setiap URL mobil untuk mengunduh gambar utamanya.
# Gambar-gambar tersebut akan disimpan di dalam folder baru.
#
# Alur kerja:
# 1. Baca file CSV yang berisi URL mobil.
# 2. Buat folder tujuan untuk menyimpan gambar.
# 3. Untuk setiap mobil, kunjungi URL-nya.
# 4. Cari URL gambar dari meta tag 'og:image'.
# 5. Unduh dan simpan gambar dengan nama yang sesuai.
#
# Library yang dibutuhkan: pandas, requests, beautifulsoup4
# Instalasi: pip install pandas requests beautifulsoup4
# ==============================================================================

import pandas as pd
import requests
from bs4 import BeautifulSoup
import os
import re
import time
import random
from urllib.parse import urljoin

# ==============================================================================
# FUNGSI-FUNGSI BANTUAN
# ==============================================================================

def clean_filename(name):
    """
    Membersihkan nama mobil agar menjadi nama file yang valid.
    Contoh: "Ferrari F40 Competizione" -> "Ferrari_F40_Competizione"
    """
    # Menghapus karakter yang tidak diizinkan dalam nama file
    name = re.sub(r'[\\/*?:"<>|]', "", name)
    # Mengganti spasi dengan underscore
    name = name.replace(" ", "_")
    return name

def download_image(image_url, folder_path, file_name):
    """Mengunduh satu gambar dari URL dan menyimpannya ke folder."""
    try:
        # Dapatkan ekstensi file dari URL (misal: .png, .jpg)
        file_extension = os.path.splitext(image_url.split('?')[0])[-1]
        if not file_extension:
            file_extension = ".png" # Default jika tidak ada ekstensi

        full_path = os.path.join(folder_path, file_name + file_extension)

        # Melakukan streaming untuk file besar
        response = requests.get(image_url, stream=True)
        response.raise_for_status()

        with open(full_path, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"      -> ✅ Gambar berhasil disimpan sebagai: {os.path.basename(full_path)}")
        return True

    except requests.exceptions.RequestException as e:
        print(f"      -> ❌ Gagal mengunduh gambar: {e}")
        return False

# ==============================================================================
# EKSEKUSI UTAMA
# ==============================================================================
if __name__ == '__main__':
    print("\n" + "=" * 80)
    print("🖼️  MEMULAI PROSES PENGUNDUHAN GAMBAR MOBIL DARI FORZA WIKI 🖼️")
    print("=" * 80)

    # --- PENGATURAN UTAMA ---
    # Masukkan nama file CSV yang ingin Anda proses
    csv_file_name ="forza_wiki_car_specs.csv"
    # GANTI DENGAN NAMA FILE ANDA
    # Nama folder untuk menyimpan gambar

    output_folder = "gambar_mobil"

    # LANGKAH 1: Cek dan baca file CSV
    if not os.path.exists(csv_file_name):
        print(f"❌ [ERROR] File '{csv_file_name}' tidak ditemukan.")
        print("   Pastikan Anda sudah menjalankan 'forza_wiki_scraper.py' terlebih dahulu,")
        print("   dan nama file di atas sudah benar.")
    else:
        df = pd.read_csv(csv_file_name, sep=";")
        print(f"✅ Berhasil membaca {len(df)} data mobil dari '{csv_file_name}'.")

        # LANGKAH 2: Buat folder output jika belum ada
        if not os.path.exists(output_folder):
            os.makedirs(output_folder)
            print(f"📁 Folder '{output_folder}' berhasil dibuat.")

        total_cars = len(df)
        print(f"\n🕵️  Memulai proses pencarian dan pengunduhan gambar untuk {total_cars} mobil...")

        # LANGKAH 3: Loop melalui setiap mobil di DataFrame
        for index, row in df.iterrows():
            page_url = row['Source URL']
            car_name = row['Merek'] + " " + page_url.split('/')[-1].replace('_', ' ')
            
            print(f"\n   [PROSES {index + 1}/{total_cars}] Mobil: {car_name}")
            print(f"      -> Mengunjungi: {page_url}")

            try:
                # Ambil HTML halaman mobil
                response = requests.get(page_url)
                response.raise_for_status()
                soup = BeautifulSoup(response.text, 'html.parser')

                # Cari meta tag 'og:image'
                image_tag = soup.find('meta', property='og:image')

                if image_tag and image_tag.get('content'):
                    image_url = image_tag['content']
                    print(f"      -> URL gambar ditemukan: {image_url}")
                    
                    # Unduh gambar
                    file_name = clean_filename(car_name)
                    download_image(image_url, output_folder, file_name)

                else:
                    print("      -> ⚠️ Meta tag 'og:image' tidak ditemukan di halaman ini.")
                
                # Jeda sopan antar permintaan
                delay = random.uniform(2, 5)
                time.sleep(delay)

            except requests.exceptions.RequestException as e:
                print(f"      -> ❌ Gagal mengakses halaman: {e}")
                continue
    
    print("\n" + "=" * 80)
    print("🎉 SELURUH PROSES PENGUNDUHAN GAMBAR TELAH SELESAI 🎉")
    print(f"   Silakan periksa hasilnya di dalam folder '{output_folder}'.")



### Cara Menggunakannya

#1.  Jalankan Scraper Data Dulu**: Pastikan Anda sudah menjalankan `forza_wiki_scraper.py` dan mendapatkan file `.csv` yang berisi data spesifikasi.
#2.  **Simpan Kode Baru**: Salin kode di atas dan simpan sebagai file baru, misalnya `image_downloader.py`, di dalam folder yang sama.
#3.  **Ubah Nama File CSV**: Buka `image_downloader.py` dan **ubah nilai variabel `csv_file_name`** (di baris 70) agar cocok dengan nama file CSV yang Anda hasilkan.
#4.  **Jalankan Scraper Gambar**: Eksekusi program baru ini dari terminal Anda:
#    ```bash
#   python image_downloader.py
    
