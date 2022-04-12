import pandas as pd

movie_production = [
    [441, 28, 20.41], 
    [3599, 57, 3.75],
    [2843, 77, 11.85],
    [3474, 73, 60.2]
]
df = pd.DataFrame(movie_production)

print(df)