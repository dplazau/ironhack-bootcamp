import requests

url = "https://aerodatabox.p.rapidapi.com/health/services/feeds/FlightSchedules/airports"

headers = {
    'x-rapidapi-host': "aerodatabox.p.rapidapi.com",
    'x-rapidapi-key': "9613ca6ca5msh62659872159916fp1a0a2cjsndd9a3e6ff324"
    }

response = requests.get(url, headers=headers, params="")
print(response.json()["items"]) 