from gringo import *
import os, sys, time, subprocess, threading, shlex
from settings import *
from langCasl import *
from itertools import *
from sets import Set
import json


def findLeastGeneralizedBlends(modelAtoms, inputSpaces, highestValue, blends):
    global blendValuePercentageBelowMinToKeep, renamingMode, consistencyCheckBehavior

    if highestValue == -sys.maxint:
        minBlendValueToConsider = -sys.maxint
    else:
        minBlendValueToConsider = highestValue - int(float(highestValue) / float(100) * float(blendValuePercentageBelowHighestValueToKeep))

    genInputSpaceTuples = getGeneralisedSpaceTuples(modelAtoms, inputSpaces)

    # # initialize output string for casl file
    cstr = '%% Temporary CASL File to decide consistency of blends\n\n\n'
    specRenamings = {}
    lastSpecs = {}
    blendNames = {}
    for spaceTuple in genInputSpaceTuples:
        for specName,spec in spaceTuple.specs.iteritems():
            lastSpecs[specName] = "Generic"
            specRenamings[specName] = ""
        break

    genInputSpaceTuples.reverse()
    # Before iterating in reverse order over all generalisations (starting from the most generalised specs), create the generic space as a copy of  of the most generalised specs (which are all equal, except for their compression value).     
    for spaceTuple in genInputSpaceTuples:
        for specName,spec in spaceTuple.specs.iteritems():
            generic = copy.deepcopy(spec)
            generic.lastGenAction = {}
            generic.nextGenAction = {}
            generic.name = "Generic"
            cstr += generic.toCaslStr()+"\n\n"
            break
        break

    # Now iterate over all generalisation tuples. 
    for spaceTuple in genInputSpaceTuples:
        for specName,spec in spaceTuple.specs.iteritems():
            # Only specify this spec if it has not been specified already.              
            if spec.name != lastSpecs[specName]:
                # Inherit everything from last spec
                lastSpecName = lastSpecs[specName]
                lastSpecs[specName] = spec.name

                specStr = "spec " + spec.name + " = " + lastSpecName
                
                # # Depending on the action type, write mapping (renamings and sort generalisation) or add elements (removal)
                genAction =  spaceTuple.nextGenAction
                if "actType" in genAction.keys():
                    # print "The generalisation action to reach " + spec.name + " is: "
                    # print genAction
                    if genAction["actType"] in ["renamePred","renameSort","renameOp","genSort"]:
                        eleFrom = lpToCaslStr(genAction['argVect'][1])
                        eleTo = lpToCaslStr(genAction['argVect'][0]) 
                        if renamingMode == "mergeNames":
                            generalEleName = eleTo + "_" + eleFrom
                        else:
                            generalEleName = eleFrom

                        if lpToCaslStr(genAction["iSpace"]) == specName:
                            renaming = generalEleName + " |-> " + eleTo
                        else:
                            renaming = generalEleName + " |-> " + eleFrom
                        # TODO: Check if this is necessary. Axiom renaming should actually have happened in getGeneralisedSpaceTuples in langCasl.py already.
                        # for axiom in spec.axioms:
                        #     axiom.axStr = renameEleInAxiom(axiom.axStr, eleFrom,eleTo)
                        
                        if specRenamings[specName] != "":
                            specRenamings[specName] += ", "
                        specRenamings[specName] += renaming

                        specStr += " with " +  renaming

                    if genAction["actType"] in ["rmPred","rmOp","rmSort","rmAx"]:    
                        specStr += " then\n "
                    if genAction["actType"] == "rmPred":
                        predName = genAction['argVect'][0][3:]
                        for p in spec.preds:
                            if predName == p.name:
                                specStr = specStr + p.toCaslStr()
                                break
                    if genAction["actType"] == "rmOp":
                        opName = genAction['argVect'][0][3:]
                        for op in spec.ops:
                            if opName == op.name:
                                specStr = specStr + op.toCaslStr()
                                break
                    if genAction["actType"] == "rmSort":
                        sName = genAction['argVect'][0][5:]
                        for s in spec.sorts:
                            if sName == s.name:
                                specStr = specStr + s.toCaslStr()
                                break
                    if genAction["actType"] == "rmAx":
                        axId = genAction['argVect'][0]
                        for ax in spec.axioms:
                            if axId == str(ax.id):
                                specStr = specStr + ax.toCaslStr()
                                break
                    
                mapFromGenericStr = "view GenTo"+spec.name+" : Generic to "+spec.name
                if specRenamings[specName] != "":
                    mapFromGenericStr += " = " 
                mapFromGenericStr += specRenamings[specName]
                mapFromGenericStr += " end \n\n" 

                # cstr = cstr +   spec.toCaslStr() + "\n\n" + mapFromGenericStr
                cstr = cstr +   specStr + "\n\n" + mapFromGenericStr

        # State blends (colimit operation)
        value = spaceTuple.getBlendValue()
        # for value in sorted(blendCombis.keys(),reverse=True):
        # print "value of blend: " + str(value) + " -- minValue: "  + str(minBlendValueToConsider)
        if value < minBlendValueToConsider:
            continue
        if value not in blendNames.keys(): 
            blendNames[value] = []
          

        blendName =   "Blend" + "_v"+str(value)+ "_"                
        for specName,spec in spaceTuple.specs.iteritems():
            steps = spec.generalisationSteps
            blendName += "_" + specName + "_" + str(steps)
        blendNames[value].append(blendName)
        cstr = cstr + "spec " + blendName
        cstr = cstr + " = combine "
        for specName,spec in spaceTuple.specs.iteritems():            
            cstr = cstr + "GenTo"+spec.name+","
        cstr = cstr[:-1]
        cstr = cstr + " end\n\n"
        
    if os.path.isfile("amalgamTmp.casl"):
        os.system("rm amalgamTmp.casl")

    tries = 0
    while not os.path.isfile("amalgamTmp.casl") :        
        outFile = open("amalgamTmp.casl","w")
        outFile.write(cstr)
        outFile.close()
        tries = tries + 1
        if tries > 5:
            print "ERROR! file amalgamTmp.casl not yet written after "+ str(tries) + "tries. Aborting program... "
            exit(1)

    generalizationValue = -sys.maxint-1
    consistentFound = False
    for value in sorted(blendNames.keys(),reverse=True):
        print "Trying blends with generalization value of " + str(value)
        if value < minBlendValueToConsider:
            print "value "  +str(value) + " < " + str(minBlendValueToConsider) + " too low, aborting..."
            break

        for blendName in blendNames[value]:   
            print "Checking consistency of " + blendName + ""
            #generate tptp format of theory and call eprover to check consistency
            blendTptpName = "amalgamTmp_"+blendName+".tptp"
            tries = 0
            # Try to generate input files several times. This is neccesary due to strange file writing bug. 
            while True:
                if os.path.isfile(blendTptpName):
                     blendFileSize = os.stat(blendTptpName).st_size
                else: 
                    blendFileSize = 0                
                if blendFileSize != 0:
                    break
                
                print "generating tptp because " + blendTptpName + " file was not found"
                ###TBD call HETS API
                subprocess.call([hetsExe, "-o tptp", "amalgamTmp.casl"])
                print "Done generating tptp"
                # This is a hack because hets sometimes seems to not generate all .tptp files. So we just try again and again until its working. 
                tries = tries + 1
                if tries > 15:
                    print "ERROR: File "+blendTptpName+" not yet written correctly "+ str(tries) + " times! Aborting..."
                    exit(1)

            thisCombiConsistent = checkConsistency(blendTptpName)

            if consistencyCheckBehavior == "brave":
                assumeConsistent = thisCombiConsistent != 0 # If we can not show that the blend is inconsistent 
            else:
                assumeConsistent = thisCombiConsistent == 1 # If we can show that the blend is consistent
            if assumeConsistent:                
                prettyBlendStr = prettyPrintBlend2(blendName, cstr)
                combi = {}
                combiParts = blendName.split("__")[1].split("_")
                i = 0
                while i < len(combiParts):
                    combi[toLPName(combiParts[i],'spec')] = combiParts[i+1]
                    i += 2

                blendInfo = {"combi": combi, "prettyHetsStr" : prettyBlendStr, "blendName" : blendName, "value" : value}
                consistentFound = True
                # If a better blend was found, delete all previous blends. 
                if value > highestValue:
                    highestValue = value
                    minBlendValueToConsider = highestValue - int(float(highestValue) / float(100) * float(blendValuePercentageBelowHighestValueToKeep))
                    print "New best value: " + str(value) + ". Resetting global list of blends and keeping only blends with a value of at least " + str(minBlendValueToConsider) + ", i.e., " + str(blendValuePercentageBelowHighestValueToKeep) + "% below new highest value of " + str(highestValue) + "."
                    newBlends = []
                    for blend in blends:
                        if blend['value'] >= minBlendValueToConsider:
                            newBlends.append(blend) 
                    blends = newBlends                    
                blends.append(blendInfo)

    os.system("rm *.tptp")
    # os.remove("amalgamTmp.casl")
    
    return [blends,highestValue]

