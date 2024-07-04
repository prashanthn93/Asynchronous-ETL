import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Float, Text, DateTime, TIMESTAMP, String
from config import Config
from selectedProjects import SelectedProjects

class Load(SelectedProjects):

    def __init__(self, selectedProjects, dbTable):
        super().__init__(selectedProjects, dbTable)


    def load(self, data):
        self.deleteSelectedProjectRows()
        #Bulk Load
        if data.empty:
            return "loaded nothing"
        else:
            data.to_sql(name = self.dbTable, con= self.engine,method="multi", if_exists="append", index=False)

        
        # dataRows = len(data)
        # for i in range(dataRows):
        #     upsertSQL = text(
        #         "INSERT IGNORE INTO master_change_log (change_id, issue_id, change_author_account_id, change_created, change_item_key, change_item_field, change_item_field_type, change_item_field_id, change_item_from, change_item_from_string, change_item_to, change_item_to_string) VALUES (:change_id, :issue_id, :change_author_account_id, :change_created, :change_item_key, :change_item_field, :change_item_field_type, :change_item_field_id, :change_item_from, :change_item_from_string, :change_item_to, :change_item_to_string);")
        #     self.engine.execute(upsertSQL,
        #     change_id = data.loc[i,'change_id'],
        #     issue_id = data.loc[i,'issue_id'], 
        #     change_author_account_id = data.loc[i,'change_author_account_id'], 
        #     change_created = data.loc[i,'change_created'], 
        #     change_item_key = data.loc[i,'change_item_key'], 
        #     change_item_field = data.loc[i,'change_item_field'], 
        #     change_item_field_type = data.loc[i,'change_item_field_type'], 
        #     change_item_field_id = data.loc[i,'change_item_field_id'], 
        #     change_item_from = data.loc[i,'change_item_from'], 
        #     change_item_from_string = data.loc[i,'change_item_from_string'], 
        #     change_item_to = data.loc[i,'change_item_to'], 
        #     change_item_to_string  = data.loc[i,'change_item_to_string']
        # )
        return "success"
