import os
import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
from sklearn.preprocessing import MinMaxScaler, StandardScaler, LabelEncoder, OneHotEncoder, Normalizer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
warnings.filterwarnings('ignore')


DF_URL = "./files_for_lab/csv_files/marketing_customer_analysis.csv"
df = pd.read_csv(DF_URL)

df.columns = df.columns.str.lower().str.replace(' ', '_')
df.set_index('customer').tail(3).transpose()

# Analyze Multicollinerity
def show_corr_heatmap(df, figsize, export_path='figs/corr_heatmap.png'):
    """Show andeExport half correlation matrix for the dataset in a .png figure 
    TODO: print couples with highest correlation and let user decide if remove one of them from
    dataset. In that case, returns a new copy of the DataFrame"""
    mask = np.zeros_like(df.corr()) # Matrix full of zeros with shape of df.corr()
    mask[np.triu_indices_from(mask)] = True # upper tridiagonal mask
    fig, ax = plt.subplots(figsize=figsize)
    ax = sns.heatmap(df.corr(), mask=mask, annot=True)
    if not os.path.isdir(export_path.split('/')[0]):
        os.makedirs(export_path.split('/')[0])
    plt.savefig(export_path, dpi=600)

show_corr_heatmap(df, (10, 8))