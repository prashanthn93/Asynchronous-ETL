import logging
from sqlalchemy import create_engine, MetaData, text, insert
from datetime import datetime
# import logging

from config import Config
from logger import LogManager
from refresh import RefreshDatabase
from utility.logUtils import getLogFilePath
from logger import LogManager

#getting config
dbUri = Config.dbUri
dbName = Config.dbName
dbTable = Config.dbTableRefreshLog
dbUri = dbUri + "/" + dbName
engine = create_engine(dbUri, echo=False)
loggingLevel = Config.logLevel

log = LogManager()
log.setLogger()


def getUpdate(status):
  sqlSelectUpdate = 'Select * from db_refresh_table where status= ' + "'" +  status + "'"
  requiredUpdates = engine.execute(sqlSelectUpdate)

  if requiredUpdates and requiredUpdates.rowcount >= 1:
    if requiredUpdates.rowcount >= 2:
      log.badCondtion('Warning: More than two updates are ' + status + '. This condition should not happen and may lead crashes!')
    columnValues = requiredUpdates.fetchone()
    fields = requiredUpdates.keys()  
    reqRow = dict(zip(fields, columnValues))  
    return reqRow
  else:
    return False

def getScheduledUpdate():
  ongoingUpdate = getUpdate("Running")

  if ongoingUpdate: 
    return False

  scheduledUpdate = getUpdate("Scheduled")

  return scheduledUpdate

def getSerialNo(db_refresh_tableRow):
  serial_no =  db_refresh_tableRow["serial_no"]
  return str(serial_no)

def setUpdate(status, serialNo):
  sql = """Update db_refresh_table set status = "{status}"
           where serial_no = "{serialNo}" """.format(status = status, serialNo = serialNo)
  log.SQLQuery(sql)
  engine.execute(sql)
  today = datetime.today()
  d1 = str(today.strftime("%a %b %d %Y"))
  d2 = str(today.strftime("%H:%M:%S"))

  sql1 = 'update db_refresh_table set complete_date = "' + d1 + '" where serial_no = ' + serialNo
  sql2 = 'update db_refresh_table set complete_time = "' + d2 + '" where serial_no = ' + serialNo

  engine.execute(sql1)
  engine.execute(sql2)

def deserializeSelectedProjects(projectsStr):
  if not projectsStr: 
    return None
  selectedProjects = projectsStr.split(",")
  return selectedProjects

def main():
  refreshDB = RefreshDatabase()
  scheduledUpdate = getScheduledUpdate()
  #{'serial_no': 3, 'refresh_type': 'Full', 'status': 'Scheduled', 'schdule_time': '17:13:54', 'schdule_date': 'Fri Dec 10 2021', 'complete_date': 'Thu Dec 16 2021', 'complete_time': '17:44:59', 'refresh_projects': 'NITRO,CPQ,MAR,FF,NINT,CRM,CONGA,JIT,FFCOM,ZEN,INTAC,AP,DM,SECSYS'}
  scheduledUpdate = {'serial_no': 3, 'refresh_type': 'Full', 'status': 'Scheduled', 'schdule_time': '17:13:54', 'schdule_date': 'Fri Dec 10 2021', 'complete_date': 'Thu Dec 16 2021', 'complete_time': '17:44:59', 'refresh_projects': 'COMNTY,SALCLD'}
  #getScheduledUpdate()
  #getScheduledUpdate()
  print("scheduledUpdate", scheduledUpdate)
    
  if(scheduledUpdate and bool(scheduledUpdate)):
    serialNo = getSerialNo(scheduledUpdate)
    selectedProjects = deserializeSelectedProjects(scheduledUpdate["refresh_projects"])
    log.mark("Start")
    log.logMessage('Started Update: serial no {serialNo} in db_refresh_table with the selected projects as: {projects}'.format(serialNo = serialNo, projects = selectedProjects) )
    setUpdate("Running", serialNo)
    refreshDB.all(selectedProjects)
    setUpdate("Complete", serialNo)
    log.mark("End")


if __name__ == '__main__':
    main()



