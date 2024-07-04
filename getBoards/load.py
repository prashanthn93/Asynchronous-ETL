import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableMasterBoard
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
              "INSERT IGNORE INTO master_board (board_id, board_name, board_type, board_project_id) VALUES (:id, :name, :type, :project_id);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'board_id'],
          name = data.loc[i,'board_name'],
          type = data.loc[i,'board_type'],
          project_id = data.loc[i,'board_project_id']
        )
        return "success"
