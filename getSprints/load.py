import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableMasterSprint
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
              "INSERT IGNORE INTO master_sprint (sprint_id, sprint_state, sprint_name, sprint_start_date, sprint_end_date, sprint_complete_date, board_id) VALUES (:id, :state, :name, :start_date, :end_date, :complete_date, :board_id);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'sprint_id'],
          state = data.loc[i,'sprint_state'],
          name = data.loc[i,'sprint_name'],
          start_date = data.loc[i,'sprint_start_date'],
          end_date = data.loc[i,'sprint_end_date'],
          complete_date = data.loc[i,'sprint_complete_date'],
          board_id = data.loc[i,'board_id']
        )
        return "success"
