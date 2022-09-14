import spotipy
import pandas as pd
from spotipy.oauth2 import SpotifyClientCredentials

sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id="af3a4e21d9974f798b0ddef081728f2b",
                                                           client_secret="99a65d20eff04d64bcf24b11824dffc4"))

# search_prompt = input("What type of music are you looking for: ")
# search = sp.search(q="" ,type="playlist",  ) 

playlist_tracks_query = sp.user_playlist_tracks("spotify", "4QiZqcT5VPcqsNXeRqlidh")
playlist_tracks = playlist_tracks_query["items"]
df = pd.DataFrame(pd.json_normalize(playlist_tracks))

# getting artists_ids of a playlist
playlist_artists_ids = []
for artists in df["track.artists"]:
    for artist in artists:
        playlist_artists_ids.append(artist["id"])

## getting all artist's albums given an artist_id
# albums = []
# playlists_given_artists_ids = []
# for artist_id in set(playlist_artists_ids):
#     artist_albums_query = sp.artist_albums(artist_id)
#     for query_spec in artist_albums_query:
#         if query_spec == "items":
#             artist_albums = artist_albums_query[query_spec]
#             for album in artist_albums:
#                 albums.append(album)

# albums = pd.DataFrame(pd.json_normalize(albums))


# getting similar artists given an artist_id
from pprint import pprint
related_artists_ids_lst = playlist_artists_ids
for artist_id in playlist_artists_ids:
    similar_artists_query = sp.artist_related_artists(artist_id)
    artists_info_list = similar_artists_query["artists"]
    for artist in artists_info_list:
        pprint(artist["id"])
        related_artists_ids_lst.append(artist["id"])

print(pd.DataFrame(playlist_artists_ids))
