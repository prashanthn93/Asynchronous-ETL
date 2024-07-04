from logger import LogManager
from functools import wraps
from time import time
import inspect
from .logUtils import printObject, getTimeTakenInMins

def logtime(f):
    @wraps(f)
    def wrapper(*args, **kwds):
        start = time()
        result = f(*args, **kwds)
        elapsed = time() - start

        module_name = f.__module__
        function_name = f.__name__

        elapsedTimeStr = getTimeTakenInMins(elapsed)
        logMessage =  "{module_name}'s {function_name} took {minutes} minutes to complete.".format(module_name = module_name, function_name = function_name, minutes = elapsedTimeStr)

        log = LogManager()
        log.logStage(logMessage)
        return result
    return wrapper
