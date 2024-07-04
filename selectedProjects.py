from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from logger import LogManager
from utility import formatter

class SelectedProjects:

  def __init__(self, projectsToUpdate, dbTable):
    self.log = LogManager()
    #projects to update
    self.projectsToUpdate = projectsToUpdate
    self.dbUri = Config.dbUri
    self.dbName = Config.dbName
    self.dbTable = dbTable
    self.dbUri = self.dbUri + "/" + self.dbName
    self.engine = create_engine(self.dbUri, echo=False)

  def deleteSelectedProjectRows(self):
    projectsIdTuple = self.getProjectIdTuple()
    if self.dbTable == Config.dbTableMasterTest:
      deleteSQL = f"""
      DELETE FROM {self.dbTable} WHERE parent_issue_id IN (
          SELECT issuesId FROM (
            SELECT DISTINCT TESTS.parent_issue_id AS issuesId FROM  {self.dbTable} as TESTS
              INNER JOIN master_issue as ISSUES
              ON TESTS.parent_issue_id = ISSUES.issue_id
          WHERE ISSUES.project_id in {projectsIdTuple}
          ) AS c
      )
      """
    elif self.dbTable == Config.dbTableMasterChangeLog:
      deleteSQL = f"""
      DELETE FROM {self.dbTable} WHERE issue_id IN (
		    SELECT issuesId FROM (
			    SELECT DISTINCT LOGS.issue_id AS issuesId FROM {self.dbTable} as LOGS
			      INNER JOIN master_issue as ISSUES
			      ON LOGS.issue_id = ISSUES.issue_id
          WHERE ISSUES.project_id in {projectsIdTuple}
		    ) AS c
      )
      """

    else:
      deleteSQL = f"DELETE FROM {self.dbTable} WHERE project_id IN {projectsIdTuple}"
    print(deleteSQL)
    self.log.SQLQuery(deleteSQL)
    deletedRows = self.engine.execute(text(deleteSQL))
    self.log.SQLQuery(deleteSQL, deletedRows.rowcount)
    print("the rows which were deleted number: ", deletedRows.rowcount)


  def getProjectIdTuple(self):
    projectIds = self.getProjectIds()
    projectsTuple = formatter.getNumberTuple(projectIds)
    return projectsTuple

  def getProjectList(self):
    projects = self.projectsToUpdate
    if not projects:
      raise Exception("No projects selected.")
    else: 
      return projects

  def getProjectIds(self):
    projectList = self.getProjectList()
    projectsTuple = formatter.getStringTuple(projectList)
    selectProjectIdsSQL = "select project_id FROM master_project where project_key in {project_keys}".format(project_keys = projectsTuple)
    sql = text(selectProjectIdsSQL)
    dbRows = self.engine.execute(sql)
    projectIds = []
    for row in dbRows:
      projectIds.append(row[0])
    return projectIds
