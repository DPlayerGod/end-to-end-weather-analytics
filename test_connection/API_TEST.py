import requests
from datetime import datetime

# 1. Configuration
# Replace with your actual API Key from KV Store for local testing
API_KEY = "ef7ae48bee7aac32425d4100b4a1bfc9" 
CITY = "Hanoi"
URL = f"http://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric"

def test_weather_api():
    print(f"--- Testing OpenWeather API for: {CITY} ---")
    
    # System time (Ingest Time)
    system_now = datetime.utcnow()
    print(f"System Ingest Time (UTC): {system_now.strftime('%Y-%m-%d %H:%M:%S')}")

    try:
        response = requests.get(URL)
        if response.status_code == 200:
            data = response.json()
            
            # 2. Extract Event Time from API (dt field)
            api_dt_unix = data.get("dt")
            event_dt_obj = datetime.utcfromtimestamp(api_dt_unix)
            
            # 3. Display Extracted Metrics
            print("\n[SUCCESS] Data retrieved:")
            print(f"- City:      {data.get('name')}")
            print(f"- Country:   {data.get('sys', {}).get('country')}")
            print(f"- Lat/Lon:   {data.get('coord').get('lat')} / {data.get('coord').get('lon')}")
            print(f"- Temp:      {data.get('main').get('temp')}°C")
            print(f"- Humidity:  {data.get('main').get('humidity')}%")
            print(f"- Wind:      {data.get('wind').get('speed')} m/s")
            print(f" rain (1h): {data.get('rain', {}).get('1h', 0.0)} mm")
            print(f" rain (3h): {data.get('rain', {}).get('3h', 0.0)} mm")
            print(f"- Event Time (from API 'dt'): {event_dt_obj.strftime('%Y-%m-%d %H:%M:%S')}")
        
            
            # Folder logic check
            print(f"\n[GCS PATH CHECK] Target Folder: raw/year={event_dt_obj.strftime('%Y')}/month={event_dt_obj.strftime('%m')}/day={event_dt_obj.strftime('%d')}/")
            
        else:
            print(f"[ERROR] API returned status code: {response.status_code}")
            print(f"Message: {response.text}")

    except Exception as e:
        print(f"[ERROR] Could not connect to API: {e}")

if __name__ == "__main__":
    test_weather_api()