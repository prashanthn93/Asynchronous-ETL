import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config


class Load:

    def __init__(self):
        super().__init__()
        self.dbUri = Config.dbUri
        self.dbName = Config.dbName
        self.dbTable = Config.dbTableUserAccounts
        self.dbUri = self.dbUri + "/" + self.dbName
        self.engine = create_engine(self.dbUri, echo=False)

    def truncate(self):
        sql = text(f'TRUNCATE TABLE {self.dbName}.{self.dbTable}')
        self.engine.execute(sql)

    def load(self, data):
        self.truncate()
        dataRows = len(data)
        for i in range(dataRows):
            upsertSQL = text("INSERT IGNORE INTO master_user_account (account_id, account_type, display_name, active) VALUES (:id, :type, :name, :active);")
            insertRow = self.engine.execute(upsertSQL,
            id = data.loc[i,'account_id'],
            type = data.loc[i,'account_type'],
            name = data.loc[i,'display_name'],
            active = data.loc[i,'active']
            )
        return "success"
