import math
import json
import requests
import json
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from asyncAPI import AsyncAPI
import random
from .date_formatter import DateFormatter
from selectedProjects import SelectedProjects
from utility import formatter, logUtils
import aiohttp
import asyncio
import sys
from collections import ChainMap
from logger import LogManager

class Extract(SelectedProjects, AsyncAPI):
    # Get details of a single issue from JIRA
    # 1. get all environment var details
    # 2. construct request for JIRA REST API
    # 3. return the json of the issue details
    # 4. from 3 return list of tests in the issue
    # 5. from 4. construct request for JIRA REST API for each test
    # 6  from 6. return some fields 

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
        self.raven_address = Config.ravenAddress

        self.api_version = Config.apiVersion
        self.agile_version = Config.agileVersion
        self.raven_version = Config.ravenVersion

        # API endpoint
        self.end_point = Config.getIssues
        self.req_end_point = Config.getRequirement
        self.test_end_point = Config.testRequirement

        #DB connection
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbUri = self.dbUri + "/" + self.dbName
        self.engine = create_engine(self.dbUri, echo=False)

        self.log = LogManager()

    def constructURL(self):
        URL = "https://" + self.clientAddress + self.api_address + self.api_version + self.end_point
        return URL

    def constructRequirementURL(self):
        URL = "https://" + self.clientAddress + self.raven_address + self.raven_version + self.req_end_point
        return URL

    def constructTestCovURL(self, issueKey):
        reqURL = self.constructRequirementURL()
        testCovURL = reqURL + "/" + issueKey +  self.test_end_point + "?environment=-1&version=NO_VERSION"
        return testCovURL

    def getAllIssueKeys(self):
        # return ["CPQ-1910"]
        projectIds = self.getProjectIds()
        idsTuple = formatter.getStringTuple(projectIds)

        sqlSelect1 = "select issue_key from master_issue where project_id in {projectIds} order by issue_id asc".format(projectIds = idsTuple )
        sqlSelect2 = "select issue_id from master_issue where project_id in {projectIds} order by issue_id asc".format(projectIds = idsTuple )
        sql1 = text(sqlSelect1);
        dbRows1 = self.engine.execute(sql1);
        sql2 = text(sqlSelect2);
        dbRows2 = self.engine.execute(sql2);
        issueKeys = []
        issueIds = []
        for row in dbRows1:
            issueKeys.append(row[0])
        for row in dbRows2:
            issueIds.append(row[0])

        issueData = list(zip(issueKeys,issueIds))

        return issueData

    def constructKeyUrl(self, key):
        route = "https://" + self.clientAddress + self.api_address + self.api_version + "/issue/" + str(key)
        return route


    def getWithNullCheck(self, dict, fieldPathList):

        currentValue = dict

        for field in fieldPathList:
            currentValue = currentValue.get(field)
            if currentValue is None:
                return None
        return currentValue

    def getFormattedDateTime(self, dateTime):
        if not dateTime:
            return None
        formatter = DateFormatter()
        formattedDate = formatter.getFormattedDate(dateTime)
        return formattedDate

    def listToJson(self, list):
        return json.dumps(list)

    def getLabels(self, testFields):
        labelsList = self.getWithNullCheck(testFields, ["labels"])
        if not labelsList or len(labelsList) == 0:
            return None

        labelsJson = self.listToJson(labelsList)
        return labelsJson

    def getFixVerionIds(self, testFields):
        fixVersions = self.getWithNullCheck(testFields, ["fixVersions"])
        
        if not fixVersions or len(fixVersions) == 0:
            return None
        
        fixVersionIds = []
        for fixVersion in fixVersions:
            id = fixVersion.get("id")
            fixVersionIds.append(id)

        fixVersionIdsJson = self.listToJson(fixVersionIds) 
        return fixVersionIdsJson

    def getStatusFromTest(self, test):
        return self.getWithNullCheck(test, ["status", "status"])

    def getTestData(self, testDetails, parentIssueId, testStatus):

        testData = self.getTestDataWithReqFields(testDetails, parentIssueId)

        if testData:
            testData["status_in_parent"] = testStatus
            testData["test_key"] = testDetails.get("key")

            testFields = testDetails.get("fields")

            if testFields:
                status_category_id = self.getWithNullCheck(testFields, ["status", "statusCategory", "id"])
                if status_category_id:
                    status_category_id = int(status_category_id)
                testData["assignee_account_id"] = self.getWithNullCheck(testFields, ["assignee", "key"])
                testData["status_category_id"] = status_category_id
                testData["test_status"] = self.getWithNullCheck(testFields, ["status", "name"])
                testData["priority_name"] = self.getWithNullCheck(testFields, ["priority", "name"])
                testData["reporter_account_id"] = self.getWithNullCheck(testFields, ["reporter", "key"])
                testData["updated"] = self.getFormattedDateTime(testFields.get("updated"))
                testData["created"] = self.getFormattedDateTime(testFields.get("created"))
                testData["fix_versions"] = self.getFixVerionIds(testFields)
                testData["labels"] = self.getLabels(testFields)
            return testData
        else:
            return None

    def getTestDataWithReqFields(self, testDetails, parentIssueId):
        test_id = testDetails.get("id")

        if not parentIssueId or not test_id:
            return None
        else:
            testData = {
                "test_id": int(test_id),
                "parent_issue_id": int(parentIssueId),
                "status_in_parent": None,
                "test_key": None,
                "assignee_account_id": None,
                "status_category_id": None,
                "test_status": None,
                "priority_name": None,
                "reporter_account_id": None,
                "updated": None,
                "created": None,
                "labels": None,
                "fix_versions": None
            }
            return testData

    def getReqCoverageDetails(self,coverageDetails):

        req_coverage=list(filter(lambda x: list(x.values())[0]['entries']!=[] , coverageDetails))  # Remove elements without test cases
        
        req_coverage=list(map(lambda x :{ list(x.keys())[0]:list(x.values())[0]['entries'] },req_coverage)) # Bring out only the details related to test cases

        req_coverage = ChainMap(*req_coverage)

        return req_coverage


    def getKeytoKeyStatus(self,req_coverage):
        result={}
        for parentId,tests in req_coverage.items() :
            
            for test in tests:
                testKey = test.get("key")
                testStatus = self.getStatusFromTest(test)
                temp=[parentId,testStatus]
                result[testKey]=temp

        return result

    def getCleanData(self,consolData):
        totalData=[]
        for preData in consolData:
            parentId = preData[0]
            testStatus = preData[1]
            testDetail = preData[2]
            cleanData = self.getTestData(testDetail, parentId, testStatus)
            if cleanData:
                totalData.append(cleanData)
        
        return totalData

    def extract(self):
        id_data = self.getAllIssueKeys()
        keys=[key[0] for key in id_data]
        URLS = {data[1]:self.constructTestCovURL(data[0]) for data in id_data}
        totalTestData = []

        if sys.version_info[0] == 3 and sys.version_info[1] >= 8 and sys.platform.startswith('win'):
                asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

        testCoverageDetails=asyncio.run(self.getAllCoverage(URLS))

        ReqCoverage=self.getReqCoverageDetails(testCoverageDetails)

        KeytoKeyStatus = self.getKeytoKeyStatus(ReqCoverage)
        
        testKeys = list(KeytoKeyStatus.keys())

        URLS2 = {testKey:self.constructURL()+"/" + testKey for testKey in testKeys}

        if sys.version_info[0] == 3 and sys.version_info[1] >= 8 and sys.platform.startswith('win'):
                asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

        testDetails=asyncio.run(self.testPages(URLS2))

        for detail in testDetails:
            (key , val), = detail.items()
            KeytoKeyStatus[key].append(val)

        consolidatedTestData=list(KeytoKeyStatus.values())

        totalTestData = self.getCleanData(consolidatedTestData)
                
        return totalTestData
    

    
    async def testPages(self,urls):
        tasks=[]
        async with aiohttp.ClientSession(headers={"Accept": "application/json"}, auth=aiohttp.BasicAuth(self.uName, self.password)) as session:
            for key , url in urls.items():
                tasks.append(self.testPage(session,key,url))
            all_tasks=asyncio.gather(*tasks)   #list of responses
            return await all_tasks

    async def testPage(self , session,key,url):
        params = {
            "startAt": 0,
            "maxResults": 100 
            }
        async with session.get(url,params=params) as response:
            resp= await response.json()
            return {key:resp}

            