def prettyPrintBlend2(blendName, cstr):
    prettyPrintStr = ''
    lines = cstr.split("\n")
    # Just remove all lines that specifiy blends which is not the blend in question. 
    for line in lines:
        if line[:10] != "spec Blend":
            prettyPrintStr += line + "\n"
        if line.find(blendName) != -1:
            blendStr = line.split("= combine")[1]
            blendStr = "spec Blend = combine " + blendStr
            prettyPrintStr += blendStr + "\n"
    return prettyPrintStr



def writeJsonOutput(blends,inputSpaceNames):

    jsonOutput = {}
    jsonOutput['blendList'] = []
        
    print inputSpaceNames
    blendNr = 1
    for blend in blends:
        jsonBlend = {}
        
        blendStr = blend['prettyHetsStr']
        print 'Blend'+str(blendNr)
               
        genericSpacePattern = "(spec\sGeneric.*?end)"
        jsonBlend['blendId'] = str(blendNr)
        jsonBlend['blendName'] = blend['blendName']
        jsonBlend['cost'] = blend['value']
        match = re.search(genericSpacePattern,blendStr,re.DOTALL)
        jsonBlend['genericSpace'] = match.group(0)
        
        combi = blend['combi']
        inputSpaceNr = 1
        for inputSpaceName in inputSpaceNames:
            inputSpace = inputSpaceName
            if combi[toLPName(inputSpace,'spec')] > 0:
                genSpaceName= '_'+'gen'+'_'+str(combi[toLPName(inputSpace,'spec')])
            else:
                genSpaceName=''
            print 'TETEET:' + genSpaceName
            genericSpacePattern = "(spec\s"+inputSpace+"(?=)"+genSpaceName+".*?end)"
            
            match = re.search(genericSpacePattern,blendStr,re.DOTALL)

            jsonBlend['input'+str(inputSpaceNr)] = match.group(0)

            inputSpaceNr = inputSpaceNr +1
                    
        jsonBlend['blend'] = generateBlend(blend)
        jsonOutput['blendList'].append(jsonBlend)
        blendNr = blendNr +1
   
    return jsonOutput

