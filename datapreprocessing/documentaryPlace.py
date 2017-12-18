"""
Author: Cui Chenng
E-mail: cuic@lreis.ac.cn
Created_at: 2017-12-06
Purpose: 提取文本中的地名实体

注:python为3.4，Jpype貌似目前不支持3.6
"""
from jpype import *
import pandas as pd
from collections import Counter
startJVM(getDefaultJVMPath(), "-Djava.class.path=D:\hanlp\hanlp-1.5.2.jar;D:\hanlp", "-Xms1g", "-Xmx1g")
java.lang.System.out.println("hello world!")

datapath = "documentarydata.csv"
data = pd.read_csv(datapath)
summarys = data["summary"]

standardtokenizer = JClass("com.hankcs.hanlp.tokenizer.StandardTokenizer")
standardtokenizer.SEGMENT.enablePlaceRecognize(True).enableAllNamedEntityRecognize(True)

def getPlaceFromText(text):
    place = []
    if not isinstance(text, (str)):
        return None
    result = standardtokenizer.segment(text)
    result = result.toString()
    # 去除首尾的中括号
    result = result[1:-1]
    result = result.split(",")
    for wordandPOS in result:
        wordandPOS = wordandPOS.split("/")
        if len(wordandPOS) == 2:
            word, POS = wordandPOS[0], wordandPOS[1]
            if POS in ["ns", "nsf"]:
                place.append(word.strip())
    place = Counter(place)
    place = place.most_common(1)
    if not place:
        return None
    else:
        return place[0][0]

result = []
for index, row in data.iterrows():
    country = row["country"].split("/")[0]
    summary = row["summary"]
    place = getPlaceFromText(summary)
    if not place:
        place = country
    print(place)
    result.append(place)
print(result)

data["place"] = result
data.to_csv("test.csv")
