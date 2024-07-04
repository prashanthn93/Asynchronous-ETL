import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'issue_type_id',
      'issue_type_desc',
      'issue_type_name'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['description'],
        data[i]['name']
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF