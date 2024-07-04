import time
import datetime

class DateFormatter:

    def getDateFromDTStamp(self, dateTimeStamp):
        date = None
        if "T" in dateTimeStamp:
            date = dateTimeStamp.split("T")[0]
        elif "Z" in dateTimeStamp:
            date = dateTimeStamp.split("Z")[0]
        return date
    
    def getTimeFromDTStamp(self, dateTimeStamp):
        time = None
        if "T" in dateTimeStamp:
            time = dateTimeStamp.split("T")[1]
        elif "Z" in dateTimeStamp:
            time = dateTimeStamp.split("Z")[1]
        return time[0:8]


    def getFormattedDate(self, dateTimeStamp):
        dateStr = self.getDateFromDTStamp(dateTimeStamp)
        timeStr = self.getTimeFromDTStamp(dateTimeStamp)

        YYYY, MM, DD  = [int(x) for x in dateStr.split("-")]
        hh, mm, ss = [int(x) for x in timeStr.split(":")]

        dateObject = datetime.datetime(YYYY, MM, DD, hh, mm, ss)

        formattedDate = dateObject.strftime('%Y-%m-%d %H:%M:%S')
        return formattedDate