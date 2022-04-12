# DO NOT CHANGE THE FUNCTION SIGNATURE IN THE SOLUTION AREA
import numpy as np

gandalf = [
  'Fireball',
  'Lightning bolt',
  'Lightning bolt',
  'Magic arrow', 
  'Fireball', 
  'Magic arrow', 
  'Lightning bolt',
  'Fireball',
  'Fireball',
  'Fireball'
]

saruman = [
  'Contagion', 
  'Contagion', 
  'Black Tentacles', 
  'Fireball',
  'Black Tentacles',
  'Lightning bolt', 
  'Magic arrow',
  'Contagion', 
  'Magic arrow',
  'Magic arrow'
]

power = {
    'Fireball': 50, 
    'Lightning bolt': 40, 
    'Magic arrow': 10, 
    'Black Tentacles': 25, 
    'Contagion': 45
}



# Which sorcerer won the battle - Gandalf or Saruman?
def battle():
    gandalf_total_wins = 0
    saruman_total_wins = 0

    gandalf_consecutive_wins = 0
    saruman_consecutive_wins = 0

    total_draws = 0

    current_clash = 0
    TOTAL_CLASHES = max(len(gandalf),len(saruman))


    while gandalf_consecutive_wins < 3 and saruman_consecutive_wins < 3 and current_clash < TOTAL_CLASHES:
        if power[gandalf[current_clash]] > power[saruman[current_clash]]:
            gandalf_consecutive_wins += 1
            gandalf_total_wins += 1
            saruman_consecutive_wins = 0
        elif power[gandalf[current_clash]] < power[saruman[current_clash]]:
            saruman_consecutive_wins += 1
            saruman_total_wins += 1
            gandalf_consecutive_wins = 0
        else:
            gandalf_consecutive_wins = 0
            saruman_consecutive_wins = 0
            total_draws += 1
        current_clash += 1
        print(gandalf_total_wins, gandalf_consecutive_wins, saruman_total_wins, saruman_consecutive_wins)

    print(print(gandalf_total_wins, gandalf_consecutive_wins, saruman_total_wins, saruman_consecutive_wins))

    if gandalf_consecutive_wins == 3:
        return "gandalf"
    elif saruman_consecutive_wins == 3:
        return "saruman"
    elif current_clash == TOTAL_CLASHES:
        if gandalf_total_wins > saruman_total_wins:
            return 'gandalf'
        return 'saruman'
    else:
        return "draw"
  
#  Average of the spells in the lists? Round off your result to one decimal place.
def avg_spells():
    return round(np.mean(list(power.values()),0),1)
  
#  Standard deviation of the spells in the lists? Round off your result to one decimal place.
def stdev_spells():
    # YOUR SOLUTION HERE
    return round(np.std(list(power.values())),1)


print(stdev_spells())