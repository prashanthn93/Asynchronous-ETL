import pandas as pd
from sqlalchemy import create_engine, MetaData, text, insert
from sqlalchemy.types import Integer, Text, DateTime, TIMESTAMP, String
from config import Config
from selectedProjects import SelectedProjects


class Load(SelectedProjects):

    def __init__(self, selectedProjects, dbTable):
        super().__init__(selectedProjects, dbTable)

    def load(self, data):
        self.deleteSelectedProjectRows()
        if data.empty:
            return "loaded nothing"
        else:
            data.to_sql(name = self.dbTable, con= self.engine,method="multi", if_exists="append", index=False)
            
            # dataRows = len(data)
            # for i in range(dataRows):
            #     upsertSQL = text(
            #         "INSERT IGNORE INTO " + self.dbTable + " (test_id,parent_issue_id,status_in_parent,test_key,assignee_account_id,created,updated,status_category_id,test_status,priority_name, reporter_account_id, fix_versions, labels) VALUES (:test_id,:parent_issue_id,:status_in_parent,:test_key,:assignee_account_id, :created, :updated,:status_category_id,:test_status,:priority_name,:reporter_account_id, :fix_versions, :labels);"
            #             )
            #     self.engine.execute(upsertSQL,
            #         test_id = data.loc[i,'test_id'],
            #         parent_issue_id = data.loc[i,'parent_issue_id'],
            #         status_in_parent = data.loc[i,'status_in_parent'],
            #         test_key = data.loc[i,'test_key'],
            #         assignee_account_id = data.loc[i,'assignee_account_id'],
            #         status_category_id = data.loc[i,'status_category_id'],
            #         test_status = data.loc[i,'test_status'],
            #         priority_name = data.loc[i,'priority_name'],
            #         reporter_account_id = data.loc[i,'reporter_account_id'],
            #         updated = data.loc[i,'updated'],
            #         created = data.loc[i,'created'],
            #         fix_versions = data.loc[i,'fix_versions'],
            #         labels = data.loc[i,'labels'],
            #     )
            
        return "success"
