import math
import os, sys, time, subprocess, threading, shlex

def substitute_infix_ops(input):
    if input.find("__+__") >= 0:
        return input.replace("__+__", "plus")
    if input.find("+") >= 0:
        return input.replace("+", "plus")
    if input.find("__-__") >= 0:
        return input.replace("__-__", "minus")
    if input.find("-") >= 0:
        return input.replace("-", "minus")
    if input.find("__*__") >= 0:
        return input.replace("__*__", "multi")
    if input.find("*") >= 0:
        return input.replace("*", "multi")
    if input.find("__\__") >= 0:
        return input.replace("__\__", "div")
    if input.find("\\") >= 0:
        return input.replace("\\", "div")
    
    return input        

def toLPName(caslName,elemType):
    caslName = substitute_infix_ops(caslName)
    caslName = elemType + "_"+caslName

    return caslName

def lpToCaslStr(lpName):
    allowedPrefixes = ["po_","sort_","spec_"]
    
    for prefix in allowedPrefixes:
        if lpName.find(prefix) == 0:
            return lpName[len(prefix):]
     
    print "Error, lpname invalid: " + lpName
    exit(1)

class Command(object):
    """
    Enables to run subprocess commands in a different thread with TIMEOUT option.

    Based on jcollado's solution:
    http://stackoverflow.com/questions/1191374/subprocess-with-timeout/4825933#4825933
    """
    command = None
    process = None
    status = None
    output, error = '', ''

    def __init__(self, command):
        if isinstance(command, basestring):
            command = shlex.split(command)
        self.command = command

    def run(self, timeout=None, **kwargs):
        """ Run a command then return: (status, output, error). """
        def target(**kwargs):
            try:
                self.process = subprocess.Popen(self.command, **kwargs)
                # print self.command
                self.output, self.error = self.process.communicate()
                self.status = self.process.returncode
            except:
                self.error = traceback.format_exc()
                self.status = -1
        # default stdout and stderr
        if 'stdout' not in kwargs:
            kwargs['stdout'] = subprocess.PIPE
        if 'stderr' not in kwargs:
            kwargs['stderr'] = subprocess.PIPE
        # thread
        thread = threading.Thread(target=target, kwargs=kwargs)
        thread.start()
        thread.join(timeout)
        if thread.is_alive():
            self.process.terminate()
            thread.join()
        return self.status, self.output, self.error


def pow(n1,n2):
    return int(math.pow(int(n1),int(n2)))


    
def aggregateSortsInQuanti(axStr):
    # Aggregate variables in quantifications if necessary. E.g. change
    # forall x : Parent2; y : Parent2 . someOp1(someOp8) = someOp8(y, x)
    # to
    # forall x, y : Parent2 . someOp1(someOp8) = someOp8(y, x)
    
    #find varlist and sort pairs
    axStrHead = axStr.split(" .")[0]
    if axStrHead.find("forall") == -1 and axStrHead.find("exists") == -1:
        return axStr

    # print "quantified axiom detected"
    axStrVarsStr = axStrHead[len(axStrHead.split(" ")[0])+1:]
    varListSortPairStrs = axStrVarsStr.split("; ")
    sorts = {}
    for vlspStr in varListSortPairStrs:
        vlStr = vlspStr.split(" :")[0]
        vl = vlStr.split(", ")
        sortName = vlspStr.split(": ")[1]
        if sortName not in sorts.keys():
            sorts[sortName] = []
        sorts[sortName] += vl

    newAxStr = axStr.split(" ")[0] + " "
    for sort in sorted(sorts):  
        for v in sorted(sorts[sort]):
            newAxStr += v + ", "
        newAxStr = newAxStr[:-2]
        newAxStr = newAxStr + " : " + sort
        newAxStr = newAxStr + "; "
    newAxStr = newAxStr[:-2] + " . "
    newAxStr = newAxStr + axStr.split(". ")[1]
    return newAxStr


# def getCombinedCost(c1,c2):
#     ic1 = int(c1)
#     ic2 = int(c2)
#     return int(max(ic1,ic2) **2 + min(ic1,ic2))

