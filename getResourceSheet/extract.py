# importing libraries
import math
import requests
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
import pandas as pd 
import json


class Extract:

  # defining variables
  def __init__(self):
    # authentication
    self.token = Config.token

    # client smartSheet site
    self.clientAddress = Config.smartsheetAddress

    # address bits for contructing URL
    self.api_version = Config.smartSheetVersion

    # API endpoint
    self.end_point = Config.getResourceSheet

    #DB connection
    self.dbUri = Config.dbUri
    self.dbName = Config.dbName
    self.dbUri = self.dbUri + "/" + self.dbName
    self.engine = create_engine(self.dbUri, echo=False)

  def constructURL(self, smartSheet):
    URL = "https://" + self.clientAddress +  self.api_version + self.end_point + "/" + str(smartSheet)
    return URL

  def getSheetName(self):
    sql = text('select resource_sheet_name from get_resource_sheet_table where status = "Scheduled"')
    projects = self.engine.execute(sql)
    project_list = []
    for project in projects:
      project_list.append(project[0])
    return project_list


  def getsmartSheetMetaData(self, sheet):
    URL = "https://api.smartsheet.com/2.0/sheets"
    auth_token = "Bearer " + self.token
    req = requests.get(URL, headers={"Authorization": auth_token})
    response = req.json()
    data = response['data']
    maxRows = len(data)
    
    selectedID = ''
    for i in range(maxRows):
      if(data[i]['name'] == sheet):
        selectedID = data[i]['id']
    
    return selectedID

  def getSheetData(self, id):
    URL = self.constructURL(id)
    auth_token = "Bearer " + self.token
    req = requests.get(URL, headers={"Authorization": auth_token})
    response = req.json()

    return response

  def extract(self):
    sheet = self.getSheetName()[0]
    smartSheetID = self.getsmartSheetMetaData(sheet)
    smartSheetData = self.getSheetData(smartSheetID)
    
    return smartSheetData

