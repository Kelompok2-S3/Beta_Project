import os
import requests
import re
from duckduckgo_search import DDGS
from urllib.parse import unquote

# Configuration
API_URL = "http://127.0.0.1:5000/api/cars?limit=1000"
ASSETS_DIR = "assets/images"

def get_clean_filename(filename):
    return re.sub(r'[\\/*?:"<>|]', "", filename)

def fetch_all_cars():
    print(f"Fetching car data from {API_URL}...")
    try:
        response = requests.get(API_URL)
        response.raise_for_status()
        data = response.json()
        return data.get('cars', [])
    except Exception as e:
        print(f"Error fetching cars: {e}")
        return []

def download_image(query, save_path):
    print(f"Searching for: {query}")
    try:
        with DDGS() as ddgs:
            results = list(ddgs.images(query, max_results=1))
            if results:
                image_url = results[0]['image']
                print(f"Found image: {image_url}")
                
                img_data = requests.get(image_url, timeout=10).content
                with open(save_path, 'wb') as handler:
                    handler.write(img_data)
                print(f"Saved to: {save_path}")
                return True
            else:
                print("No images found.")
                return False
    except Exception as e:
        print(f"Error downloading image: {e}")
        return False

def main():
    cars = fetch_all_cars()
    print(f"Found {len(cars)} cars in database.")
    
    missing_count = 0
    downloaded_count = 0
    
    for car in cars:
        brand = car.get('brand', 'Unknown')
        source_url = car.get('source_url', '')
        
        # Logic to match CarRepository
        clean_brand = get_clean_filename(brand.strip())
        
        # Extract model part from URL
        url_model_part = source_url.split('/')[-1]
        url_model_part = unquote(url_model_part)
        
        # Construct filename
        # Pattern: Brand_URLModelPart.png
        filename = f"{clean_brand}_{url_model_part}.png"
        filename = get_clean_filename(filename)
        
        # Construct full path
        brand_dir = os.path.join(ASSETS_DIR, clean_brand)
        file_path = os.path.join(brand_dir, filename)
        
        # Check if file exists
        if not os.path.exists(file_path):
            missing_count += 1
            print(f"\n[MISSING] {file_path}")
            
            # Create directory if it doesn't exist
            if not os.path.exists(brand_dir):
                os.makedirs(brand_dir)
                print(f"Created directory: {brand_dir}")
            
            # Download
            search_query = f"{brand} {url_model_part.replace('_', ' ')} car"
            if download_image(search_query, file_path):
                downloaded_count += 1
            else:
                print("Failed to download.")
        else:
            # print(f"[OK] {filename}")
            pass
            
    print(f"\nSummary:")
    print(f"Total Cars: {len(cars)}")
    print(f"Missing Images: {missing_count}")
    print(f"Downloaded: {downloaded_count}")

if __name__ == "__main__":
    main()
