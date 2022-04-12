import numpy as np

sam_scores = [88, 100, 72, 91, 89]
print("median: ", np.median(sam_scores))
print("mean: ", np.mean(sam_scores))
print("std: ", np.std(sam_scores))
print("var: ", np.var(sam_scores))

print('after last exam')
sam_scores.append(70)
print("median: ", np.median(sam_scores))
print("mean: ", np.mean(sam_scores))
print("std: ", np.std(sam_scores))
print("var: ", np.var(sam_scores))


def namestr(obj, namespace):
    return [name for name in namespace if namespace[name] is obj]

store_1 = [1, 1.5, 2, 1, 0.5]
store_2 = [2, 2.5, 4, 4, 1]
store_3 = [10, 3, 2, 4, 2]

stores = [store_1, store_2, store_3]

for store in stores:
    print(namestr(store, globals()))
    print("median: ", np.median(store))
    print("mean: ", np.mean(store))
    print("std: ", np.std(store))
    print("var: ", np.var(store))