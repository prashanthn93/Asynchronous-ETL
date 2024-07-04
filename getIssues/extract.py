# importing libraries
import aiohttp
import asyncio
import sys
import async_timeout
import time
import requests
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
import math
from config import Config
from selectedProjects import SelectedProjects


class Extract(SelectedProjects):
    # Get details of a single issue from JIRA
    # 1. get all environment var details
    # 2. construct request for JIRA REST API
    # 3. return the json

  #defining variables
    def __init__(self, selectedProjects, dbTable):
        super().__init__(selectedProjects, dbTable)        
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
        self.end_point = Config.getIssueInProjects

        #DB connection
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbUri = self.dbUri + "/" + self.dbName
        self.engine = create_engine(self.dbUri, echo=False)


    def constructURL(self):
        URL = "https://" + self.clientAddress + self.api_address + self.api_version + self.end_point
        return URL

    def getMaxIssues(self,project):
        URL = self.constructURL() + "project=" + str(project)
        params = {
            "startAt": 0,
            "maxResults": 1
        }
        req = requests.get(URL, headers={"Accept": "application/json"}, params=params, auth=(self.uName, self.password))
        response = req.json()
        maxIssues = response['total']
        return maxIssues


    def extract(self):
        project_list = self.getProjectList()
        result = []
        for project in project_list:
            self.extractIssue(result, project)
        return result

    def extractIssue(self,result, project):
        maxIssues = self.getMaxIssues(project)
        maxPages = math.ceil(maxIssues/100)
        params=[{"startAt": pageCounter*100,"maxResults": 100} for pageCounter in range(0,maxPages)]
        if sys.version_info[0] == 3 and sys.version_info[1] >= 8 and sys.platform.startswith('win'):
            asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
        loopresult=asyncio.run(self.getPages(params,project))
        for page_content in loopresult:
            for issue in page_content['issues']:
                result.append(issue)
        return True

    async def getPages(self, params, project):
        tasks=[]
        async with aiohttp.ClientSession(headers={"Accept": "application/json"}, auth=aiohttp.BasicAuth(self.uName, self.password)) as session:
            for param in params:
                tasks.append(self.getPage(session,param,project))
            all_tasks=asyncio.gather(*tasks)   #list of responses
            return await all_tasks

    async def getPage(self , session,param , project):
        URL = self.constructURL() + "project=" + str(project)
        async with async_timeout.timeout(60):
            async with session.get(URL, params=param) as response:
                return await response.json()



        


  

