import logging
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config

def main():

  dbName = Config.dbName
  dbUser = Config.dbUser
  dbPassword = Config.dbPassword

  projectPath = Config.projectPath
  
  dbUri = 'mysql://' + dbUser + ':' + dbPassword + '@localhost/' + dbName
  engine = create_engine(dbUri, echo=False)

  # Open and read the file as a single buffer
  fd1 = open(projectPath + '/dbCode/0_calendar_table_creation.sql', 'r')
  fd3 = open(projectPath + '/dbCode/1_Build_Refresh.sql', 'r')
  fd4 = open(projectPath + '/dbCode/1_Requirement_Refresh.sql', 'r')
  # fd5 = open(projectPath + '/dbCode/1_Build_Noncompliance.sql', 'r')
  # fd6 = open(projectPath + '/dbCode/2_Requirement_Noncompliance.sql', 'r')
  # fd7 = open(projectPath + '/dbCode/3_Test_Noncompliance.sql', 'r')
  # fd8 = open(projectPath + '/dbCode/4_Test_dashboards.sql', 'r')
  # fd9 = open(projectPath + '/dbCode/4_Project_Summary.sql', 'r')
  # fd10 = open(projectPath + '/dbCode/10_maintenance.sql', 'r')


  sqlFile1 = fd1.read()
  sqlFile3 = fd3.read()
  sqlFile4 = fd4.read()
  # sqlFile5 = fd5.read()
  # sqlFile6 = fd6.read()
  # sqlFile7 = fd7.read()
  # sqlFile8 = fd8.read()
  # sqlFile9 = fd9.read()
  # sqlFile10 = fd10.read()

  fd1.close()
  fd3.close()
  fd4.close()
  # fd5.close()
  # fd6.close()
  # fd7.close()
  # fd8.close()
  # fd9.close()
  # fd10.close()

  # all SQL commands (split on ';')
  sqlCommands1 = sqlFile1.split(';')[:-1]
  sqlCommands3 = sqlFile3.split(';')[:-1]
  sqlCommands4 = sqlFile4.split(';')[:-1]
  # sqlCommands5 = sqlFile5.split(';')[:-1]
  # sqlCommands6 = sqlFile6.split(';')[:-1]
  # sqlCommands7 = sqlFile7.split(';')[:-1]
  # sqlCommands8 = sqlFile8.split(';')[:-1]
  # sqlCommands9 = sqlFile9.split(';')[:-1]
  # sqlCommands10 = sqlFile10.split(';')[:-1]

  # Execute every command from the input file
  for command in sqlCommands1:
    engine.execute(command)
  
  for command in sqlCommands3:
    engine.execute(command)

  for command in sqlCommands4:
    engine.execute(command)

  # for command in sqlCommands5:
  #   engine.execute(command)

  # for command in sqlCommands6:
  #   engine.execute(command)

  # for command in sqlCommands7:
  #   engine.execute(command)

  # for command in sqlCommands8:
  #   engine.execute(command)

  # for command in sqlCommands9:
  #   engine.execute(command)

  # for command in sqlCommands10:
  #   engine.execute(command)