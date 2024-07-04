import pandas as pd
import json
import numpy as np


class Transform:
    def __init__(self):
        super().__init__()

    def createCols(self, data):
        maxCols = len(data["columns"])
        dataCols = pd.DataFrame(columns=("id", "title", "index"))
        for i in range(maxCols):
            dataCols.loc[i] = [
                data["columns"][i]["id"],
                data["columns"][i]["title"],
                data["columns"][i]["index"],
            ]
        dataCols = dataCols[["id", "title", "index"]]
        return dataCols

    def createCells(self, data):
        maxRows = len(data["rows"])
        dataCells = pd.DataFrame(columns=("row_id", "row_num", "col_id", "value"))
        for i in range(maxRows):
            maxCells = len(data["rows"][i]["cells"])
            for j in range(maxCells * i, maxCells * (i + 1)):
                index = j - maxCells * i
                value = "value"
                valueValue = ""
                if value in data["rows"][i]["cells"][index]:
                    valueValue = data["rows"][i]["cells"][index]["value"]
                dataCells.loc[j] = [
                    data["rows"][i]["id"],
                    data["rows"][i]["rowNumber"],
                    data["rows"][i]["cells"][index]["columnId"],
                    valueValue,
                ]
        dataCells = dataCells[["row_id", "row_num", "col_id", "value"]]
        return dataCells

    def convert_resource_summary_raw_data(self, cols_meta, cells_value):

        cells_value = cells_value.fillna('')
    
        cells_value['row_num'] = cells_value['row_num'].astype(float)
        
        cells_value['col_id'] = cells_value['col_id'].astype(float)
        cols_meta['id'] = cols_meta['id'].astype(float)
        
        #--- create an empty dataframe using cols_meta ---# 
        
        output_data = pd.DataFrame()
        
        #row_len = len(cols_meta[cols_meta['index'].astype(float) > 4])
        name_id = list(cols_meta.loc[cols_meta['title'] == 'Name', 'id'])[0]
        org_id =  list(cols_meta.loc[cols_meta['title'] == 'Organization', 'id'])[0]
        role_id = list(cols_meta.loc[cols_meta['title'] == 'Role', 'id'])[0]
        jira_id = list(cols_meta.loc[cols_meta['title'] == 'JIRA ID', 'id'])[0]
        project_id = '3389945799829380'
    
        for row_num in np.unique(cells_value['row_num']) : 

            temp = cells_value[cells_value['row_num'] == row_num] 

            
        
            core_values = {'Name' : list(temp.loc[temp['col_id'] == name_id, 'value'])[0], 
                        'Organization' : list(temp.loc[temp['col_id'] == org_id, 'value'])[0],
                        'Role' : list(temp.loc[temp['col_id'] == role_id, 'value'])[0],
                        'JIRA ID' : list(temp.loc[temp['col_id'] == jira_id, 'value'])[0] 
                        }
            core_data = pd.DataFrame().append(core_values, ignore_index = True)


            
            
            
            core_data = core_data[['JIRA ID', 'Name', 'Organization', 'Role']]
            
            int_data = temp.loc[~temp['col_id'].isin([name_id, org_id, role_id, jira_id, project_id]), ['col_id', 'value']]
            
            
            value_data = pd.merge(int_data, cols_meta[['id', 'title']], left_on = 'col_id', right_on = 'id', how = 'left')
            
            value_data = value_data[['title', 'value']]
            value_data.columns = ['sprint', 'hours']
            
            core_data['key'] =1 
            value_data['key'] = 1 
            
            append_data = pd.merge(core_data, value_data, on ='key')
            
            del append_data['key']
            
            output_data = output_data.append(append_data)

        output_data = output_data.rename(columns = {"JIRA ID":"jira_id"})
        

        output_data = output_data[output_data['Organization']!= '']

        output_data = output_data.reset_index(drop = True)

       
        return output_data

    def transform(self, data):
        colsMeta = self.createCols(data)
        cellsValue = self.createCells(data)
        output = self.convert_resource_summary_raw_data(colsMeta, cellsValue)

        return output