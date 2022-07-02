from pydoc import doc
from .docs import *

def split_text_on_uppercase(s, keep_contiguous=False):
    string_length = len(s)
    is_lower_around = (lambda: s[i-1].islower() or 
                       string_length > (i + 1) and s[i + 1].islower())
    start = 0
    parts = []
    for i in range(1, string_length):
        if s[i].isupper() and (not keep_contiguous or is_lower_around()):
            parts.append(s[start: i])
            start = i
    parts.append(s[start:])
    return "_".join(parts).lower()


def standardize_columns_names(cols):
    lst_std_columns=[]
    for c in cols:
        lst_std_columns.append(
            split_text_on_uppercase(c, True).replace(" ", "").replace("numberof", "qty"))
    return lst_std_columns


def categorize_numeric(set):
    discrete_subset = []
    continuous_subset = []
    for col in set.columns:
        unique_values_per_column = set[col].nunique()
        discrete_subset.append(col) if unique_values_per_column < 250 else continuous_subset.append(col)
    return set[discrete_subset], set[continuous_subset]


for func in [categorize_numeric]:
    func.__doc__ = eval(f"DOCS_{func.__name__}")