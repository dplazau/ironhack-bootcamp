DOCS_categorize_numeric = \
    """Categorizes numeric columns into discrete and continous

    Parameters
    ----------
    set : pd.Dataframe
        A pandas dataframe containing only numeric columns

    Returns
    -------
    list : [pd.Dataframe]
        a list of subsets of both discrete and continous columns
    """