# This function takes a list of blend speciications and writes them to disk.
def generateBlend(blend):

    os.system("rm Blend_*.casl")
    os.system("rm Blend_*.th")
    bNum = 0
    blendFilesList = ''
    
    blendStr = blend["prettyHetsStr"]
    fName = blend["blendName"] + "_b_"+str(bNum)+".casl"
    outFile = open(fName,"w")
    outFile.write(blendStr)
    outFile.close()
    tries = 0
    while True:
        ### call HETS API
        subprocess.call([hetsExe, "-o th", fName])
        thName = fName[:-5]+"_Blend.th"
        thFileSize = 0
        if os.path.isfile(thName):
            thFileSize = os.stat(thName).st_size

        if tries > 15:
            print "ERROR: file " + thName + " not yet written in " + str(tries) + " times ! Aborting..."
            exit(1)                
        tries = tries + 1            

        if thFileSize != 0:
            break

    bFile = open(thName,"r")
    explicitBlendStr = bFile.read()
    bFile.close()
    # remove first two lines and rename explicit blend spec
    lineBreakPos = explicitBlendStr.find("\n")
    explicitBlendStr = explicitBlendStr[lineBreakPos+1:]
    lineBreakPos = explicitBlendStr.find("\n")
    explicitBlendStr = explicitBlendStr[lineBreakPos+1:]
    explicitBlendStr = "\n\n\nspec BlendExplicit = \n" + explicitBlendStr + "\n end\n"

    outFile = open(fName,"r")
    fullBlendStr = outFile.read()
    outFile.close()

    fullBlendStr = fullBlendStr + explicitBlendStr 

    outFile = open(fName,"w")
    outFile.write(fullBlendStr)
    outFile.close()

    # os.system("cp " + thName + " " + thName[:-3]+".casl")
    os.system("rm *.th")
    # blendFilesList += thName[:-3]+".casl\n"
    blendFilesList += fName
        
    bNum = bNum + 1

    # raw_input
    fileListFile = open("blendFiles.txt","w")
    fileListFile.write(blendFilesList)
    fileListFile.close()
    return explicitBlendStr


