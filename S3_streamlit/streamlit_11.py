import pingouin as pg
import seaborn as sns

# Load an example dataset with the personality scores of 500 participants
df = pg.read_dataset('pairwise_corr')

# 1.Test for bivariate normality (optional)
pg.multivariate_normality(df[['Neuroticism', 'Openness']])

# 1bis. Visual inspection with a histogram + scatter plot (optional)
sns.jointplot(data=df, x='Neuroticism', y='Openness', kind='reg')

# 2. If the data have a bivariate normal distribution and no clear outlier(s), we can use a regular Pearson correlation
pg.corr(df['Neuroticism'], df['Openness'], method='pearson')

import streamlit as st
import matplotlib.pyplot as plt
import numpy as np
import pingouin as pg
import seaborn as sns


def main():
    df = pg.read_dataset('pairwise_corr')
    result = pg.multivariate_normality(df[['Neuroticism', 'Openness']])
    st.dataframe(result)

    fig = sns.jointplot(data=df, x='Neuroticism', y='Openness', kind='reg')
    st.pyplot(fig)

    st.dataframe(pg.corr(df['Neuroticism'], df['Openness'], method='pearson'))

if __name__ == "__main__":
    main()