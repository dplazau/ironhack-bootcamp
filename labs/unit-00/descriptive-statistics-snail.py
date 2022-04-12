import numpy as np

# DO NOT CHANGE THE FUNCTION SIGNATURE IN THE SOLUTION AREA
daily_climb = [30, 21, 33, 77, 44, 45, 23, 45, 12, 34, 55]
nightly_fall = -20
# How long does it take to get out of the well?
def escape():
    # Assign problem data to variables with representative names
    # well height, daily advance, night retreat, accumulated distance
    well_height = 125
    
    total_distance = 0
    snail_current_position = 0
    
    # Assign 0 to the variable that represents the solution
    total_days = 0
  
    while snail_current_position < well_height:
        snail_current_position += daily_climb[total_days]
        total_days += 1
        if snail_current_position < well_height:
            snail_current_position += nightly_fall
    # YOUR SOLUTION HERE
    return total_days


def list_displacement():
    displacement = []
    days = escape()
    counter= 0
    for climb in daily_climb[0:days]:
        if counter < (days - 1):
            displacement.append(climb + nightly_fall)
        else:
            displacement.append(climb)
        counter += 1

    print(displacement, len(displacement), " = ", days)
    return displacement

# What is its maximum displacement in one day? 
def max_displacement():
    max_displ = 0
    displacement_list = list_displacement()
    max_displ = max(displacement_list)
    # YOUR SOLUTION HERE
    return max_displ

# And its minimum displacement in one day?
def min_displacement():
    min_displ = 0
    displacement_list = list_displacement()
    min_displ = min(displacement_list)
    # YOUR SOLUTION HERE
    return min_displ
 

# What is its average speed during the day? Round off your solution to one decimal place. 

def avg_speed():
    avg_sp = 0 # YOUR SOLUTION HERE
    days = escape()
    displacement = list_displacement()
    avg_sp = sum(displacement) / len(displacement)
   # YOUR SOLUTION HERE
    return round(avg_sp, 1)

# What is the standard deviation of its displacement during the day? Round off your solution to two decimal places. 

def standard_deviation():
    std_dev = 0
    displacement = list_displacement()
    std_dev = np.std(displacement)
    return round(std_dev, 1)  

print(escape())
print(max_displacement())
print(min_displacement())
print(avg_speed())
print(standard_deviation())