

def getStringTuple(rawList):
    seperatedList = ', '.join(['"{}"'.format(value) for value in rawList])
    return "(" + seperatedList + ")"

def getNumberTuple(rawList):
    seperatedList = ', '.join(['{}'.format(value) for value in rawList])
    return "(" + seperatedList + ")"

