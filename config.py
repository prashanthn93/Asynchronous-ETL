import logging 

class Config:

    projectPath = r"C:\Users\prasas\ETL Backend Codes\backend"
    #

    logFolderPath = "Logs"
    logLevel = logging.INFO    

    isProdMode = True

    #API credentials JIRA
    uName = 'user@org.com'
    password = 'JTukrbn6fOk6hxVENllUBC65'

    #API access smartsheet
    token = 'b0qwafglr7xtmrporam06arpk3'

    #version
    apiAddress = "/rest/api"
    agileAddress = "/rest/agile"
    ravenAddress = "/rest/raven"
    apiVersion = "/2"
    agileVersion = "/1.0"
    ravenVersion = "/1.0"
    smartSheetVersion = "/2.0"


    #Client address
    clientAddress = "xyz-partners.atlassian.net"
    smartsheetAddress = "api.smartsheet.com"

    #Endpoint List
    getProjects = "/project"
    getUserAccounts = "/users/search"
    getIssueTypes = "/issuetype"
    getBoards = "/board"
    getIssueInProjects = "/search?jql="
    getIssues = "/issue"
    getSprint = "/sprint"
    getChangeLog = "/?expand=changelog"
    getStatus = "/status"
    getStatusCategory = "/statuscategory"
    getFixVersions = "/versions"
    getResourceSheet = "/sheets"
    getRequirement = "/requirement"

    testRequirement = "/tests"
    
    #all Issues from Project meta data
    jqlProjectSearch = 'project='

    #db details
    dbUri = 'mysql://root:test@localhost'
    dbName = 'jc_db'
    dbUser = 'root'
    dbPassword = 'test'

    #db tables
    dbTableMasterProject = 'master_project'
    dbTableUserAccounts = 'master_user_account'
    dbTableIssueType = 'master_issue_type'
    dbTableMasterTest = 'master_test'
    dbTableMasterBoard = 'master_board'
    dbTableMasterStatus = 'master_status'
    dbTableMasterStatusCategory = 'master_status_category'
    dbTableMasterIssue = 'master_issue'
    dbTableMasterSprint = 'master_sprint'
    dbTableMasterChangeLog = 'master_change_log'
    dbTableMasterFixVersions = 'master_fix_version'
    dbTableRefreshLog = 'db_refresh_table'
    dbTableResource = 'master_resource'
    
