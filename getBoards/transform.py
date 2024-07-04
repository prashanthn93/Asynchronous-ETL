import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'board_id',
      'board_name',
      'board_type',
      'board_project_id'
    ))
    
    for i in range(maxRows):
      if 'location' in data[i]:
        board_project_id = data[i]['location']['projectId']
      else:
        board_project_id = ""

      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['name'],
        data[i]['type'],
        board_project_id      
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF