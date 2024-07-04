import pandas as pd
import re as re
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from datetime import datetime
import subprocess



#import modules
import getUserAccounts
import getIssueTypes
import getBoards
import getStatus 
import getStatusCategory
import getFixVersions
import getIssues
import getSprints
import getChangeLog
import dbCode


#set logging level
import logging
from datetime import date

#getting config
dbUri = Config.dbUri
dbName = Config.dbName
dbTable = Config.dbTableRefreshLog
dbUri = dbUri + "/" + dbName
engine = create_engine(dbUri, echo=False)


def updateTable():
  today = datetime.today()
  d1 = str(today.strftime("%a %b %d %Y"))
  d2 = str(today.strftime("%H:%M:%S"))

  sqlCreate = 'Insert into db_refresh_table (refresh_type, status, schdule_date, schdule_time) values ("Auto","Scheduled","'+d1+'","'+d2+'")'
  engine.execute(sqlCreate)

  #read table, 1 row at a time
  sqlSerialNo = text(f'Select serial_no from db_refresh_table where (serial_no) in (select min(serial_no) from db_refresh_table where status = "Scheduled")')
  serialNo = re.sub('\W+','',str(engine.execute(sqlSerialNo).fetchall()))

  sql0 = 'update db_refresh_table set status = "Running" where serial_no = '+serialNo
  sql1 = 'update db_refresh_table set complete_date = "' + d1 + '" where serial_no = ' + serialNo
  sql2 = 'update db_refresh_table set complete_time = "' + d2 + '" where serial_no = ' + serialNo

  engine.execute(sql0)
  engine.execute(sql1)
  engine.execute(sql2)
  logging.info('Log Table updated to Run status')


def updateTableComplete():
  sql = 'update db_refresh_table set status = "Completed" where serial_no = ' + serialNo
  engine.execute(sql)
  today = datetime.today()
  d1 = str(today.strftime("%a %b %d %Y"))
  d2 = str(today.strftime("%H:%M:%S"))

  sql1 = 'update db_refresh_table set complete_date = "' + d1 + '" where serial_no = ' + serialNo
  sql2 = 'update db_refresh_table set complete_time = "' + d2 + '" where serial_no = ' + serialNo

  engine.execute(sql1)
  engine.execute(sql2)
  logging.info('Log Table updated to Complete status')


updateTable()

#read table, 1 row at a time
sqlSerialNo = text(f'Select serial_no from db_refresh_table where (serial_no) in (select min(serial_no) from db_refresh_table where status = "Running" and refresh_type = "Auto")')
serialNo = re.sub('\W+','',str(engine.execute(sqlSerialNo).fetchall()))

logging.info('Started updates for task: %s',serialNo)
#executing functions, write wrappers here
getUserAccounts.main()
logging.info('Got User accounts')
getIssueTypes.main()
logging.info('Got Issue Types')
getBoards.main()
logging.info('got Boards')
getStatus.main()
logging.info('got Status')
getStatusCategory.main()
logging.info('got Status Category')
getFixVersions.main()
logging.info('got Fix Versions')
getIssues.main()
logging.info('got All Issues')
getSprints.main()
logging.info('got All Sprints')
getChangeLog.main()
logging.info('got All ChangeLogs')
dbCode.main()
logging.info('Ran dB Codes')

updateTableComplete()