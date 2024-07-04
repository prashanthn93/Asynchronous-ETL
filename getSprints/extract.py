# importing libraries
import requests
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
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
    self.end_point = Config.getSprint
    self.middle_point = Config.getBoards

    #DB connection
    self.dbUri = Config.dbUri
    self.dbName = Config.dbName
    self.dbTable = Config.dbTableMasterBoard
    self.dbUri = self.dbUri + "/" + self.dbName
    self.engine = create_engine(self.dbUri, echo=False)

  # construct URL function
  def constructURL(self, board_number):
    URL = "https://" + self.clientAddress + self.agile_address + self.agile_version + self.middle_point + "/" + str(board_number) + self.end_point
    return URL

  def getMaxItems(self, board):
    url = self.constructURL(board)
    params={
      "startAt":0,
      "maxResults":1
    }
    req = requests.get(url,headers={"Accept": "application/json"},params=params,auth=(self.uName, self.password))
    response = req.json()
    if 'errorMessages' in response:
      maxItems = -1
    else:
      maxItems = response['maxResults']
    return maxItems

  def extractPage(self, pageCounter, board, resultArr):
    route = self.constructURL(board)
    params = {
        "startAt": pageCounter*100,
        "maxResults": 100
    }
    req = requests.get(route,headers={"Accept": "application/json"},params=params,auth=(self.uName, self.password))
    response = req.json();
    for item in response['values']:
        resultArr.append(item)
    
    return True

  def extractBoards(self):
    sql = text('select board_id from master_board');
    boards = self.engine.execute(sql);
    board_list = [];
    for board in boards:
      board_list.append(board[0])
    return board_list;
    

  def extractSprint(self, board, resultArr):
    route = self.constructURL(board)
    maxItems = self.getMaxItems(board)
    if maxItems == -1:
      return
    else:
      maxPages = math.ceil(maxItems/100)
      for countPage in range(0,maxPages):
        self.extractPage(countPage,board, resultArr)



  def extract(self):
    board_list = self.extractBoards();
    result_arr =[]
    for board in board_list:
      self.extractSprint(board, result_arr)
    return result_arr;

