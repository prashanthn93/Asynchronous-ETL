#importing libraries
import requests
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from selectedProjects import SelectedProjects

class Extract(SelectedProjects):

  #defining variables
  def __init__(self, selectedProjects, dbTable):
    super().__init__(selectedProjects, dbTable)
    #authentication
    self.uName = Config.uName
    self.password = Config.password

    #client JIRA site
    self.clientAddress = Config.clientAddress

    #address bits for contructing URL
    self.api_address = Config.apiAddress
    self.agile_address = Config.agileAddress
    self.api_version = Config.apiVersion
    self.agile_version = Config.agileVersion

    #API endpoint
    self.end_point = Config.getFixVersions
    self.middle_point = Config.getProjects

    #DB connection
    self.dbUri = Config.dbUri
    self.dbName = Config.dbName
    self.dbTable = Config.dbTableMasterProject
    self.dbUri = self.dbUri + "/" + self.dbName
    self.engine = create_engine(self.dbUri, echo=False)

  #construct URL function
  def constructURL(self,project):
    URL = "https://" + self.clientAddress + self.api_address + self.api_version + self.middle_point + '/' + str(project) + self.end_point
    return URL

  def extractFixVersion(self, project, result):
    route = self.constructURL(project)
    req = requests.get(route,headers={"Accept": "application/json"},auth=(self.uName, self.password))
    response = req.json()
    for item in response:
      result.append(item)

  def extract(self):
    project_list = self.getProjectList()
    result =[]
    for project in project_list:
      self.extractFixVersion(project, result)
    return result

