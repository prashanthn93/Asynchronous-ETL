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
        dataRows = len(data)
        for i in range(dataRows):
          upsertSQL = text(
              "INSERT IGNORE INTO master_fix_version (fix_version_id, fix_version_description, fix_version_name, fix_version_archived, fix_version_released, project_id) VALUES (:id, :description, :name, :archived, :released, :project_id);")
          self.engine.execute(upsertSQL,
          id = data.loc[i,'fix_version_id'],
          description = data.loc[i,'fix_version_description'],
          name = data.loc[i,'fix_version_name'],
          archived = data.loc[i,'fix_version_archived'],
          released = data.loc[i,'fix_version_released'],
          project_id = data.loc[i,'project_id'])
        return "success"
