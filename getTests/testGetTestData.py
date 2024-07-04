#from types import NotImplementedType
import unittest
from unittest.mock import MagicMock
import os
import sys
#from .extract import Extract

#sys.path.append(os.path.abspath("./testGetTestData.py"))

from extract import *

class TestExtract(unittest.TestCase):

    def test_constructURL(self):
        extract = Extract()
        URL = extract.constructURL()
        self.assertEqual(URL, "https://jira.sample-project.com/rest/api/2/issue")

    def test_getTestCoverageDetails(self):
        extract = Extract()
        testCovDetails = extract.getTestCoverageDetails("CPQ-1910")
        self.assertEqual(len(testCovDetails.get("entries")), 2)

    def test_constructRequirementURL(self):
        extract = Extract()
        URL = extract.constructRequirementURL()
        self.assertEqual(URL, "https://jira.sample-project.com/rest/raven/1.0/requirement")

    def test_constructTestCovURL(self):
        extract = Extract()
        URL = extract.constructTestCovURL('CPQ-1910')
        self.assertEqual(URL, "https://jira.sample-project.com/rest/raven/1.0/requirement/CPQ-1910/tests?environment=-1&version=NO_VERSION")

    def test_getIssueDetails(self):
        extract = Extract()
        issueDetails = extract.getIssueDetails("CPQ-1910")
        self.assertEqual(issueDetails.get("id"), "346932")
        self.assertEqual(issueDetails.get("key"), "CPQ-1910")
        self.assertIsNotNone(issueDetails.get("fields"))

    def test_getWithNullCheck(self):
        extract = Extract()
        value = {
            "healthcare": "excellent"
        }
        result = extract.getWithNullCheck(value, ["status", "statusCategory", "id"])
        self.assertIsNone(result)

        value = {
            "status":{
                "statusCategory":{
                    "id": 1234
                }
            }
        }
        result = extract.getWithNullCheck(value, ["status", "statusCategory", "id"])
        self.assertEqual(result, 1234)

        value = {
            "status":{
                "statusCategory":None
            }
        }
        result = extract.getWithNullCheck(value, ["status", "statusCategory", "id"])
        self.assertIsNone(result)

    def test_getTestData(self):
        extract = Extract()
        testDetails = {
            "expand": "renderedFields,names,schema,operations,editmeta,changelog,versionedRepresentations",
            "id": "296549",
            "self": "https://jira.sample-project.com/rest/api/latest/issue/296549",
            "key": "CPQ-1101",
            "fields": {
                "aggregatetimeoriginalestimate": None,
                "customfield_11824": None,
                "customfield_11703": None,
                "customfield_11827": None,
                "customfield_11706": {
                    "self": "https://jira.sample-project.com/rest/api/2/customFieldOption/12527",
                    "value": "Exempt (Salary)",
                    "id": "12527",
                    "disabled": False
                },
                "assignee": {
                    "self": "https://jira.sample-project.com/rest/api/2/user?username=naval.sharma%40simplus.com",
                    "name": "naval.sharma@simplus.com",
                    "key": "JIRAUSER14590",
                    "emailAddress": "naval.sharma@simplus.com",
                    "avatarUrls": {
                        "48x48": "https://www.gravatar.com/avatar/aa221d7eb30a38ed5acdf06481decc35?d=mm&s=48",
                        "24x24": "https://www.gravatar.com/avatar/aa221d7eb30a38ed5acdf06481decc35?d=mm&s=24",
                        "16x16": "https://www.gravatar.com/avatar/aa221d7eb30a38ed5acdf06481decc35?d=mm&s=16",
                        "32x32": "https://www.gravatar.com/avatar/aa221d7eb30a38ed5acdf06481decc35?d=mm&s=32"
                    },
                    "displayName": "Naval Sharma",
                    "active": True,
                    "timeZone": "UTC"
                },
                "components": [],
                "customfield_13200": None,
                "subtasks": [],
                "reporter": {
                    "self": "https://jira.sample-project.com/rest/api/2/user?username=user%40xyzadvisors.com",
                    "name": "user@xyzadvisors.com",
                    "key": "JIRAUSER14173",
                    "emailAddress": "user@xyzadvisors.com",
                    "avatarUrls": {
                        "48x48": "https://jira.sample-project.com/secure/useravatar?avatarId=10349",
                        "24x24": "https://jira.sample-project.com/secure/useravatar?size=small&avatarId=10349",
                        "16x16": "https://jira.sample-project.com/secure/useravatar?size=xsmall&avatarId=10349",
                        "32x32": "https://jira.sample-project.com/secure/useravatar?size=medium&avatarId=10349"
                    },
                    "displayName": "Darian Barnett",
                    "active": True,
                    "timeZone": "UTC"
                },
                "progress": {
                    "progress": 0,
                    "total": 0
                },
                "customfield_11809": None,
                "votes": {
                    "self": "https://jira.sample-project.com/rest/api/2/issue/CPQ-1101/votes",
                    "votes": 0,
                    "hasVoted": False
                },
                "worklog": {
                    "startAt": 0,
                    "maxResults": 20,
                    "total": 0,
                    "worklogs": []
                },
                "customfield_11808": None,
                "issuetype": {
                    "self": "https://jira.sample-project.com/rest/api/2/issuetype/10107",
                    "id": "10107",
                    "description": "Represents a Test Execution",
                    "iconUrl": "https://jira.sample-project.com/download/resources/com.xpandit.plugins.xray/images/test-execution.png",
                    "name": "Test Execution",
                    "subtask": False
                },
                "project": {
                    "self": "https://jira.sample-project.com/rest/api/2/project/12607",
                    "id": "12607",
                    "key": "CPQ",
                    "name": "CPQ- Keystone",
                    "projectTypeKey": "software",
                    "avatarUrls": {
                        "48x48": "https://jira.sample-project.com/secure/projectavatar?avatarId=10324",
                        "24x24": "https://jira.sample-project.com/secure/projectavatar?size=small&avatarId=10324",
                        "16x16": "https://jira.sample-project.com/secure/projectavatar?size=xsmall&avatarId=10324",
                        "32x32": "https://jira.sample-project.com/secure/projectavatar?size=medium&avatarId=10324"
                    }
                },
                "priority": {
                    "self": "https://jira.sample-project.com/rest/api/2/priority/10402",
                    "iconUrl": "https://jira.sample-project.com/images/icons/priorities/medium.svg",
                    "name": "(P3) Medium",
                    "id": "10402"
                },
                "status": {
                    "self": "https://jira.sample-project.com/rest/api/2/status/11909",
                    "description": "",
                    "iconUrl": "https://jira.sample-project.com/images/icons/statuses/generic.png",
                    "name": "Test Passed",
                    "id": "11909",
                    "statusCategory": {
                        "self": "https://jira.sample-project.com/rest/api/2/statuscategory/3",
                        "id": 3,
                        "key": "done",
                        "colorName": "green",
                        "name": "Done"
                    }
                },
                "created": "2021-11-10T21:39:23.961+0000",
                "updated": "2021-11-15T13:35:16.599+0000",
                "creator": {
                    "self": "https://jira.sample-project.com/rest/api/2/user?username=user%40xyzadvisors.com",
                    "name": "user@xyzadvisors.com",
                    "key": "JIRAUSER14173",
                    "emailAddress": "user@xyzadvisors.com",
                    "avatarUrls": {
                        "48x48": "https://jira.sample-project.com/secure/useravatar?avatarId=10349",
                        "24x24": "https://jira.sample-project.com/secure/useravatar?size=small&avatarId=10349",
                        "16x16": "https://jira.sample-project.com/secure/useravatar?size=xsmall&avatarId=10349",
                        "32x32": "https://jira.sample-project.com/secure/useravatar?size=medium&avatarId=10349"
                    },
                    "displayName": "Darian Barnett",
                    "active": True,
                    "timeZone": "UTC"
                }
            }
        }
        requiredTestDetails = extract.getTestData(testDetails, "346932", "PASSED")
        self.assertIsNotNone(requiredTestDetails)
        self.assertEqual(requiredTestDetails.get("test_id"), 296549)
        self.assertEqual(requiredTestDetails.get("parent_issue_id"), 346932)
        self.assertEqual(requiredTestDetails.get("status_in_parent"), "PASSED")
        self.assertEqual(requiredTestDetails.get("test_key"), "CPQ-1101")
        self.assertEqual(requiredTestDetails.get("assignee_account_id"), "JIRAUSER14590")
        self.assertEqual(requiredTestDetails.get("status_category_id"), 3)
        self.assertEqual(requiredTestDetails.get("test_status"), "Test Passed")
        self.assertEqual(requiredTestDetails.get("priority_name"), "(P3) Medium")
        self.assertEqual(requiredTestDetails.get("reporter_account_id"), "JIRAUSER14173")
        self.assertEqual(requiredTestDetails.get("updated"), "2021-11-15 13:35:16")
        self.assertEqual(requiredTestDetails.get("created"), "2021-11-10 21:39:23")


    def test_getLinkedIssues(self):
        extract = Extract()
        issueDetails = {
            "expand": "renderedFields,names,schema,operations,editmeta,changelog,versionedRepresentations",
            "id": "346932",
            "self": "https://jira.sample-project.com/rest/api/2/issue/346932",
            "key": "CPQ-1910",
            "fields": {
                "issuelinks": [
                    {
                        "id": "300870",
                        "self": "https://jira.sample-project.com/rest/api/2/issueLink/300870",
                        "type": {
                            "id": "10301",
                            "name": "Defect",
                            "inward": "created by",
                            "outward": "created",
                            "self": "https://jira.sample-project.com/rest/api/2/issueLinkType/10301"
                        },
                        "inwardIssue": {
                            "id": "255129",
                            "key": "CPQ-626",
                            "self": "https://jira.sample-project.com/rest/api/2/issue/255129",
                            "fields": {
                                "summary": "As a Service Agent, I need to issue an RMA for a part \"component\" of the asset, rather than the entire product. An RMA still needs to be related to an Asset.",
                                "status": {
                                    "self": "https://jira.sample-project.com/rest/api/2/status/11710",
                                    "description": "",
                                    "iconUrl": "https://jira.sample-project.com/images/icons/statuses/generic.png",
                                    "name": "UAT",
                                    "id": "11710",
                                    "statusCategory": {
                                        "self": "https://jira.sample-project.com/rest/api/2/statuscategory/4",
                                        "id": 4,
                                        "key": "indeterminate",
                                        "colorName": "yellow",
                                        "name": "In Progress"
                                    }
                                },
                                "priority": {
                                    "self": "https://jira.sample-project.com/rest/api/2/priority/10402",
                                    "iconUrl": "https://jira.sample-project.com/images/icons/priorities/medium.svg",
                                    "name": "(P3) Medium",
                                    "id": "10402"
                                },
                                "issuetype": {
                                    "self": "https://jira.sample-project.com/rest/api/2/issuetype/10001",
                                    "id": "10001",
                                    "description": "Created by Jira Software - do not edit or delete. Issue type for a user story.",
                                    "iconUrl": "https://jira.sample-project.com/secure/viewavatar?size=xsmall&avatarId=10315&avatarType=issuetype",
                                    "name": "Story",
                                    "subtask": False
                                }
                            }
                        }
                    },
                    {
                        "id": "301238",
                        "self": "https://jira.sample-project.com/rest/api/2/issueLink/301238",
                        "type": {
                            "id": "10300",
                            "name": "Tests",
                            "inward": "tested by",
                            "outward": "tests",
                            "self": "https://jira.sample-project.com/rest/api/2/issueLinkType/10300"
                        },
                        "inwardIssue": {
                            "id": "347464",
                            "key": "CPQ-1938",
                            "self": "https://jira.sample-project.com/rest/api/2/issue/347464",
                            "fields": {
                                "summary": "Test Contract - Contract Number Field Required",
                                "status": {
                                    "self": "https://jira.sample-project.com/rest/api/2/status/11909",
                                    "description": "",
                                    "iconUrl": "https://jira.sample-project.com/images/icons/statuses/generic.png",
                                    "name": "Test Passed",
                                    "id": "11909",
                                    "statusCategory": {
                                        "self": "https://jira.sample-project.com/rest/api/2/statuscategory/3",
                                        "id": 3,
                                        "key": "done",
                                        "colorName": "green",
                                        "name": "Done"
                                    }
                                },
                                "priority": {
                                    "self": "https://jira.sample-project.com/rest/api/2/priority/10402",
                                    "iconUrl": "https://jira.sample-project.com/images/icons/priorities/medium.svg",
                                    "name": "(P3) Medium",
                                    "id": "10402"
                                },
                                "issuetype": {
                                    "self": "https://jira.sample-project.com/rest/api/2/issuetype/10105",
                                    "id": "10105",
                                    "description": "Represents a Test",
                                    "iconUrl": "https://jira.sample-project.com/download/resources/com.xpandit.plugins.xray/images/test.png",
                                    "name": "Test",
                                    "subtask": False
                                }
                            }
                        }
                    }
                ]
            }
        }
        linkedIssues = extract.getLinkedIssues(issueDetails)
        self.assertEqual(len(linkedIssues), 2)


    def test_getTestKeyToStatusDict(self):
        extract = Extract()
        testKeyToStatusDict = extract.getTestKeyToStatusDict("CPQ-1910")
        self.assertEqual(testKeyToStatusDict["CPQ-777"], "FAIL")
        self.assertEqual(testKeyToStatusDict["CPQ-1938"], "PASS")

    def test_getStatusFromTest(self):
        extract = Extract()
        test = {
            "issueId": 258139,
            "key": "CPQ-777",
            "userColumns": {
                "summary": "<p>\n                <a class=\"issue-link\" data-issue-key=\"CPQ-777\" href=\"/browse/CPQ-777\">CLONE - Test As a Service Agent, I need to issue an RMA for a part &quot;component&quot; of the asset, rather than the entire product. An RMA still needs to be related to an Asset.</a>\n    </p>\n",
                "issuekey": "\n\n    <a class=\"issue-link\" data-issue-key=\"CPQ-777\" href=\"/browse/CPQ-777\">CPQ-777</a>\n",
                "priority": "            <img src=\"https://jira.sample-project.com/images/icons/priorities/medium.svg\" height=\"16\" width=\"16\" border=\"0\" align=\"absmiddle\" alt=\"(P3) Medium\" title=\"(P3) Medium - \">\n    ",
                "resolution": "    <em>Unresolved</em>\n",
                "status": "\n                <span class=\" jira-issue-status-lozenge aui-lozenge jira-issue-status-lozenge-blue-gray jira-issue-status-lozenge-new aui-lozenge-subtle jira-issue-status-lozenge-max-width-medium\" data-tooltip=\"&lt;span class=&quot;jira-issue-status-tooltip-title&quot;&gt;Retest&lt;/span&gt;\">Retest</span>    "
            },
            "hasTestRuns": True,
            "isNotApplicable": False,
            "status": {
                "status": "FAIL",
                "statusColor": "#D45D52",
                "statusTitle": "The test run/iteration has failed"
            }
        }
        testStatus = extract.getStatusFromTest(test)
        self.assertEqual(testStatus, "FAIL")



    def test_extract(self):
        extract = Extract()

        mockGetAllIssueKeys = MagicMock()
        mockGetAllIssueKeys.return_value = ['CPQ-1910', 'CPQ-1093']

        mockGetAllTestData = MagicMock()
        mockGetAllTestData.return_value = [{
            "test_id": None,
            "test_key": None,
            "assignee_account_id": None,
            "created": None,
            "updated": None,
            "status_category_id": None,
            "test_status": None,
            "priority_name": None,
            "reporter_account_id": None
        },
        {
            "test_id": None,
            "test_key": None,
            "assignee_account_id": None,
            "created": None,
            "updated": None,
            "status_category_id": None,
            "test_status": None,
            "priority_name": None,
            "reporter_account_id": None
        }]

        extract.getAllIssueKeys = mockGetAllIssueKeys

        extract.getAllTestData = mockGetAllTestData

        result = extract.extract()

        self.assertEqual(len(result), 4)

    def test_getAllTestData(self):
        extract = Extract()

        mockGetIssueDetails = MagicMock()
        mockGetIssueDetails.return_value = {
            "id": "1234"
        }
        extract.getIssueDetails = mockGetIssueDetails

        mockGetTestKeysDict = MagicMock()
        mockGetTestKeysDict.return_value = {
            "CPQ-1938": "PASS",
            "CPQ-777": "FAIL"
        }       
        extract.getTestKeyToStatusDict = mockGetTestKeysDict

        mockGetTestData = MagicMock()
        mockGetTestData.return_value = {
                "test_id": "1234",
                "parent_issue_id": "1234",
                "test_key": None,
                "assignee_account_id": None,
                "created": None,
                "updated": None,
                "status_category_id": None,
                "test_status": None,
                "priority_name": None,
                "reporter_account_id": None
            }
        extract.getTestData = mockGetTestData


        allTestData = extract.getAllTestData("CPQ-1910")

        self.assertEqual(len(allTestData), 2)

    def test_getTestDataWithReqFields(self):
        extract = Extract()

        parentId = 766

        testDetails = {
            "id": "1234"
        }
        mockGetUniqueTestId = MagicMock()
        mockGetUniqueTestId.return_value = "699"
        extract.getUniqueTestId = mockGetUniqueTestId

        testDataWithReqFields = extract.getTestDataWithReqFields(testDetails, parentId)

        self.assertEqual(testDataWithReqFields["test_id"], 1234)
        self.assertEqual(testDataWithReqFields["parent_issue_id"], parentId)

        self.assertIsNone(testDataWithReqFields["test_key"])
        self.assertIsNone(testDataWithReqFields["assignee_account_id"])
        self.assertIsNone(testDataWithReqFields["status_category_id"])
        self.assertIsNone(testDataWithReqFields["test_status"])
        self.assertIsNone(testDataWithReqFields["priority_name"])
        self.assertIsNone(testDataWithReqFields["reporter_account_id"])

    
    def test_getTestDataWithReqFields_when_None_should_be_returned(self):
        extract = Extract()
        testDetails = {
            "work": "good"
        }
        testDataWithReqFields = extract.getTestDataWithReqFields(testDetails, "1234")
        self.assertIsNone(testDataWithReqFields)

        testDetails = {
            "id": "1234"
        }
        testDataWithReqFields = extract.getTestDataWithReqFields(testDetails, None)
        self.assertIsNone(testDataWithReqFields)




if __name__ == '__main__':
    unittest.main()