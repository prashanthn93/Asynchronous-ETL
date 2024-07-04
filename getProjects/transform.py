import pandas as pd 
import json

"""
This table contains hardcoded data that was manually entered. I have tried to replicate the
coded data through hardcoding through this file. However, avoid refreshing this table as much as possible.

"""

class Transform:
  
  def __init__(self, selectedProjects = None):
    super().__init__()
    self.projects_to_pick = [ "SALCLD", "SERCLD", "COMNTY",
                             "CPQ", "NETSTE", "ZONECO",
                             "FFORCE", "INTKEY", "DATAMIG"]
    self.projects_to_update = selectedProjects

  def createDF(self, data):
    maxRows = len(data)
    dataDF = pd.DataFrame(columns=(
      'project_id',
      'project_key',
      'project_name',
      'project_type_key',
      'project_to_pick',
    ))
    
    for i in range(maxRows):
      project_to_pick = self.isProjectSelected(data[i]['key'], self.projects_to_pick)
      dataDF.loc[i] = [
        data[i]['id'],
        data[i]['key'],
        data[i]['name'],
        data[i]['projectTypeKey'],
        project_to_pick,
      ]
    return dataDF

  

  def isProjectSelected(self, projectKey, selectedProjects):
    if projectKey in selectedProjects:
      return 'Yes'
    else:
      return 'No'
        
  def transform(self, data):
    dataDF = self.createDF(data)
    return dataDF