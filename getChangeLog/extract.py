import aiohttp
import asyncio
import sys
import async_timeout
import time
import math
import requests
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from selectedProjects import SelectedProjects
from utility import formatter

class Extract(SelectedProjects):
    #Get details of a single issue from JIRA
    #1. get all environment var details
    #2. construct request for JIRA REST API
    #3. return the json

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
        self.end_point = Config.getChangeLog

        #DB connection
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbUri = self.dbUri + "/" + self.dbName
        self.engine = create_engine(self.dbUri, echo=False)

    def constructUrl(self, key):
        route = "https://" + self.clientAddress + self.api_address + self.api_version + "/issue/" + str(key) + self.end_point
        return route

    def getIssueList(self):
        selectedProjects = self.getProjectList()
        projectsSQLTuple = formatter.getStringTuple(selectedProjects)

        selectCode = """
                    select issue_id from master_issue as ISSUES, master_project as PROJECTS, master_issue_type as ISSUE_TYPES
                        where ISSUES.project_id = PROJECTS.project_id
                        and ISSUES.issue_type_id = ISSUE_TYPES.issue_type_id
                        and PROJECTS.project_key in {updatedProjects}
                        and ISSUE_TYPES.issue_type_name in ( 'Bug', 'Story' ,'Test')
                     """.format(updatedProjects = projectsSQLTuple)
        sql = text(selectCode)
        issues = self.engine.execute(sql)
        issue_list = []
        for issue in issues:
            issue_list.append(issue[0])
        return issue_list


    def extract(self):
        issueList = self.getIssueList()
        URLS = [self.constructUrl(key) for key in issueList ]
        result = []
        if sys.version_info[0] == 3 and sys.version_info[1] >= 8 and sys.platform.startswith('win'):
            asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
        loopresult=asyncio.run(self.getPages(URLS))
        for pagecontent in loopresult:
            key=pagecontent['id']
            for change in pagecontent['changelog']['histories']:
                item = {'item': change,'key':  key,}
                result.append(item)        
        return result
 

    async def getPages(self,urls):
        tasks=[]
        async with aiohttp.ClientSession(headers={"Accept": "application/json"}, auth=aiohttp.BasicAuth(self.uName, self.password)) as session:
            for url in urls:
                tasks.append(self.getPage(session,url))
            all_tasks=asyncio.gather(*tasks)   #list of responses
            return await all_tasks

    async def getPage(self , session,url):
        params = {
            "startAt": 0,
            "maxResults": 150 
            }
        async with session.get(url,params=params) as response:
            return await response.json()

            
            
