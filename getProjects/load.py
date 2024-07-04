import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableMasterProject
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
              "INSERT IGNORE INTO master_project (project_id, project_key, project_name, project_type_key, project_to_pick) VALUES (:id, :key, :name, :type, :pick);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'project_id'],
          key = data.loc[i,'project_key'],
          name = data.loc[i,'project_name'],
          type = data.loc[i,'project_type_key'],
          pick = data.loc[i,'project_to_pick'])
        return "success"