# This function takes a list of blend specifications and writes them to disk.
def writeBlends(blends):
    global genExplicitBlendFiles
    # raw_input
    os.system("rm Blend_*.casl")
    os.system("rm Blend_*.th")
    bNum = 0
    blendFilesList = ''
    # existingBlends = Set()
    blendFNameValues = {}
    for blend in blends:

        blendStr = blend["prettyHetsStr"]
        fName = blend["blendName"] + "_b_"+str(bNum)+".casl"
        outFile = open(fName,"w")
        outFile.write(blendStr)
        outFile.close()
        tries = 0
        while True:
            ### call HETS API
            subprocess.call([hetsExe, "-o th", fName])
            thName = fName[:-5]+"_Blend.th"
            thFileSize = 0
            if os.path.isfile(thName):
                thFileSize = os.stat(thName).st_size

            if tries > 15:
                print "ERROR: file " + thName + " not yet written in " + str(tries) + " times ! Aborting..."
                exit(1)                
            tries = tries + 1            

            if thFileSize != 0:
                break

        bFile = open(thName,"r")
        explicitBlendStr = bFile.read()
        bFile.close()
        # remove first two lines and rename explicit blend spec
        lineBreakPos = explicitBlendStr.find("\n")
        explicitBlendStr = explicitBlendStr[lineBreakPos+1:]
        lineBreakPos = explicitBlendStr.find("\n")
        explicitBlendStr = explicitBlendStr[lineBreakPos+1:]
        explicitBlendStr = "\n\nspec BlendExplicit = \n" + explicitBlendStr + "\nend\n"

        value = int(fName.split("Blend_v")[1].split("__")[0])


        # explicitBlendStr = "%%% Blend value: " + str(value) + explicitBlendStr

        
        
        # Check if this blend has already been produced. If so, do not write it again. 
        if explicitBlendStr in blendFNameValues.keys():
            if blendFNameValues[explicitBlendStr][0] >= value:
                os.system("rm " + fName)
                os.system("rm *.th")    
                continue
            # The following lines are a quickfix to forbid identical blends with a different value, as described in the README.md. It just removes idenitcal existing blends with a lower value. 
            if blendFNameValues[explicitBlendStr][0] < value:
                # print " same blend with lower value exists. removing " + blendFNameValues[explicitBlendStr][1]
                os.system("rm " + blendFNameValues[explicitBlendStr][1])
                os.system("rm " + blendFNameValues[explicitBlendStr][1][:-5]+"_Blend.casl")
                # os.system("rm *.th")    
                # continue

        blendFNameValues[explicitBlendStr] = [value,fName]
                

        
        
        

        # existingBlends.add(explicitBlendStr)

        outFile = open(fName,"r")
        fullBlendStr = outFile.read()
        outFile.close()

        fullBlendStr = fullBlendStr + explicitBlendStr 

        outFile = open(fName,"w")
        outFile.write(fullBlendStr)
        outFile.close()

        if genExplicitBlendFiles == True:
            os.system("cp " + thName + " " + thName[:-3]+".casl")
            os.system("rm *.th")
            blendFilesList += thName[:-3]+".casl\n"
        
        # blendFilesList += fName
        
        bNum = bNum + 1

    # raw_input
    if genExplicitBlendFiles == True:
        fileListFile = open("blendFiles.txt","w")
        fileListFile.write(blendFilesList)
        fileListFile.close()

    


def checkConsistency(blendTptpName):
    global darwinTimeLimit
    consistent = checkConsistencyEprover(blendTptpName)
    if darwinTimeLimit == 0:
        return consistent
    if consistent == -1:

        print "Consistency could not be determined by eprover, trying darwin"                
        consistent = checkConsistencyDarwin(blendTptpName)
        # if consistent == 0 or consistent == 1:
            # os.system("echo \"eprover could not determine inconsistency but darwn could for blend " + blendTptpName + "\" > consistencyCheckFile.tmp")
            # print("eprover could not determine (in)consistency but darwn could for blend " + blendTptpName + ". Result: " + str(consistent) + ". Press key to continue.")
            # raw_input()

    return consistent


def checkConsistencyEprover(blendTptpName) :
        global eproverTimeLimit
        tries = 0
        while not os.path.isfile("consistencyRes.log") :
            resFile = open("consistencyRes.log", "w")        
            subprocess.call(["eprover","--auto" ,"--tptp3-format", "--cpu-limit="+str(eproverTimeLimit), blendTptpName], stdout=resFile)
            resFile.close()
            
            if tries > 5:
                print "ERROR!!! File consistencyRes.log not written by eprover after "+ str(tries) + " tries. Aborting..."
                exit(0)
            tries = tries + 1

        resFile = open("consistencyRes.log",'r')
        res = resFile.read()
        resFile.close()

        os.system("rm consistencyRes.log")

        if res.find("# No proof found!") != -1 or res.find("# Failure: Resource limit exceeded") != -1:
            print "Eprover: No consistency proof found."
            return -1

        if res.find("SZS status Unsatisfiable") != -1:
            print "Eprover: Blend inconsistent."
            return 0
        
        print "Eprover: Blend consistent."
        return 1

def checkConsistencyDarwin(blendTptpName) :
        global darwinTimeLimit
        
        darwinCmd = Command("darwin " + blendTptpName)

        status,output,error = darwinCmd.run(timeout=darwinTimeLimit)

        # print output
        cVal = -1
        if output.find("ABORTED termination") != -1:
            print "Consistency check w. darwin failed: TIMEOUT" 
            cVal = -1
        if output.find("SZS status Satisfiable") != -1:
            print "Consistency check w. darwin succeeds: CONSISTENT"
            cVal = 1
        if output.find("SZS status Unsatisfiable") != -1:
            print "Consistency check w. darwin succeeds: INCONSISTENT"
            cVal = 0
        
        # raw_input()

        return cVal


