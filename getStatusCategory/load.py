import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableMasterStatusCategory
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
              "INSERT IGNORE INTO master_status_category (status_category_id, status_category_key, status_category_color_name, status_category_name) VALUES (:id, :key, :color_name, :name);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'status_category_id'],
          key = data.loc[i,'status_category_key'],
          color_name = data.loc[i,'status_category_color_name'],
          name = data.loc[i,'status_category_name'])
        return "success"
