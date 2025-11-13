# ==============================================================================
# Forza Fandom Wiki Car Scraper (Versi 4 - Visible Tags)
#
# Deskripsi:
# Versi ini adalah yang paling stabil. Ia secara langsung menargetkan
# daftar kategori yang terlihat di bagian bawah halaman (footer) dan
# membaca atribut 'data-name' dari setiap elemen.
#
# Alur kerja:
# 1. Loop melalui kategori mobil (Hypercars, dll.).
# 2. Ambil semua link dari setiap halaman kategori.
# 3. Kunjungi setiap link, cari daftar kategori di footer, dan ekstrak datanya.
# 4. Simpan hasilnya ke file CSV.
#
# Library yang dibutuhkan: pandas, requests, beautifulsoup4
# Instalasi: pip install pandas requests beautifulsoup4
# ==============================================================================

import pandas as pd
import requests
from bs4 import BeautifulSoup
from datetime import datetime
import re
import time
import random
from urllib.parse import urljoin

# ==============================================================================
# KONFIGURASI TERPUSAT
# ==============================================================================
CONFIG = {
    'base_url': "https://forza.fandom.com",
    'category_url_template': "https://forza.fandom.com/wiki/Category:{}",
    'headers': {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36'
    },
    'selectors': {
        'category_page_links': 'a.category-page__member-link',
        # Selector untuk menargetkan daftar kategori di footer halaman detail
        'detail_page_categories': 'ul.categories li.category.normal',
    }
}

# ==============================================================================
# FUNGSI-FUNGSI BANTUAN
# ==============================================================================

def find_spec_in_list(data_list, keyword):
    """Mencari string dalam list yang mengandung keyword tertentu."""
    for item in data_list:
        if keyword in item.lower():
            return item
    return "N/A"

def find_year_in_list(data_list):
    """Mencari kategori tahun (contoh: '2020s') secara spesifik."""
    for item in data_list:
        if re.match(r'^\d{4}s$', item):
            return item
    return "N/A"

def find_brand_from_title(soup):
    """Mengekstrak merek dari tag <title> halaman."""
    if soup.title and soup.title.string:
        # Contoh: "Koenigsegg Jesko | Forza Wiki | Fandom" -> ambil "Koenigsegg"
        return soup.title.string.split(' ')[0]
    return "N/A"

# ==============================================================================
# FUNGSI-FUNGSI UTAMA SCRAPING
# ==============================================================================

def get_car_links_from_category(category_url):
    """Mengambil semua URL mobil dari satu halaman kategori."""
    print(f"🔗 Mengambil daftar tautan dari kategori: {category_url}")
    try:
        response = requests.get(category_url, headers=CONFIG['headers'])
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        car_links = set()
        link_tags = soup.select(CONFIG['selectors']['category_page_links'])
        
        if not link_tags:
            print("   ⚠️  Tidak ada tautan mobil yang ditemukan di kategori ini.")
            return []

        for link_tag in link_tags:
            href = link_tag.get('href')
            if href and href.startswith('/wiki/'):
                full_url = urljoin(CONFIG['base_url'], href)
                car_links.add(full_url)
        
        print(f"   ✅ Ditemukan {len(car_links)} tautan mobil unik di kategori ini.")
        return list(car_links)

    except requests.exceptions.RequestException as e:
        print(f"   ❌ [GAGAL] Terjadi kesalahan saat mengakses URL kategori: {e}")
        return []

def scrape_car_details(url, category):
    """
    Mengambil data dengan mem-parsing langsung dari daftar kategori
    yang terlihat di bagian bawah halaman.
    """
    try:
        response = requests.get(url, headers=CONFIG['headers'])
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # Temukan semua tag li kategori di footer
        category_tags = soup.select(CONFIG['selectors']['detail_page_categories'])
        
        if not category_tags:
            print("      -> ⚠️ Daftar tag kategori di footer tidak ditemukan.")
            return None

        # Ekstrak nilai dari atribut 'data-name'
        categories_list = [tag['data-name'] for tag in category_tags if tag.has_attr('data-name')]
        
        if not categories_list:
            print("      -> ⚠️ Atribut 'data-name' tidak ditemukan di tag kategori.")
            return None

        # --- Ekstraksi Data dari Daftar Kategori yang Ditemukan ---
        merek = find_brand_from_title(soup)
        tahun = find_year_in_list(categories_list)

        displacement = find_spec_in_list(categories_list, "displacement")
        engine_type = find_spec_in_list(categories_list, "turbocharged")
        cylinders = find_spec_in_list(categories_list, "v8") or find_spec_in_list(categories_list, "v6")
        mesin_parts = [part for part in [displacement, engine_type, cylinders] if part != "N/A"]
        mesin = ', '.join(mesin_parts) if mesin_parts else "N/A"

        tenaga = find_spec_in_list(categories_list, "bhp")
        torsi = find_spec_in_list(categories_list, "lb⋅ft")
        berat = find_spec_in_list(categories_list, "lbs")

        car_data = {
            "Kategori": category,
            "Merek": merek,
            "Tahun": tahun,
            "Mesin": mesin,
            "Tenaga (BHP)": tenaga,
            "Torsi (lb⋅ft)": torsi,
            "Berat (lbs)": berat,
            "Source URL": url
        }
        return car_data

    except requests.exceptions.RequestException as e:
        print(f"      -> ❌ Terjadi error saat request: {e}")
        return None
    except Exception as e:
        print(f"      -> ❌ Terjadi error tak terduga: {e}")
        return None

