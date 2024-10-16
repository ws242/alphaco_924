# -*- coding: utf-8 -*-
import pandas as pd 
import seaborn as sns
import streamlit as st
import matplotlib.pyplot as plt

@st.cache_data
def load_data():
    df = sns.load_dataset('tips')
    return df

def main():
    st.title("Streamlit with Matplotlib")   
    tips = load_data()

    # 데이터가공
    m_tips = tips.loc[tips['sex'] == 'Male', :]
    f_tips = tips.loc[tips['sex'] == 'Female', :]

    # 시각화 차트
    fig, ax = plt.subplots(ncols=2, figsize=(10, 6), sharex=True, sharey=True)
    ax[0].scatter(x = m_tips['total_bill'], y = m_tips['tip'])
    ax[0].set_title('Male')
    ax[1].scatter(x = f_tips['total_bill'], y = f_tips['tip'])
    ax[1].set_title('Female')

    # 중요포인트
    # plt.show()
    st.pyplot(fig) # plt.show() 대신

if __name__ == "__main__":
    main()



