import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'fix_version_id',
      'fix_version_description',
      'fix_version_name',
      'fix_version_archived',
      'fix_version_released',
      'project_id'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['id'] if('id' in data[i]) else "",
        data[i]['description'] if('description' in data[i]) else "",
        data[i]['name'] if('name' in data[i]) else "",
        data[i]['archived'] if('archived' in data[i]) else "",
        data[i]['released'] if('released' in data[i]) else "",
        data[i]['projectId'] if('projectId' in data[i]) else ""
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF