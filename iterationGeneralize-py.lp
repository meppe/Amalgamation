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

# print "starting generalisation"

# Global variable required for the blending: the input spaces in the internal data structure represenation. 
inputSpaces = []

# Global variable to store the best blends that ere found so far. 
blends = []

# Global variable to store the max. allowed cost for a blend. 
highestValue = -sys.maxint

continueSolving = True

# This is called if a model is found.
def onModelGeneralize(model):    
    global inputFile, highestValue, blends, generaliseOnly, continueSolving, blendValuePercentageBelowHighestValueToKeep
    lpFileName = inputFile.split(".")[0]+".lp"

    print "Found generalisation:"
    modelStr = getModel(model)
    print modelStr
    ## If there is a cross space mapping found, don't stop solving
    # if modelStr.find("finalCrossSpaceMap") > -1:
        # print "Cross space mapping found. Not terminating generalisation."
        # continueSolving = True 

    # breakpoint = False
    # if modelStr.find("exec(renameOp(po_boat,po_resident,spec_House),spec_Boat") > -1:
    #     print "Exec of interest found"
    #     breakpoint = True
    #     oldBlendValuePercentageBelowHighestValueToKeep = blendValuePercentageBelowHighestValueToKeep
    #     blendValuePercentageBelowHighestValueToKeep = 100
        # raw_input()


    if generaliseOnly:
        return

    oldBlends = copy.deepcopy(blends)
    [blends,blendingGeneralizationValue] = findLeastGeneralizedBlends(model.atoms(), inputSpaces, highestValue, blends) 
    # print blendingGeneralizationValue  
    if blendingGeneralizationValue >= highestValue and blendingGeneralizationValue > -sys.maxint:
        highestValue = blendingGeneralizationValue
        print "Found blend with a better or equal generalization value of  " + str(highestValue) + "."

        

    # writeBlends(blends)
        
        # jsonOutput = writeJsonOutput(blends,inputSpaceNames)
        # blendJsonList = jsonOutput['blendList']       
        # for blendJson in blendJsonList:
        #     os.system("rm blend.json")
        #     outFile = open('blend.json',"w")
        #     outFile.write(json.dumps(blendJson))
        #     outFile.close()            
        #     print 'Other blend? (n) '
        #     sys.stdout.flush()
        #     x = raw_input()            
        #     if x == 'n':
        #        break;
        # print 'finished'
        # sys.stdout.flush()

    # if breakpoint:
    #     blendValuePercentageBelowHighestValueToKeep = oldBlendValuePercentageBelowHighestValueToKeep
    #     writeBlends(blends)
    #     print "Blends written during breakpoint"
    #     raw_input()

    ## If no new blends were generated, stop solving
    if blends != oldBlends:
        print "New blends were generated. Not terminating generalisation."
        continueSolving = True
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

    ## These are the blends. 
    global blends, continueSolving, clingoTimeLimit
    
    print "Starting main iteration loop. Reading input spaces."

    inputSpacesXmlFileName = input2Xml(inputFile,inputSpaceNames) 
    inputSpaces = parseXml(inputSpacesXmlFileName)

    ## Some abbreviations to make the code more compact:
    imax   = maxIterationsGeneralize
    
    ## We start at step 0.
    stepGeneralize = 0
    
    ## The parts of the logic program to be grounded are declared with an empty sequence. 
    parts = []

    ## We append the base1 part of the Logic Program. (See e.g. generalize.lp to see which part this is.)
    parts.append(("base", []))

    ## The main loop to find the generic space starts here!
    while True:
        # Abort after the max. number of iterations 
        if stepGeneralize > imax: break
        # Append the cumulative part for the particular step (slice) of the program.
        parts.append(("cumulative", [stepGeneralize]))
        # # Ground the new slice
        prg.ground(parts)
        parts = []
        # Release the query(t) atom from the last slice (step-1) from the program. 
        prg.release_external(Fun("query", [stepGeneralize-1]))
        # Add the atom query(t) of this slice to the program. 
        prg.assign_external(Fun("query", [stepGeneralize]), True)
        # Determine whether or not to continue solving. The global var is set in onModelGeneralise
        continueSolving = False
        # Find Stable Models for this generalization iteration
        start = time.clock()
        ret = prg.solve(None, onModelGeneralize)                  
        end = time.clock()
        elapsed = (end - start)
        print "Step: " + str(stepGeneralize) + " -- Solving time:" + str(elapsed) + " s."
        # raw_input()
        if elapsed * 1.01 >= clingoTimeLimit:
            print " Time limit for ASP solving exceeded. Aborting ASP generalisation search."
            break

        # If Stable Models are found and we are stop solving, break loop.
        if ret == SolveResult.SAT:
            if continueSolving == False:
                break

        stepGeneralize = stepGeneralize+1

    writeBlends(blends)

#end.
