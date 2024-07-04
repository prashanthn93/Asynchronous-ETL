import logging
from .extract import Extract
from .transform import Transform
from .load import Load

"""
Warning: Please RUN this with Caution.
This table contains hardcoded data which may not be regained by refreshing.
"""

def main():

    extract = getExtract()

    cleanData = transformExtract(extract)

    upload = loadExtract(cleanData)


#wrapper function to fetch data
def getExtract():
    extract = Extract()
    extract_json = extract.extract()
    return extract_json

#wrapper to transform data
def transformExtract(extract):
    transform = Transform();
    clean_data = transform.transform(extract)
    return clean_data

#wrapper to load issue
def loadExtract(cleanData):
    load = Load()
    upload_data = load.load(cleanData)
    return upload_data;
