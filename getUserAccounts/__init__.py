import logging
from .extract import Extract
from .transform import Transform
from .load import Load
from logger import LogManager
from utility.timer import logtime

def main():

    log = LogManager()
    log.logStatus( 'Begin Extraction')
    extract = getExtract()
    log.logDataObject(extract, log.extraction)
    log.logStatus( 'End Extraction')

    log.logStatus( 'Initializing Transformation')
    cleanData = transformExtract(extract)
    log.logDataframe(cleanData, log.transformation)
    log.logStatus( 'Done Transformation')

    log.logStatus('Initializing Load')
    upload = loadExtract(cleanData)
    log.logStatus(upload)
    log.logStatus('Initializing Done')


#wrapper function to fetch data
@logtime
def getExtract():
    extract = Extract()
    extract_json = extract.extract()
    return extract_json

#wrapper to transform data
@logtime
def transformExtract(extract):
    transform = Transform();
    clean_data = transform.transform(extract)
    return clean_data

#wrapper to load issue
@logtime
def loadExtract(cleanData):
    load = Load()
    upload_data = load.load(cleanData)
    return upload_data;
