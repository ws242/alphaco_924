# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns 
import plotly
import yfinance as yf
import plotly.graph_objects as go

# 서술형 문제 1
"""
1. 깃허브에서 repository 생성 후 

프로젝트 폴더에서 virtualenv venv 명령어로 가상환경을 생성하고
source venv/Scripts/activate 명령어로 가상환경을 활성화 한다.
pip install 을 통해 필요한 패키지를 설치한다.

main.py에서 코드 작성을 끝냈다면 
파일 수정 후 변경 사항을 추가하기 위해 git add 를 사용한다. 
작업이 완료된 후 커밋을 사용하여 변경사항을 저장한다. 
이때 코드는 git commit -m "updated" 을 사용한다.
마지막으로 git push 를 통해 원격 저장소에 변경 사항을 보낸다. 
"""

# 코드 문제 1
result = []
for i in range(10):
    if i % 2 == 0:
        result.append(i * 2)
print(result)

# 답지
code_result1 = [i * 2 for i in result]
print(code_result1)

# 코드 문제 2
my_dict = {'apple': 3, 'banana': 5, 'orange': 2}

# 답지
my_items = my_dict.items()
print(my_items)

# 코드 문제 3
series = pd.Series([25, 35, 45, 60, 75])

# 답지
# np.where를 사용하여 조건 적용
code_result3 = pd.Series(np.where((series > 30) & (series < 60), series + 10, series))

# 결과 출력
print(code_result3)

# 코드 문제 4
iris = sns.load_dataset("iris")

# 답지
iris.to_csv("output/code4_jws.csv", index=False)
iris.to_excel("output/code4_jws.xlsx", index=False)

# 코드 문제 5
data = [
    ["1,000", "1,100", '1,510'],
    ["1,410", "1,420", '1,790'],
    ["850", "900", '1,185'],
]
columns = ["03/02", "03/03", "03/04"]
df = pd.DataFrame(data=data, columns=columns)
df.info()

# 답지


# 코드 문제 6
apple = yf.download("AAPL", start="2020-01-01", end = "2024-09-30")
fig, ax = plt.subplots()
ax.plot(apple['Open'], label = "Apple")
ax.legend()
plt.show()

# 답지
ax.legend()
plt.savefig("output/code6_jws.png")

# 코드 문제 7
tips = sns.load_dataset("tips")

# 답지
plt.savefig("output/code7_jws.png")

# 코드 문제 8
apple = yf.download("AAPL", start="2024-05-01", end="2024-09-30")

# 답지
fig.update_layout(xaxis_title="day")
