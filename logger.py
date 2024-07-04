import logging
import inspect
from utility import logUtils
from config import Config

class LogManager:

    def __init__(self):
        self.logLevel = Config.logLevel 
        self.extraction = "extraction"   
        self.transformation = "transformation"  
        self.load = "Load"  

        self.started = "Started"
        self.completed = "Completed"
    
    def setLogger(self):
        path = logUtils.getLogFilePath(Config.logFolderPath, "AutoLog")
        FORMAT = '%(asctime)s %(levelname)s:%(message)s'
        logging.basicConfig(filename=path, filemode='a', format=FORMAT, level=Config.logLevel)
    
    def getModuleName(self):
        frm = inspect.stack()[2]
        mod = inspect.getmodule(frm[0])        
        return mod.__name__

    def SQLQuery(self, sqlQuery, rowsAffected = None):
        if rowsAffected is None:
            logging.debug("executing sql command: " + sqlQuery)
        else:
            logging.debug("executed sql command: " + sqlQuery + "\n" + "number of rows affected are: "+ str(rowsAffected))


    def logDataObject(self, data, dataDesc):
        moduleName = self.getModuleName()
        jsonObject = logUtils.getJsonFormatted(data)
        logging.debug("the number of rows of the extracted data is: " + str(len(jsonObject)))
        logging.debug("the "+ dataDesc +" data from " + moduleName + " is: " + jsonObject)

    def logDataframe(self, dataFrame, dataDesc):
        moduleName = self.getModuleName()
        dataFrameFormatted = logUtils.getDataframeFormatted(dataFrame)
        rowCount = dataFrame.shape[0]
        logging.debug("the number of the extracted data is: " + str(rowCount))
        logging.debug("the "+ dataDesc +" data from " + moduleName + " is: \n" + dataFrameFormatted)


    def logApiCalls(self, url):
        logging.debug("api was called " + url)

    def logStatus(self, message):
        moduleName = self.getModuleName()
        logging.debug(moduleName+ " " + message)

    def timeTaken(self, message):
        logging.info(message)

    def logMessage(self, message):
        logging.debug(message)

    def logStage(self, message):
        logging.info(message)

    def badCondtion(self, message):
        logging.critical(message)

    def mark(self, status):
        logging.info("------------------------" + status + "--------------------------------")


