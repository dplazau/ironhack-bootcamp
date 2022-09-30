from pydoc import doc
from typing import final
# from .docs import *
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error


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


def split_data(df, target):
    df = df.dropna()
    try:
        X = df.drop([target], axis=1)
        y = df[target]
        return train_test_split(X, y)
    except:
        raise
    

def scale_sets(sets, scaler):
    lst_scaled_sets = []
    try:
        for set in sets:
            set_scaled = scaler().fit_transform(set.select_dtypes(np.number))
            set[set.select_dtypes(np.number).columns] = set_scaled
            lst_scaled_sets.append(set)
        return lst_scaled_sets
    except ValueError as err:
        print(err)
    except KeyError as err:
        print(err)
    except:
        raise


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


def plot_distributions(data: pd.DataFrame, figsize: tuple):
    for col in data:
        plt.figure(figsize=figsize)
        if data[col].dtype in ['int64', 'float64']:
            sns.displot(data[col])
        else:
            sns.countplot(data[col])

def unique_values_per_column(df):
    unique_values={}
    for col in df.columns:
        unique_values[col] = df[col].value_counts().shape[0]
    return pd.DataFrame(unique_values, index=['unique value count']).transpose()

def duplicate_obs(df):
    duplicates = df[df.duplicated()]
    return duplicates, len(duplicates)

def apply_model(X_train, X_test, y_train, model):
    model = model()
    model.fit(X_train, y_train)
    return model.predict(X_test)

def get_predictions(models, sets):
    X_train, X_test, y_train, y_test = sets
    lst_predictions_per_model = []
    for name, model in models.items():
        model_prediction = apply_model(X_train, X_test, y_train, model)
        # model_prediction = model_prediction.apply(lambda x: 1 if x >= 0.5 else 0)
        # print(model_prediction)
        lst_predictions_per_model.append([f"{name}", model_prediction])
    return lst_predictions_per_model

def get_results(benchmark_prediction_of_models, y_test):
    benchmark_results = pd.DataFrame(columns=["model", "r2", "mean_abs", "mean_sqrd"])
    for prediction in benchmark_prediction_of_models:
        result = {
            "model": prediction[0],
            "r2": r2_score(y_test, prediction[1]),
            "mean_abs": mean_absolute_error(y_test, prediction[1]),
            "mean_sqrd": mean_squared_error(y_test, prediction[1], squared=False)
            }
        result = pd.DataFrame.from_records([result])
        benchmark_results = pd.concat([benchmark_results, result])
        
    benchmark_results.set_index("model", inplace=True)
    return benchmark_results

def remove_outliers(data: pd.DataFrame, skip_columns: list[str],
                    threshold: float = 1.5, verbose: bool = False) -> pd.DataFrame:
    initial_size = len(data)
    for col in data.select_dtypes(np.number).columns:
        if col not in skip_columns:
            upper = np.percentile(data[col], 75)
            lower = np.percentile(data[col], 25)
            iqr = upper - lower
            upper_limit = upper + threshold * iqr
            lower_limit = lower - threshold * iqr
            data = data[(data[col] > lower_limit) & (data[col] < upper_limit)]
    if verbose:
        print('Outliers removal has removed {} rows ({} % of initial size)'.format(
            initial_size-len(data), round((1-len(data)/initial_size)*100, 2)
        ))
    return data


def get_balanced_predictions(MODELS, balanced_sets):
    X_train_balanced, X_test, y_train_balanced, y_test = balanced_sets
    lst_predictions_per_model = []
    for name, model in MODELS.items():
        model_prediction = apply_model(X_train_balanced, X_test, y_train_balanced, model)
        # model_prediction = model_prediction.apply(lambda x: 1 if x >= 0.5 else 0)
        # print(model_prediction)
        lst_predictions_per_model.append([f"{name}", model_prediction])
    return lst_predictions_per_model



def create_multicoll_df(unique_couples, corr: pd.DataFrame) -> pd.DataFrame:
    """
    Structure multicollinearity information in a DataFrame.
    It should not be called directly.
    """
    data = []
    for couple in unique_couples:
        corr_value = corr[couple[1]].loc[corr.index == couple[0]].item()
        data.append([couple[0], couple[1], corr_value])
    df_mult = pd.DataFrame(data=data, columns=['feat1', 'feat2', 'corr'])
    return df_mult.sort_values(by='feat1').reset_index(drop=True)

def report_multicoll(data: pd.DataFrame, corr_thresh: float = 0.3,
                     corr_method='pearson') -> pd.DataFrame:
    """
    Identify and report multicollinearity in a dataset.

    Parameters:
    ----------
    data: pandas.DataFrame
        dataset
    corr_thresh: float, default = 0.3
        Correlation threshold that identifies multicollinearity.
    corr_method: {'pearson', 'kendall', 'spearman'} or callable, default='pearson'
        Method of correlation. For additional documentation refer to:
        <https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.corr.html>

    Returns:
    -------
    report: pandas.DataFrame
        Report where features with multicollinearity are displayed together 
        with their correlation coefficient.
    """
    corr = data.corr(method=corr_method)
    # drop correlation below threshold or correlations with feature itself
    cond = (corr.apply(abs) < corr_thresh) | (corr == 1.0)
    masked_corr = corr.mask(cond)
    masked_corr = masked_corr.dropna(axis=1, how='all')
    masked_corr = masked_corr.dropna(axis=0, how='all')

    # create unique features coupled with multicollinearity
    multicoll_couples = []
    for feature1 in masked_corr.index:
        feature2_lst = masked_corr.loc[feature1].dropna().index.tolist()
        multicoll_couples.extend([(feature1, feat2) for feat2 in feature2_lst])
    sorted_couples = [sorted(couple) for couple in multicoll_couples]
    unique_couples = [list(x) for x in set(tuple(x) for x in sorted_couples)]
    return create_multicoll_df(unique_couples, corr)