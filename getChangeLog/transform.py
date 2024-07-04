import pandas as pd
import numpy as np
from utility.dateTimeUtils import convertDateTime
from logger import LogManager
from utility.logUtils import printObject
from multiprocessing import Process 
from multiprocessing import Pool
import math

class Transform:

    def __init__(self):
        super().__init__()
        self.stringLimit = 300
        self.log = LogManager()
        self.dataDF = pd.DataFrame(columns=(
            'change_id',
            'issue_id',
            'change_author_account_id',
            'change_created',

            'change_item_key',

            'change_item_field',
            'change_item_field_type',
            'change_item_field_id',
            'change_item_from',
            'change_item_from_string',
            'change_item_to',
            'change_item_to_string'
        ))


    def truncateString(self, longString):
        strLimit = self.stringLimit

        shortString = None
        if longString:
            shortString = longString[:strLimit]
        return shortString

    def insertIssueEntries(self, issue,df):
        dFStartIndex =  len(df.index)

        entryCount = len(issue['item']['items'])


        change_id = issue['item']['id']
        issue_id = issue['key']
        change_author_account_id = issue['item']['author']['accountId']
        change_created = convertDateTime(issue['item']['created'])

        subItems = issue['item']['items']

        if entryCount > 6:
            print("the number of entries is above 6 in this issue : ", change_id)
            print(" the entry count is : ", entryCount)

        for indx, subItem in enumerate(subItems):
            change_item_to_string = self.truncateString( subItem.get('toString') )
            change_item_from_string = self.truncateString( subItem.get('fromString') )
            change_item_field = self.truncateString( subItem.get('field') )
            change_item_from = self.truncateString( subItem.get('from') )
            change_item_to = self.truncateString( subItem.get('to') )

            df.loc[ dFStartIndex + indx] = [
                change_id,
                issue_id,
                change_author_account_id,
                change_created,

                2,

                change_item_field, 
                subItem.get('fieldtype'),
                subItem.get('fieldId'),
                change_item_from,
                change_item_from_string,
                change_item_to,
                change_item_to_string
            ]

    def createMasterDF(self, arg):
        issueList=arg[0]
        df=arg[1]
        entriesCount = 0
        for issue in issueList:
            issueChanges = len(issue['item']['items'])
            entriesCount = entriesCount + issueChanges
        entryCount = entriesCount

        for issue in issueList:
            self.insertIssueEntries(issue,df)

        return df


    def transform(self, data):
        original_size= len(data)
        self.log.logMessage("the total number of issues passed to transform are: " + str(original_size))

        N=20      # Capping the number of Processes at 20
        d=np.array_split(data, N)
        arg=[[d[i],self.dataDF] for i in range(len(d))]  
        p = Pool()
        results = p.map(self.createMasterDF,arg)
        p.close()
        p.join()
        resultDf=pd.concat(results,ignore_index=True)        
        dataDF1 = resultDf.where(pd.notnull(resultDf), None)
        dataDF1.drop_duplicates(keep='last',inplace=True)
        return dataDF1

