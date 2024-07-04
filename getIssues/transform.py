import pandas as pd
import numpy as np
import json
import re
from utility.dateTimeUtils import convertDateTime
from multiprocessing import Pool
import math

class Transform:

    def __init__(self):
        super().__init__()
        self.stringLimit = 500

    def serializeFixVersions(self, fixVersions):
        
        serializedFixVersions = ""
        for fixVersion in fixVersions:
            if serializedFixVersions != "":
                serializedFixVersions += "," + fixVersion["id"]
            else:
                serializedFixVersions =  fixVersion["id"]
        return serializedFixVersions

    def truncateString(self, longString):
        strLimit = self.stringLimit

        shortString = None
        if longString:
            shortString = longString[:strLimit]
        return shortString


    def getFixVersions(self, fixVersions):
        if not fixVersions or len(fixVersions) == 0:
            return ""
        elif len(fixVersions) == 1:
            return fixVersions[0]['id']
        else:
            return self.serializeFixVersions(fixVersions)



    def createMasterDF(self, issueList):
        maxRows = len(issueList)
        dataDF = pd.DataFrame(columns=(
            'issue_id',
            'issue_key',
            'issue_type_id',  # check for null
            'project_id',  # check for null
            'sprint_id',  # customfield 10020; check for null
            'status_id',  # check for null
            'status_category',  # check for null
            'epic_name',  # customfield_10014
            'story_point',  # customfiele 10104

            'assignee_account_id',  # check for null
            'creator_account_id',  # check for null
            'reporter_account_id',  # check for null

            'summary',
            'description',

            'fix_version',

            'time_estimate',
            'time_original_estimate',
            'aggregate_time_estimate',
            'aggregate_time_original_estimate',
            'time_spent',
            'aggregate_time_spent',
            'work_ratio',

            'created',
            'updated',
            'status_category_change_date',
            'start_date',  # customfield_10015
            'change_start_date',  # customfield_10008
            'change_completion_date',  # customfield_10009
            'due_date',

            'priority_name',  # check for null,
            'epic_name_text'

        ))

        for i in range(maxRows):

            if 'customfield_10004' in issueList[i]['fields']:
                if(issueList[i]['fields']['customfield_10004']):
                    sprint_details = issueList[i]['fields']['customfield_10004'][0]
                    sprint_details = sprint_details[1:len(sprint_details)-1].split(",")
                    sprint_id = sprint_details[0].split("[")[1].split('=')[1]
                else:
                    sprint_id= None
            else:
                sprint_id = None

            story_point_key = 'customfield_10104'

            if('customfield_10011' in issueList[i]['fields'].keys()):
                epic_name_text = issueList[i]['fields']['customfield_10011']
            else:
                epic_name_text = None

            if 'statuscategorychangedate' in issueList[i]['fields']:
                statuscategorychangedate = convertDateTime(issueList[i]['fields']['statuscategorychangedate'])
            else:
                statuscategorychangedate = None
        
            if 'customfield_10015' in issueList[i]['fields']:
                customfield_10015 = convertDateTime(issueList[i]['fields']['customfield_10015'])
            else:
                customfield_10015 = None
            
            if 'customfield_10008' in issueList[i]['fields']:
                customfield_10008 = convertDateTime(issueList[i]['fields']['customfield_10008'])
            else:
                customfield_10008 = None
            
            if 'customfield_10009' in issueList[i]['fields']:
                customfield_10009 = convertDateTime(issueList[i]['fields']['customfield_10009'])
            else:
                customfield_10009 = None


            dataDF.loc[i] = [
                issueList[i]['id'],
                issueList[i]['key'],                
                issueList[i]['fields']['issuetype']['id'] if issueList[i]['fields']['issuetype'] else None,
                issueList[i]['fields']['project']['id'] if issueList[i]['fields']['project'] else None,
                sprint_id,
                issueList[i]['fields']['status']['id'] if issueList[i]['fields']['status'] else None,
                issueList[i]['fields']['status']['statusCategory']['id'] if issueList[i]['fields']['status'] else None,
                issueList[i]['fields']['customfield_10000'],
                issueList[i]['fields']['customfield_10104'] if(story_point_key in issueList[i]['fields']) else None,
                issueList[i]['fields']['assignee']['key'] if issueList[i]['fields']['assignee'] else None,
                issueList[i]['fields']['creator']['key'] if issueList[i]['fields']['creator'] else None,
                issueList[i]['fields']['reporter']['key'] if issueList[i]['fields']['reporter'] else None,
                self.truncateString(issueList[i]['fields']['summary']),
                self.truncateString(issueList[i]['fields']['description']),
                self.getFixVersions(issueList[i]['fields']['fixVersions']),
                issueList[i]['fields']['customfield_10403'],
                issueList[i]['fields']['timeoriginalestimate'],
                issueList[i]['fields']['aggregatetimeestimate'],
                issueList[i]['fields']['aggregatetimeoriginalestimate'],
                issueList[i]['fields']['timespent'],
                issueList[i]['fields']['aggregatetimespent'],
                issueList[i]['fields']['workratio'],
                convertDateTime(issueList[i]['fields']['created']),
                convertDateTime(issueList[i]['fields']['updated']),
                statuscategorychangedate,
                customfield_10015,
                customfield_10008,
                customfield_10009,
                issueList[i]['fields']['duedate'],
                issueList[i]['fields']['priority']['name'] if issueList[i]['fields']['priority'] else None,
                epic_name_text
            ]
        return dataDF

    def transform(self, data):
        original_size= len(data)
        N=20      # Capping the number of Processes at 20
        arg=np.array_split(data, N)  
        p = Pool()
        results = p.map(self.createMasterDF,arg)
        p.close()
        p.join()
        resultDf=pd.concat(results,ignore_index=True)        
        dataDF1 = resultDf.where(pd.notnull(resultDf), None)
        return dataDF1
