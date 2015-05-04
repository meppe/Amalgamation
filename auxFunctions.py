import math
import os, sys, time, subprocess, threading, shlex
def toLPName(caslName,elemType):

    # This is just a dirty quickfix to use (infix) plus and minus operators. 
    if caslName == "__+__" or caslName == "+":
       caslName =  "plus"
    if caslName == "__-__" or caslName == "-":
        caslName = "minus"

    caslName = elemType + "_"+caslName

    return caslName

def lpToCaslStr(lpName):
    uScorePos = lpName.find("_")
    if uScorePos == -1:
        print "Error, lpname invalid"
        exit(1)
    return lpName[uScorePos+1:]

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

# def getCombinedCost(c1,c2):
#     ic1 = int(c1)
#     ic2 = int(c2)
#     return int(max(ic1,ic2) **2 + min(ic1,ic2))

