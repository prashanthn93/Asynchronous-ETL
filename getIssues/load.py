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

        if data.empty:
            return "loaded nothing"
        else:
            data.to_sql(name = self.dbTable, con= self.engine,method="multi", if_exists="append", index=False)
    
        # dataRows = len(data)
        # for i in range(dataRows):
        #     upsertSQL = text(
        #         "INSERT IGNORE INTO master_issue (fix_version, issue_id, issue_key, issue_type_id, project_id, sprint_id, status_id, status_category, epic_name, story_point, assignee_account_id, creator_account_id, reporter_account_id, summary, description, time_estimate, time_original_estimate, aggregate_time_estimate, aggregate_time_original_estimate, time_spent, aggregate_time_spent, work_ratio, created, updated, status_category_change_date, start_date, change_start_date, change_completion_date, due_date, priority_name, epic_name_text) VALUES (:fix_version, :issue_id, :issue_key, :issue_type_id, :project_id, :sprint_id, :status_id, :status_category, :epic_name, :story_point, :assignee_account_id, :creator_account_id, :reporter_account_id, :summary, :description, :time_estimate, :time_original_estimate, :aggregate_time_estimate, :aggregate_time_original_estimate, :time_spent, :aggregate_time_spent, :work_ratio, :created, :updated, :status_category_change_date, :start_date, :change_start_date, :change_completion_date, :due_date, :priority_name, :epic_name_text);")
        #     self.engine.execute(upsertSQL,
        #     fix_version = data.loc[i,'fix_version'],
        #     issue_id = data.loc[i,'issue_id'], 
        #     issue_key = data.loc[i,'issue_key'], 
        #     issue_type_id = data.loc[i,'issue_type_id'], 
        #     project_id = data.loc[i,'project_id'], 
        #     sprint_id = data.loc[i,'sprint_id'], 
        #     status_id = data.loc[i,'status_id'], 
        #     status_category = data.loc[i,'status_category'], 
        #     epic_name = data.loc[i,'epic_name'], 
        #     story_point = data.loc[i,'story_point'], 
        #     assignee_account_id = data.loc[i,'assignee_account_id'], 
        #     creator_account_id = data.loc[i,'creator_account_id'], 
        #     reporter_account_id = data.loc[i,'reporter_account_id'], 
        #     summary = data.loc[i,'summary'], 
        #     description = data.loc[i,'description'], 
        #     time_estimate = data.loc[i,'time_estimate'], 
        #     time_original_estimate = data.loc[i,'time_original_estimate'], 
        #     aggregate_time_estimate = data.loc[i,'aggregate_time_estimate'], 
        #     aggregate_time_original_estimate = data.loc[i,'aggregate_time_original_estimate'], 
        #     time_spent = data.loc[i,'time_spent'], 
        #     aggregate_time_spent = data.loc[i,'aggregate_time_spent'], 
        #     work_ratio = data.loc[i,'work_ratio'], 
        #     created = data.loc[i,'created'], 
        #     updated = data.loc[i,'updated'], 
        #     status_category_change_date = data.loc[i,'status_category_change_date'], 
        #     start_date = data.loc[i,'start_date'], 
        #     change_start_date = data.loc[i,'change_start_date'], 
        #     change_completion_date = data.loc[i,'change_completion_date'], 
        #     due_date = data.loc[i,'due_date'], 
        #     priority_name = data.loc[i,'priority_name'],
        #     epic_name_text = data.loc[i,'epic_name_text']
        # )
        return "success"