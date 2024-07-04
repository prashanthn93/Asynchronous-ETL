import pandas as pd 
import json

class Transform:
  
  def __init__(self):
    super().__init__()

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'test_id',
      'test_key',
      'parent_issue_id',
      'assignee_account_id',
      'status_in_parent',
      'status_category_id',
      'test_status',
      'priority_name',
      'reporter_account_id',
      'updated',
      'created',
      'fix_versions',
      'labels'
    ))
    
    for i in range(maxRows):
      dataDF.loc[i] = [
        data[i]['test_id'],
        data[i]['test_key'],
        data[i]['parent_issue_id'],
        data[i]['assignee_account_id'],
        data[i]['status_in_parent'],
        data[i]['status_category_id'],
        data[i]['test_status'],
        data[i]['priority_name'],
        data[i]['reporter_account_id'],
         data[i]['updated'],
        data[i]['created'],
        data[i]['fix_versions'],
        data[i]['labels'],
      ]
    return dataDF
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF
