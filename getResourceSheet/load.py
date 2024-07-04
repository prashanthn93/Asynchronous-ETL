import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableResource
        self.dbUri = self.dbUri + "/" + self.dbName
        self.engine = create_engine(self.dbUri, echo=False)

    def truncate(self):
        sql = text(f'TRUNCATE TABLE {self.dbName}.{self.dbTable}')
        self.engine.execute(sql)

    def load(self, data):
        self.truncate()
        dataRows = len(data)
        for i in range(dataRows):
          upsertSQL = text(
              "INSERT IGNORE INTO master_resource (account_id, name, org, role, sprint_name, avail_hours) VALUES (:id, :name,:org, :role, :sprint_name, :avail_hours);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'jira_id'],
          name = data.loc[i,'Name'],
          org = data.loc[i,'Organization'],
          role = data.loc[i,'Role'],
          sprint_name = data.loc[i,'sprint'],
          avail_hours = data.loc[i,'hours']
        )        
        return "success"
