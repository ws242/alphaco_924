# 파일명 : alphaco_241002.py

import pandas as pd 
from pandas import DataFrame

data = [
    ["037730", "3R", 1510],
    ["036360", "3SOFT", 1790],
    ["005670", "ACTS", 1185]
]

columns = ["종목코드", "종목명", "현재가"]
df = DataFrame(data=data, columns=columns)
df.set_index("종목코드", inplace=True)
#print(df)

# ascending=False : 내림차순
# ascending=True (기본값) : 오름차순
#print(df.sort_values(by="현재가", ascending =False))
#print(df.sort_values(by="종목명", ascending=True))

#print(df.sort_index()) #기본값
#print(df.sort_index(ascending=False))

# 인덱스 연산
idx1 = pd.Index([1,2,3])
idx2 = pd.Index([2,3,4])

#print(idx1.union(idx2))
#print(idx1.intersection(idx2))
#print(idx1.difference(idx2))

from pandas import DataFrame

data = [
    ["2차전지(생산)", "SK이노베이션", 10.19, 1.29],
    ["해운", "팬오션", 21.23, 0.95],
    ["시스템반도체", "티엘아이", 35.97, 1.12],
    ["해운", "HMM", 21.52, 3.20],
    ["시스템반도체", "아이에이", 37.32, 3.55],
    ["2차전지(생산)", "LG화학", 83.06, 3.75]
]

columns = ["테마", "종목명", "PER", "PBR"]
df = DataFrame(data=data, columns=columns)
#print(df)

result = df.groupby("테마")[["PER", "PBR"]].mean()
#print(result, type(result))

#print(df.groupby("테마").get_group("2차전지(생산)"))
#print(df.groupby("테마").get_group("시스템반도체"))
#print(df.groupby("테마").get_group("해운"))

result = df.groupby("테마")[["PER", "PBR"]].mean()

df = pd.read_excel( "ss_ex_1.xlsx" , parse_dates=['일자'], index_col=0)
#print(df.head())
df = df.reset_index()
#print(df.head(1))
#print(df.info())

#print(df['일자'].dt.year)
#print(df['일자'].dt.quarter)
#print(df['일자'].dt.month)
#print(df['일자'].dt.day)

# column 추가
df['연도'] = df['일자'].dt.year
df['분기'] = df['일자'].dt.quarter
df['월'] = df['일자'].dt.month
df['일'] = df['일자'].dt.day

#print(df.head(1))

#result = df.groupby(['연도', '월']).get_group((2021, 2))
#print(result)
#result = df.groupby(['연도', '월'])['시가'].mean()
#print(result)

multiples = {
    "시가": "first",
    "저가": min,
    "고가": max,
    "종가": "last"
}

#result = df.groupby(['연도', '월']).agg(multiples)
#print(result)
#print(result.reset_index())

