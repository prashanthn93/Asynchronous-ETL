import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'status_id',
      'status_name',
      'status_untranslated_name'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['name'],
        data[i]['name']
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF