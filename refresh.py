import imp
import getUserAccounts
import getIssueTypes
import getBoards
import getSprints
import getStatus 
import getStatusCategory
import getIssues
import getTests
import getChangeLog
import getFixVersions
import dbCode
import logging
from functools import wraps
from time import time
from logger import LogManager
from utility import logUtils
from utility.timer import logtime

class RefreshDatabase:

    def __init__(self):
        self.log = LogManager()

    @logtime
    def all(self, selectedProjects):
        self.run(getUserAccounts, None )#does not have project_id
        self.run(getIssueTypes, None )

        self.run(getBoards, None )
        self.run(getStatus, None )
        self.run(getStatusCategory, None )

        self.run(getFixVersions, selectedProjects )#has project_id, done
        self.run(getIssues, selectedProjects )#has project, done
        self.run(getSprints, None ) 
        self.run(getChangeLog, selectedProjects )
        self.run(getTests, selectedProjects )
        #dbCode.main()

    @logtime
    def fastRefresh(self, selectedProjects):
        self.run(getUserAccounts, None )
        self.run(getIssueTypes, None )

        self.run(getBoards, None )
        self.run(getStatus, None )
        self.run(getStatusCategory, None )

        self.run(getFixVersions, selectedProjects )
        # self.run(getIssues, selectedProjects )
        self.run(getSprints, None )
        # self.run(getTests, selectedProjects )
        # self.run(getChangeLog, selectedProjects )
        dbCode.main()
    
    def issues(self, selectedProjects):
        getIssues.main(selectedProjects)

    def run(self, moduleName, selectedProjects =None):

        start = time()
        if selectedProjects is None:
            moduleName.main()
        else:
            moduleName.main(selectedProjects)
        elapsed = time() - start

        logMessage =  logUtils.getTimeTakenMessage(elapsed,  moduleName.__name__)

        self.log.timeTaken(logMessage)


