import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableIssueType
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
              "INSERT IGNORE INTO master_issue_type (issue_type_id, issue_type_desc, issue_type_name) VALUES (:id, :desc, :name);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'issue_type_id'],
          desc = data.loc[i,'issue_type_desc'],
          name = data.loc[i,'issue_type_name']
        )
        return "success"
