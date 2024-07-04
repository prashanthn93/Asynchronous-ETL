import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'status_category_id',
      'status_category_key',
      'status_category_color_name',
      'status_category_name'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['key'],
        data[i]['colorName'],
        data[i]['name']
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF