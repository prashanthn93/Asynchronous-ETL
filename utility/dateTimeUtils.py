from datetime import datetime

def convertDateTime(date_var):
  if(date_var == "" or date_var is None):
    return ""
  else:
    date_split = date_var.split('T')
    date = date_split[0]
    time = date_split[1].split('.')[0]
    datetime_new = date + " " + time
    return datetime.strptime(datetime_new,'%Y-%m-%d %H:%M:%S')

    
def convertDate(date_var):
  if(date_var == "" or date_var is None):
    return ""
  else:
    return datetime.strptime(date_var,'%Y-%m-%d')