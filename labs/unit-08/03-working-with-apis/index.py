import requests
import pandas as pd

headers = {
    'x-rapidapi-host': "aerodatabox.p.rapidapi.com",
    'x-rapidapi-key': "9613ca6ca5msh62659872159916fp1a0a2cjsndd9a3e6ff324"
    }


def get_codes(departure):
    x = "destination"
    if departure:
        x = "departure"
    location = input(f'Insert {x} location:')
    
    url = "https://aerodatabox.p.rapidapi.com/airports/search/term"
    querystring = {"q":location.lower(), "limit":"10"}

    response = requests.get(url, headers=headers, params=querystring)
    codes = response.json()['items'] if 'items' in response.json() else location

    return codes


def choose_code(departure=True):    
    codes = get_codes(departure)
    
    while type(codes) is str or len(codes) != 1:
        
        if not codes:
            print('Try another location. Unable to find code for:', codes, '\n')
        else:
            print('More than one location found. Insert one of the following airports:', [code['icao'] for code in codes], '\n')
        
        codes = get_codes(departure)
    
    return codes[0]['icao']


def flight_distance_time(from_, to_):
    url = f"https://aerodatabox.p.rapidapi.com/airports/icao/{from_}/distance-time/{to_}"
    response = requests.get(url, headers=headers)
    return pd.json_normalize(response.json()).T


def flight():
    return choose_code(departure=True), choose_code(departure=False)

def main():
    from_, to_ = flight()
    print(flight_distance_time(from_, to_))


if __name__ == "__main__":
    main()