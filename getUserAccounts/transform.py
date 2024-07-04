import pandas as pd 
import json

from pandas.core.dtypes.missing import notnull

class Transform:
  
  def __init__(self):
    super().__init__()

  def formatDF(self, data):
    dataFormat = []
    maxRows = len(data)
    for i in range(maxRows):
      userA = data[i]['fields']['assignee']
      userB = data[i]['fields']['creator']
      userC = data[i]['fields']['reporter']
      if userA:
        dataFormat.append(userA)
      if userB:
        dataFormat.append(userB)
      if userC:
        dataFormat.append(userC)   

    return dataFormat  

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'account_id',
      'account_type',
      'display_name',
      'active'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['accountId'],
        data[i]['accountType'],
        data[i]['displayName'],
        data[i]['active']
      ]
    return dataDF
        
  def transform(self, data):
    dataFormat = self.formatDF(data)
    dataDF = self.createDF(dataFormat)
    return dataDF