import csv
import os
import requests
from bs4 import BeautifulSoup
import time
import re

# Paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.join(BASE_DIR, '..')
CSV_FILE_PATH = os.path.join(PROJECT_ROOT, 'lib', 'data', 'forza_wiki_car_specs.csv')
ASSETS_DIR = os.path.join(PROJECT_ROOT, 'assets', 'images')

def clean_filename(name):
    """Cleans a string to be safe for filenames."""
    return re.sub(r'[\\/*?:"<>|]', "", name).strip()

def download_image(url, save_path):
    """Downloads an image from a URL to a local path."""
    try:
        response = requests.get(url, stream=True)
        if response.status_code == 200:
            with open(save_path, 'wb') as f:
                for chunk in response.iter_content(1024):
                    f.write(chunk)
            return True
    except Exception as e:
        print(f"Error downloading image: {e}")
    return False

def scrape_car_data(url):
    """Scrapes car data and image URL from a Forza Wiki page."""
    try:
        response = requests.get(url)
        if response.status_code != 200:
            print(f"Failed to fetch page: {url}")
            return None

        soup = BeautifulSoup(response.content, 'html.parser')
        data = {}

        # 1. Extract Image
        # Try to find the main infobox image
        img_tag = soup.find('img', class_='pi-image-thumbnail')
        if img_tag and img_tag.get('src'):
            data['image_url'] = img_tag['src']
        else:
             # Fallback: try finding any image in the infobox
            infobox = soup.find('aside', class_='portable-infobox')
            if infobox:
                img_tag = infobox.find('img')
                if img_tag and img_tag.get('src'):
                    data['image_url'] = img_tag['src']

        # 2. Extract Specs (Optional, if we want to enrich CSV later)
        # The user provided HTML structure uses 'pi-item pi-data'
        # We can iterate through them to find keys like 'Engine', 'Power', etc.
        # For now, the main goal is the image.

        return data

    except Exception as e:
        print(f"Error scraping {url}: {e}")
        return None

def main():
    print("Starting scraper...")
    
    # Ensure assets directory exists
    if not os.path.exists(ASSETS_DIR):
        os.makedirs(ASSETS_DIR)

    with open(CSV_FILE_PATH, mode='r', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile, delimiter=';')
        
        # We'll collect all rows to potentially write back updated data
        rows = list(reader)
        total_cars = len(rows)
        
        print(f"Found {total_cars} cars to process.")

        for index, row in enumerate(rows):
            brand = row.get('Merek', 'Unknown').strip()
            # Model name isn't explicitly in a column in the provided CSV snippet (it has Kategori, Merek, Tahun, etc.)
            # But the URL usually contains the model name.
            # Let's try to infer a model name or use a generic one if missing.
            # Wait, looking at previous interactions, the CSV *does* have columns.
            # Let's assume we use the URL to derive a unique filename if 'Model' column is missing.
            
            url = row.get('Source URL', '').strip()
            if not url:
                continue

            # Infer model name from URL if needed
            model_name = url.split('/')[-1].replace('_', ' ')
            # Or if there's a 'Model' column (I don't see it in the snippet provided earlier, only Kategori;Merek;Tahun...)
            # So we will use the URL slug as the model name.
            
            print(f"[{index+1}/{total_cars}] Processing: {brand} - {model_name}")

            # Create Brand Directory
            brand_dir = os.path.join(ASSETS_DIR, clean_filename(brand))
            if not os.path.exists(brand_dir):
                os.makedirs(brand_dir)

            # Check if image already exists
            image_filename = f"{clean_filename(model_name)}.png"
            save_path = os.path.join(brand_dir, image_filename)
            
            if os.path.exists(save_path):
                print(f"  Image already exists: {save_path}")
                continue

            # Scrape
            scraped_data = scrape_car_data(url)
            
            if scraped_data and scraped_data.get('image_url'):
                print(f"  Downloading image from {scraped_data['image_url']}...")
                if download_image(scraped_data['image_url'], save_path):
                    print("  Success!")
                else:
                    print("  Failed to download.")
            else:
                print("  No image found on page.")

            # Be polite to the server
            time.sleep(1)

    print("Scraping complete!")

if __name__ == '__main__':
    main()
