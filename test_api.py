import requests
import json

def test_endpoint(url):
    print(f"Testing {url}...")
    try:
        response = requests.get(url)
        print(f"Status Code: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            if isinstance(data, list):
                print(f"Received list with {len(data)} items")
                if len(data) > 0:
                    print(f"Sample: {data[0]}")
            elif isinstance(data, dict):
                print(f"Received dict keys: {data.keys()}")
                if 'data' in data:
                    print(f"Data count: {len(data['data'])}")
                    if len(data['data']) > 0:
                        print(f"Sample: {data['data'][0]}")
        else:
            print("Error response")
    except Exception as e:
        print(f"Exception: {e}")
    print("-" * 20)

if __name__ == "__main__":
    test_endpoint('http://127.0.0.1:5000/api/brands')
    # test_endpoint('http://127.0.0.1:5000/api/cars?page=1&limit=5')
