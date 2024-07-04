# importing libraries
import requests
import math
from config import Config


class Extract:

  # defining variables
  def __init__(self):
    # authentication
    self.uName = Config.uName
    self.password = Config.password

    # client JIRA site
    self.clientAddress = Config.clientAddress

    # address bits for contructing URL
    self.api_address = Config.apiAddress
    self.agile_address = Config.agileAddress
    self.api_version = Config.apiVersion
    self.agile_version = Config.agileVersion

    # API endpoint
    self.end_point = Config.getBoards

  # construct URL function
  def constructURL(self):
    URL = "https://" + self.clientAddress + self.agile_address + self.agile_version + self.end_point
    return URL

  def getMaxItems(self):
    url = self.constructURL()
    params={
      "startAt":0,
      "maxResults":1
    }
    req = requests.get(url,headers={"Accept": "application/json"},params=params,auth=(self.uName, self.password))
    response = req.json()
    maxItems = response['total']
    return maxItems

  def extractPage(self, pageCounter, resultArr):
    route = self.constructURL()
    params = {
        "startAt": pageCounter*100,
        "maxResults": 100
    }
    req = requests.get(route,headers={"Accept": "application/json"},params=params,auth=(self.uName, self.password))
    response = req.json();
    for item in response['values']:
        resultArr.append(item)
    
    return True

  def extract(self):
    route = self.constructURL()
    maxItems = self.getMaxItems()
    maxPages = math.ceil(maxItems/100)

    resultArr = []

    for countPage in range(0,maxPages):
      self.extractPage(countPage,resultArr)

    return resultArr

