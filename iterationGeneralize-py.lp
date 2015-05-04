%%% The main iteration loop or the iterative ASP solving %%%
%%% This is a Logic Programming file called with clingo. The keyword # script (python) is used to tell clingo to call python.

#script (python) 

# First we need to etermine the path we are in.
# Some auxiliary libraries that we need:
import os, sys, time, subprocess

# Set path for additional import files
lp_path = os.path.abspath(os.getcwd())
sys.path.append(lp_path)

# The gringo library contains all important python methods used by clingo.
from gringo import *


# We also want to be able to call the other amalgamation module python scripts.
from settings import *
from langCasl import *
from blendFunctions import *
from auxFunctions import *

print "starting generalisation"

# Global variable required for the blending: the input spaces in the internal data structure represenation. 
inputSpaces = []

# Global variable to store the best blends that ere found so far. 
blends = []

# Global variable to store the max. allowed cost for a blend. 
highestValue = -sys.maxint

# This is called if a model is found.
def onModelGeneralize(model):    
    global inputFile, highestValue, blends
    lpFileName = inputFile.split(".")[0]+".lp"

    print "Found generalisation:"
    modelStr = getModel(model)
    print modelStr
    # return
    [blends,blendingGeneralizationValue] = findLeastGeneralizedBlends(model.atoms(), inputSpaces, highestValue, blends) 
    # print blendingGeneralizationValue  
    if blendingGeneralizationValue >= highestValue and blendingGeneralizationValue > -sys.maxint:
        highestValue = blendingGeneralizationValue
        writeBlends(blends)
        print "Found blend with a better or equal generalization value of  " + str(highestValue) + "."
        # raw_input()

def getModel(model):
    print "%% Generalisation model is as follows : \n"
    mStr = ''
    for a in model.atoms():
        mStr += str(a)+".\n"    
    return mStr


## The function main is called by clingo. It implements the main iteration loop.
def main(prg):
    ## The following are constants coming from the settings.py file
    global minIterationsGeneralize, maxIterationsGeneralize, rmOpAllowed,rmAxAllowed,rmPredAllowed
    
    ## Prepare internal data structure for the later blending. 
    global inputSpaceNames, inputSpaces, inputFile
    
    print "Starting main iteration loop. Reading input spaces."


    inputSpacesXmlFileName = input2Xml(inputFile,inputSpaceNames) 
    inputSpaces = parseXml(inputSpacesXmlFileName)

    ## Some abbreviations to make the code more compact:
    imin   = minIterationsGeneralize
    imax   = maxIterationsGeneralize
    
    ## We start at step 0.
    stepGeneralize = 0
    
    ## The parts of the logic program to be grounded are declared with an empty sequence. 
    parts = []

    ## We append the base1 part of the Logic Program. (See e.g. generalize.lp to see which part this is.)
    parts.append(("base", []))
    
    # These external options are currentl not working. They are intended to disallow generalization operations for particuar domains to improve searhc performance. For now, to realise this, (de)comment respective rules in generalize.lp file manually.
    
    # if rmOpAllowed : prg.assign_external(Fun("rmOpAllowed", [] ), True)
    # if rmPredAllowed : prg.assign_external(Fun("rmPredAllowed", []), True)
    # if rmAxAllowed : prg.assign_external(Fun("rmAxAllowed", []), True)
        
    # #### First, find a path to the generic space

    # # The main generalization loop starts here!
    while True:
        # Abort after the max. number of iterations 
        if stepGeneralize > imax: break
        # Append the cumulative part for the particular step (slice) of the program.
        parts.append(("cumulative", [stepGeneralize]))
        # # Ground the new slice
        prg.ground(parts)
        parts = []
        # Release the query1(t) atom from the last slice (step-1) from the program. 
        prg.release_external(Fun("query", [stepGeneralize-1]))
        # Add the atom query1(t) of this slice to the program. 
        prg.assign_external(Fun("query", [stepGeneralize]), True)

        # Find Stable Models for this generalization iteration
        ret = prg.solve(None, onModelGeneralize)
        # with prg.solve_iter() as it:
        #     for model in prg.solve_iter():
        #         printModel(model)                
                

        # If Stable Models are found and we are beyond the minimal number of slices, break loop.
        if stepGeneralize >= (imin-1) and (ret == SolveResult.SAT): break
        stepGeneralize = stepGeneralize+1


#end.
