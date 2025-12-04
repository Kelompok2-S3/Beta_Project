from flask import Flask, jsonify, request
from flask_cors import CORS
import csv
import os

app = Flask(__name__)
CORS(app) # Enable CORS for all routes

# Path to the CSV file - Adjusted for HF Space structure
CSV_FILE_PATH = os.path.join(os.path.dirname(__file__), 'data', 'forza_wiki_car_specs.csv')

@app.route('/')
def home():
    return "GearGauge API is running!"

@app.route('/api/cars', methods=['GET'])
def get_cars():
    cars = []
    try:
        page = int(request.args.get('page', 1))
        limit = int(request.args.get('limit', 20))
        brand_filter = request.args.get('brand', None)
        
        if not os.path.exists(CSV_FILE_PATH):
             return jsonify({"error": f"CSV file not found at {CSV_FILE_PATH}"}), 404

        with open(CSV_FILE_PATH, mode='r', encoding='utf-8-sig') as csvfile:
            reader = csv.DictReader(csvfile, delimiter=';')
            all_rows = list(reader)
            
            # Filter by brand if provided
            if brand_filter:
                all_rows = [row for row in all_rows if row.get('Merek', '').strip().lower() == brand_filter.strip().lower()]

            # Pagination logic
            start_index = (page - 1) * limit
            end_index = start_index + limit
            paginated_rows = all_rows[start_index:end_index]
            
            for row in paginated_rows:
                clean_row = {}
                for k, v in row.items():
                    if k:
                        clean_key = k.strip().rstrip(',')
                        clean_val = v.strip().rstrip(',') if v else ''
                        clean_row[clean_key] = clean_val
                cars.append(clean_row)
                
        return jsonify({
            "data": cars,
            "total": len(all_rows),
            "page": page,
            "limit": limit
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/brands', methods=['GET'])
def get_brands():
    brands = set()
    try:
        if not os.path.exists(CSV_FILE_PATH):
             return jsonify({"error": f"CSV file not found at {CSV_FILE_PATH}"}), 404

        with open(CSV_FILE_PATH, mode='r', encoding='utf-8-sig') as csvfile:
            reader = csv.DictReader(csvfile, delimiter=';')
            for row in reader:
                if 'Merek' in row:
                    brand = row['Merek'].strip().rstrip(',')
                    if brand:
                        brands.add(brand)
        
        sorted_brands = sorted(list(brands))
        return jsonify(sorted_brands)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7860) # Port 7860 is standard for HF Spaces
