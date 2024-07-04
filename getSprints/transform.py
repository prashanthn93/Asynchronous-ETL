import pandas as pd 
import json
from utility.dateTimeUtils import convertDateTime

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'sprint_id',
      'sprint_state',
      'sprint_name',
      'sprint_start_date',
      'sprint_end_date',
      'sprint_complete_date',
      'board_id'
    ))
    
    for i in range(maxRows):
      start_date = 'startDate'
      end_date = 'endDate'
      complete_data = 'completeDate'

      if'originBoardId' in data[i]:
        originBoardId = data[i]['originBoardId']
      else:
        originBoardId = ""

      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['state'],
        data[i]['name'],
        convertDateTime(data[i]['startDate'] if (start_date in data[i]) else ""),
        convertDateTime(data[i]['endDate'] if (end_date in data[i]) else ""),
        convertDateTime(data[i]['completeDate'] if (complete_data in data[i]) else ""),
        originBoardId
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF