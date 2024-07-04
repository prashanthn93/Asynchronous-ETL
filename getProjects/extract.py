#importing libraries
import requests
from config import Config

class Extract:

  #defining variables
  def __init__(self):
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
    self.end_point = Config.getProjects

  #construct URL function
  def constructURL(self):
    URL = "https://" + self.clientAddress + self.api_address + self.api_version + self.end_point
    return URL
  

  def extract(self):
    route = self.constructURL()
    req = requests.get(route,headers={"Accept": "application/json"},auth=(self.uName, self.password))
    response = req.json()
    return response

