import pandas as pd

filpath = "test.csv"
data = pd.read_csv(filpath)
data.to_excel("ss.xls",index=False)