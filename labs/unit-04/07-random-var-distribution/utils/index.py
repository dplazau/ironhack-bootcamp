from pydoc import doc
from typing import final
from xml.etree.ElementInclude import include
# from .docs import *
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder

def log_transform(x):
    return np.log(x + 1)

def apply_log_transform(sets):
    lst_log_transformed_sets = []
    for set in sets:
        set[set.select_dtypes(np.number).columns] = set[set.select_dtypes(np.number).columns].apply(log_transform)
        lst_log_transformed_sets.append(set)
    return lst_log_transformed_sets

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

def categorize_dataframe(set):
    disc_subset, cont_subset = categorize_numeric(set.select_dtypes(np.number))
    return disc_subset, cont_subset, set.select_dtypes(include=['object', 'datetime'])

def split_data(df, target):
    df = df.dropna()
    try:
        X = df.drop([target], axis=1)
        y = df[target]
        return train_test_split(X, y)
    except:
        raise
    

def scale_data(sets, scaler):
    lst_scaled_sets = []
    try:
        for set in sets:
            set_scaled = scaler().fit_transform(set.select_dtypes(np.number))
            set[set.select_dtypes(np.number).columns] = set_scaled
            lst_scaled_sets.append(set)
        return lst_scaled_sets
    except ValueError as err:
        print(err.message)


def encode_data(scaled_sets, encoder):
    lst_scaled_and_encoded_sets = []
    try:
        for scaled_set in scaled_sets:
            cols_to_encode=scaled_set.select_dtypes(object).columns.values
            enc = encoder(drop='first').fit(scaled_set[cols_to_encode])
            oh_encoded_scaled_set = pd.DataFrame(enc.transform(scaled_set[cols_to_encode]).toarray())
            oh_encoded_scaled_set= oh_encoded_scaled_set.set_index(scaled_set.index)
            scaled_and_encoded_set = scaled_set.drop(scaled_set[cols_to_encode], axis=1).join(oh_encoded_scaled_set)
            lst_scaled_and_encoded_sets.append(scaled_and_encoded_set)
        return lst_scaled_and_encoded_sets
    except ValueError as err:
        print(err.message)
    except TypeError as err:
        print(err.message)
    except:
        raise
        

def fit_model(X_train_scaled_and_encoded, y_train, model_list):
    lst_fitted_models = []
    try:
        for model in model_list:
            lst_fitted_models.append(model().fit(X_train_scaled_and_encoded, y_train))
        return lst_fitted_models
    except:
        raise

def predict_results(X_test_scaled_and_encoded, lst_fitted_models):
    predictions_fitted_models = []
    try:
        for fitted_model in lst_fitted_models:
            predictions_fitted_models.append(fitted_model.predict(X_test_scaled_and_encoded))
        return predictions_fitted_models
    except:
        raise

# for func in [categorize_numeric]:
#     func.__doc__ = eval(f"DOCS_{func.__name__}")



# X = [['Male', 1], ['Female', 3], ['Female', 2]]
# Y = [['Male', 1], ['Female', 3], ['Female', 2]]
# lst_sets = [X, Y]

# X_e, Y_e = encode_data(lst_sets, OneHotEncoder)

# print(X_e, Y_e)