# ==============================================================================
# EKSEKUSI UTAMA
# ==============================================================================
if __name__ == '__main__':
    print("\n" + "=" * 80)
    print("🚀 MEMULAI PROSES SCRAPING SPESIFIKASI MOBIL DARI FORZA WIKI (V4 - Visible Tags) 🚀")
    print("=" * 80)
    
    categories_to_scrape = [
        #"Hypercars_(FH5)",
        #"Modern_Sports_Cars_(FH5)",
        #"Modern_Supercars_(FH5)",
        #"Classic _Muscle_(FH5)","Classic_Racers_(FH5)","Classic_Sports_Cars_(FH5)","Extreme_Track_Toys_(FH5)","GT_Cars_(FH5)","Modern_Muscle_(FH5)","Modern_Rally_(FH5)","Retro_Sports_Cars_(FH5)"
        "Trucks_(FH5)",
        "Unlimited_Buggies_(FH5)",
        "Unlimited_Offroad_(FH5)",
        "UTV's_(FH5)",
        "Vans_%26_Utility_(FH5)",
        "Vintage_Racers_(FH5)",
        
    ]

    links_to_process = []
    
    for category_slug in categories_to_scrape:
        category_url = CONFIG['category_url_template'].format(category_slug)
        clean_category_name = category_slug.replace('_(FH5)', '').replace('_', ' ')
        
        links_from_cat = get_car_links_from_category(category_url)
        for link in links_from_cat:
            links_to_process.append({'url': link, 'category': clean_category_name})
        print("-" * 40)

    if not links_to_process:
        print("\n🏁 PROSES DIHENTIKAN. Tidak ada tautan mobil yang bisa diproses.")
    else:
        all_cars_data = []
        unique_urls = {task['url'] for task in links_to_process}
        total_links = len(unique_urls)
        
        print(f"\n✅ Total {len(links_to_process)} tautan ditemukan dari {len(categories_to_scrape)} kategori.")
        print(f"   (Total {total_links} mobil unik akan diproses)")
        
        print(f"\n🕵️  Memulai pengambilan detail...")
        processed_urls = set()
        
        for i, task in enumerate(links_to_process):
            url = task['url']
            if url in processed_urls:
                continue
            
            print(f"   [PROSES {len(processed_urls) + 1}/{total_links}] URL: {url}")
            details = scrape_car_details(task['url'], task['category'])

            if details:
                all_cars_data.append(details)
            else:
                print(f"      -> ⚠️ Data tidak dapat diekstrak, melewati.")
            
            processed_urls.add(url)
            
            # --- JEDA UNTUK PENCEGAHAN BLOKIR ---
            # Jeda acak antara 20 hingga 30 detik untuk meniru perilaku manusia
            # dan mengurangi beban pada server Fandom.
            delay = random.uniform(10, 20)
            print(f"      -> ⏳ Jeda acak selama {delay:.2f} detik...")
            time.sleep(delay)

        if not all_cars_data:
            print("\n" + "-" * 80)
            print("🏁 PROSES SELESAI. Tidak ada data valid yang berhasil diambil.")
        else:
            print("\n" + "-" * 80)
            print("📦 Menyimpan data yang terkumpul ke dalam file CSV...")
            df = pd.DataFrame(all_cars_data)

            kolom_urut = ["Kategori", "Merek", "Tahun", "Mesin", "Tenaga (BHP)", "Torsi (lb⋅ft)", "Berat (lbs)", "Source URL"]
            df = df.reindex(columns=kolom_urut)

            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            nama_file_output = f"forza_wiki_car_specs_{timestamp}.csv"
            df.to_csv(nama_file_output, index=False, encoding="utf-8-sig", sep=";")

            print(f"   ✅ Data berhasil disimpan ke: '{nama_file_output}'")
            print(f"   - Total Mobil Disimpan: {len(df)}")
        print("-" * 80)

    print("\n🎉 SELURUH PROSES SCRAPING TELAH SELESAI 🎉")


