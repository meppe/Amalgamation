import xml.etree.ElementTree as ET
import subprocess
import os
import copy
import time
from string import *
import re
from decimal import *

from settings import *
from auxFunctions import *
import requests

axMap = {}
axEqClasses = {}

### input2Xml translates CASL input spaces to an xml file. The xml simplifies the CASL parsing. 
### Input:  CASL file name and names of input spaces
### Output: The path to an xml file representing the input spaces.     
def input2Xml(fName,inputSpaces):    
    global hetsExe
    # First generate .th files from CASL files. 
    #To be sure that all .th files have been generated repeat this 5 times. This is necessary because file generation via command line turned out to be buggy,
    allGenerated = False
    tries = 0
    while True:
        print "Generating Casl .th files using HETS from " + fName
        ##TBD: call HETS axInvolvesPredOp
        subprocess.call([hetsExe, "-o th", fName])
        print "Done generating casl .th files using HETS"        
        # raw_input()
        allGenerated = True
        for spec in inputSpaces:
            specThFName = fName.split(".")[0]+"_"+spec+".th"
            # print "th fle name" + specThFName
            if os.path.isfile(specThFName):
                thFileSize = os.stat(specThFName).st_size
            else:
                thFileSize = 0
            if thFileSize == 0:
                allGenerated = False
                break
        if allGenerated == True:
             break        
        if tries > 5:
            print "ERROR: file " + specThFName + " not yet written in " + str(tries) + " times ! Aborting..."
            exit(1)                
        tries = tries + 1

       
    # Second read the input spaces to be blended in CASL syntax from .th files and concatenate the strings. 
    newFileContent = ""
    for spec in inputSpaces:
        thFileName = fName.split(".")[0]+"_"+spec+".th"
        tmpFile = open(thFileName, "r")
        tmp = tmpFile.read()
        newFileContent = newFileContent + tmp
    
    newFileName = fName.split(".")[0]+"_raw.casl"
    newFile = open(newFileName, "w")
    newFile.write(newFileContent)
    newFile.close()

    #Clean up and remove temporary theory files...
    os.system("rm " + fName.split(".")[0]+"*.th")

    # Third, generate xml file from concatenated CASL input spaces. As above, this is buggy, so we make sure that the xml file is generated correctly by trying 5 times. 
    xmlFileName = newFileName.split(".")[0]+".xml"
    
    tries = 0
    # print "Generating xml file for parsing."
    if os.path.isfile(xmlFileName):
        os.system("rm " + xmlFileName)
    while True:
        xmlFileSize = 0
        if os.path.isfile(xmlFileName):
            statinfo = os.stat(xmlFileName)
            xmlFileSize = statinfo.st_size
        if xmlFileSize != 0:
            # print "Calling parseXml method"
            try:
                tree = ET.parse(xmlFileName)
                # print "End calling parseXml method"
                break
            except ET.ParseError:
                print "xml parse error, trying again..."
        
        if tries > 5:
            print "ERROR: File " + xmlFileName + " not yet written correctly after " + str(tries) + " tries! Aborting... :::::::"
            exit(1)
        tries = tries + 1
        print "Calling hets to generate xml file for parsing"
        ### TBD call hets
        if useHetsAPI == 0:
            subprocess.call([hetsExe, "-o xml", newFileName])
        else:
            subprocess.call(["wget", hetsUrl+'dg/demo_examples%2ftritone_demo.casl?format=xml&node=G7&node=Bbmin', "-O", xmlFileName]) 
        #wget http://localhost:8000/demo_examples%2ftritone_demo.casl?format=xml -O test.xml       
        print "Done calling hets to generate xml"
    
      
    #os.remove(newFileName)
    return xmlFileName

## This class represents a predicate in CASL. 
class CaslPred:
    def __init__(self, name):
        self.name = name
        self.args = []
        self.priority = 1
    
    @staticmethod
    def byStr(text):
        pName = text[4:].split(":")[0].strip()
        p = CaslPred(pName)
        p.args = text.split(":")[1].strip().split(" * ")  
        return p
        
    def toCaslStr(self):
        outStr = "pred " + self.name + " : " 
        for s in self.args: outStr = outStr + s +" * " 
        outStr = outStr[:-3]
        outStr = outStr + "\t%% prio:"+ str(self.priority)
        return outStr    

    def toLPStr(self, specName) :
        oStr = "hasPred("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+",0).\n"
        argCtr = 1
        for arg in self.args:
            oStr = oStr + "predHasSort("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+toLPName(arg,"sort")+",arg"+str(argCtr)+",0).\n"
            argCtr = argCtr + 1   

        argCtr = argCtr - 1       
        oStr = oStr + "hasNumArgs("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+str(argCtr)+").\n"      
        # if self. == True:
            # oStr = oStr + "removablePred("+toLPName(specName,"spec")+","+toLPName(self.name)+").\n"
        oStr = oStr + "predHasPriority("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+str(self.priority)+").\n"        
        return oStr 
             
## This class represents an operator in CASL.       
class CaslOp:
    def __init__(self, name):
        self.name = name
        self.args = []
        self.dom = ''
        # self.removable = 1
        self.isDataOp = False
        self.priority = 0
    
    @staticmethod
    def byStr(text):
        opName = text[2:].split(":")[0].strip()
        op = CaslOp(opName)
        if text.find("->") == -1:
            op.dom = text.split(":")[1].strip()
            op.partial = False
        else: 
            # if the operator is not a partial function (i.e. a total function)
            if text.find("->?") == -1:
                op.args = text.split(":")[1].split("->")[0].strip().split(" * ")  
                op.dom = text.split("->")[1].strip()
                op.partial = False
            # if the operator is a partial function
            else:
                op.args = text.split(":")[1].split("->?")[0].strip().split(" * ")  
                op.dom = text.split("->?")[1].strip()
                op.partial = True
        return op
    
    def toCaslStr(self):
        outStr = "op " + self.name + " : " 
        for s in self.args: outStr = outStr + s +" * " 
        outStr = outStr[:-3]
        if self.partial == False:
            arrStr = " -> "
        else:
            arrStr = " ->? "
        if len(self.args) > 0:
            outStr = outStr + arrStr +self.dom    
        else:
            outStr = outStr + " : " +self.dom

        outStr = outStr + "\t%%prio:"+ str(self.priority)
        if self.isDataOp:
            outStr +=  "\t(data operator)"
        return outStr 

    def toLPStr(self,specName):
        oStr = "hasOp("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+",0).\n"
        argCtr = 1
        for arg in self.args:
            oStr = oStr + "opHasSort("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+toLPName(arg,"sort")+",arg"+str(argCtr)+",0).\n"
            argCtr = argCtr + 1
        oStr = oStr + "opHasSort("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+toLPName(self.dom,"sort")+",domain,0).\n"
        argCtr = argCtr - 1
        oStr = oStr + "hasNumArgs("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+str(argCtr)+").\n"
        if self.isDataOp == False:
            oStr = oStr + "isNonDataOp("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+").\n"
        else:
            oStr = oStr + "isDataOp("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+").\n"
        oStr = oStr + "opHasPriority("+toLPName(specName,"spec")+","+toLPName(self.name,"po")+","+str(self.priority)+").\n"        
        return oStr 

    
## This class represents a sort in CASL.       
class CaslSort:
    def __init__(self, name):
        self.name = name
        self.parent = ""
        self.priority = 0
        # self.removable = 1
        self.isDataSort = False

    def toCaslStr(self):
        outStr = "sort " + self.name
        if self.parent != "":
            outStr = outStr + " < " + self.parent
        outStr = outStr + "\t%%prio:"+ str(self.priority)
        if self.isDataSort:
            outStr +=  "\t(data sort)"
        return outStr

    def toLPStr(self,specName):
        oStr = "hasSort("+toLPName(specName,"spec")+","+toLPName(self.name,"sort")+",0).\n"
        if self.parent != "":
            oStr = oStr + "hasParentSort("+toLPName(specName,"spec")+","+toLPName(self.name,"sort")+","+toLPName(self.parent,"sort")+",0).\n"
        if self.isDataSort == False:
            oStr = oStr + "isNonDataSort("+toLPName(specName,"spec")+","+toLPName(self.name,"sort")+").\n"
        else:
            oStr = oStr + "isDataSort("+toLPName(specName,"spec")+","+toLPName(self.name,"sort")+").\n"
        oStr = oStr + "sortHasPriority("+toLPName(specName,"spec")+","+toLPName(self.name,"sort")+","+str(self.priority)+").\n"
        return oStr

# This class represents a CASL specification.        
class CaslSpec:
    def __init__(self, name):
        self.name = name
        self.ops = []
        self.preds = []
        self.sorts = []
        self.axioms = []
        self.id = 0
        self.generalisationSteps = 0
        self.infoValue = 0 # This is the amount of information left in a specification
        # self.compressionValue = 0 # This is the amount of information that was `merged' between all input spaces at the current level, by renaming operators, sorts and predicates. 

    def toCaslStr(self):
        # caslStr = "CaslSpec:\n"
        caslStr = "spec "
        caslStr = caslStr +  self.name +" = %% InfoValue: " + str(self.infoValue) + "\n"
        for s in self.sorts: 
            if s.name == "PriorityDummySort":
                continue
            caslStr = caslStr + "\t " + s.toCaslStr() + "\n"
        # if len(self.ops) > 0 :
            # caslStr = caslStr + "\t ops \n" 
        for op in self.ops: 
            if op.name == "prioDummyOp":
                continue
            caslStr = caslStr + "\t " + op.toCaslStr() +"\n"
        # if len(self.preds) > 0 :
            # caslStr = caslStr + "\t preds \n"
        for p in self.preds: 
            caslStr = caslStr + "\t " + p.toCaslStr() +"\n"
        caslStr += "\n"
        for ax in self.axioms: 
            if ax.axStr == ". prioDummyOp = prioDummyOp":
                continue
            caslStr = caslStr + ax.toCaslStr()
        caslStr = caslStr + "end"
        
        return caslStr
        
    def toLP(self):
        global lpToCaslMapping
        oStr  = "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
        oStr += "%% spec " + self.name+" %%\n"
        oStr += "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n"
        oStr = oStr + "spec("+toLPName(self.name,"spec")+").\n"
        oStr = oStr + "hasId("+toLPName(self.name,"spec")+","+str(self.id)+").\n\n"      
        oStr += "%% sorts %%\n"
        for so in self.sorts:
            if so.name == "PriorityDummySort":
                continue
            oStr = oStr + so.toLPStr(self.name) + "\n"
        oStr += "%% operators %%\n"
        for op in self.ops:
            if op.name == "prioDummyOp":
                continue
            oStr = oStr + op.toLPStr(self.name) + "\n"
        oStr += "%% predicates %%\n"
        for p in self.preds:
            oStr = oStr + p.toLPStr(self.name) + "\n"
        oStr += "%% axioms %%\n"
        for ax in self.axioms:
            if ax.axStr == ". prioDummyOp = prioDummyOp":
                continue
            if ax.isDataAxiom == True:
                continue
            if ax.priority == -1:
                continue
            oStr = oStr + ax.toLPStr(self.name) + "\n"        

        # print "opToCaslMap:"
        # print lpToCaslMapping
        return oStr
    def setInfoValue(self):
        self.infoValue = 0
        for sort in self.sorts:
            if sort.priority > 0:
                self.infoValue = sort.priority + self.infoValue
        for op in self.ops:
            if op.priority > 0:
                self.infoValue = op.priority + self.infoValue
        for pred in self.preds:
            if pred.priority > 0:
                self.infoValue = pred.priority + self.infoValue
        for ax in self.axioms:
            if ax.priority > 0:
                self.infoValue = ax.priority  + self.infoValue
        ## Now multiply info value with 100 to allow for more precise computation of blend values
        self.infoValue *= 100

## This class represents casl specs as nodes in a directed labeled graph that represents the generalisation tree
class CaslSpecTreeNode(CaslSpec):
    def __init__(self,name,prevCaslSpec,genAction):
        CaslSpec.__init__(self,name)
        self.prevCaslSpec = prevCaslSpec
        self.genAction = genAction

## This class represents a tuple of generalised specification, containing additional information about how to get to the next tuple of generalisations (via which generalisation action). 
class GeneralisedCaslSpecTuple():
    def __init__(self,lastGenAction,specs):
        self.lastGenAction = lastGenAction
        self.nextGenAction = {}
        self.specs = specs
        self.compressionValue = 0
    def printInfo(self):
        print "Generalisation tuple"
        for specname,spec in self.specs.iteritems():
            print specname
        print "Compression value: " + str(self.compressionValue)
        print "Action:"
        print self.lastGenAction
        print "Specs:"
        for specname,spec in self.specs.iteritems():
            print spec.toCaslStr()
    
    def getInfoValue(self):
        informationValue = 0
        for specname,spec in self.specs.iteritems():
            informationValue = informationValue + spec.infoValue
        return informationValue

    def getBalancePenalty(self):
        avgInformationValue = self.getInfoValue() / len(self.specs.keys())
        # print "average info value is " + str(self.getInfoValue() ) + "/" + str(len(self.specs.keys())) + "=" + str(avgInformationValue)
        balPenalty = 0
        for specname,spec in self.specs.iteritems():
            balPenalty = balPenalty + abs(spec.infoValue - avgInformationValue)
        balPenalty /= 2
        return balPenalty

    def getBlendValue(self):
        # print "getting blend value of tuple" 
        # for specname,spec in self.specs.iteritems():
            # print spec.name
        # print "infoValue " + str(self.getInfoValue())
        # print "compressionValue " + str(self.compressionValue)
        # print "getBalancePenalty " + str(self.getBalancePenalty())
        blendValue = self.getInfoValue() + self.compressionValue - self.getBalancePenalty()
        return blendValue


class CaslAx:    
    def __init__(self, id, name, axStr):
        self.id = id
        self.name = name
        self.axStr = axStr
        self.isDataAxiom = False # This determines whether only data operators (generated type constants) are part of this axiom. Typically, such axioms denote, e.g., that natural numbers are not equal, that the boolean true is not equal to false, or that the tones of a chord (which are data operators) are not equal. 
        self.priority = 1
        self.eqClass = getEquivalenceClass(axStr)
        self.involvedPredsOps = {}
        self.involvedSorts = {}
        self.fromAxStr(axStr)

    def getCaslAnnotationStr(self):
        aStr = ''
        aStr += "\t%("+self.name+")%\t%priority(" + str(self.priority) + ")%\t %%id:"+str(self.id) + "\teqClass: "+str(self.eqClass)
        if self.isDataAxiom:
            aStr += "\t(data axiom)"
        return  aStr

    def toCaslStr(self):        
        return "\t" + self.axStr + self.getCaslAnnotationStr() + "\n"
        
    def toLPStr(self, specName):
        if self.axStr.find("generated type") != -1:
            return ""
        oStr = "\n%% Axiom " + self.name + " %%\n"
        oStr += "hasAxiom("+toLPName(specName,"spec")+","+str(self.id)+",0).\n"
        oStr += "axHasEquivalenceClass("+toLPName(specName,"spec")+","+str(self.id)+","+str(self.eqClass)+",0).\n"
        if self.isDataAxiom == False:
            oStr = oStr + "isNonDataAx("+toLPName(specName,"spec") +","+str(self.id)+").\n"
        else:
            oStr = oStr + "isDataAx("+toLPName(specName,"spec") +","+str(self.id)+").\n"
        oStr = oStr + "axHasPriority("+toLPName(specName,"spec") +","+str(self.id)+","+str(self.priority)+").\n"
        
        for po in self.involvedPredsOps:
            oStr += "axInvolvesPredOp("+toLPName(specName,"spec") +","+str(self.id)+","+toLPName(po,"po")+",0).\n"
        for s in self.involvedSorts:
            oStr += "axInvolvesSort("+toLPName(specName,"spec") +","+str(self.id)+","+toLPName(s,"sort")+",0).\n"

        return oStr

    # This generates the internal axiom representation from an axiom string in CASL
    def fromAxStr(self, text):
        if text.find("generated type") != -1:
            return True
      
        # first extract quantifications
        axStr = copy.deepcopy(text)
        
        # print "parsing axiom"
        # print axStr    

        qId = 0
        axStr = axStr.replace("\n", "")

        tmpAxStr = copy.deepcopy(axStr)
        pattern = "\s:\s\w+"

        # Identify sorts in axiom

        while True:
            match = re.search(pattern,tmpAxStr)
            if match == None:
                break
            # print match.group(0)
            tmpAxStr = re.sub(pattern,"",tmpAxStr,count=1)
            self.involvedSorts[match.group(0)[3:]] = True

        # print self.involvedSorts.keys()

        # Identify variables in axiom (needed to distinguish from operators and predicates)

        tmpAxStr = copy.deepcopy(axStr)
        pattern = "(forall|exists|exists!).*?[\.]"
        vars = set()        
        while True:
            match = re.search(pattern,tmpAxStr)
            if match == None:
                break
            # print "varMatch"
            # print match.group(0)
            varArr = re.split("[\s.=(),:><;\n\\\\/]|not|forall|exists|exists!|",match.group(0))
            varArr = list(set(varArr) - set(self.involvedSorts.keys()))
            vars = vars | set(varArr)
            tmpAxStr = re.sub(pattern,"",tmpAxStr,count=1)

        # Identify operatos and predictes in axiom.
        axStrArr = re.split("[ .=(),:><;\n\\\\/]|not|forall|exists|exists!|",tmpAxStr)
        predOpNames = {}
        for item in axStrArr:
            if item == "":
                continue
            if item in vars:
                continue
            predOpNames[item] = True
        self.involvedPredsOps = copy.deepcopy(predOpNames.keys())


# This is the main method to turn the xml representation of input spaces into the internal data structure
# Input: The path to an XML file name
# Output: a list of CASL specs represented in the internal data structure
def parseXml(xmlFile):
    global axMap
    specs = []
    # print "Calling parseXml method"
    tree = ET.parse(xmlFile)
    # print "End calling parseXml method"
    dGraph = tree.getroot()
    ctr = 0  
    axCtr = 0 
    dataOps = {}
    dataSorts = {}
    opAndSortPriorities = {}
    for dgNode in dGraph:

        if 'refname' not in dgNode.attrib.keys():
            continue
        specName = dgNode.attrib['refname']
        thisSpec = CaslSpec(specName)
        thisSpec.id = len(specs)
        # print "found spec " + specName
        

        # First scan axioms to get the following meta-information:
        # (i) data ops, and sorts. Data ops and sorts are those in generated type definitions, so we have to scan for axioms starting with the string "generated type".
        # (ii) Priority information of ops, predicates and sorts. Priorities are encoded in the name of dummy-axioms that have the string ". prioDummyOp = prioDummyOp".
        dataOps[specName] = []
        dataSorts[specName] = []
        opAndSortPriorities[specName]= {}
        for decAx in dgNode:            
            for entry in decAx:
                if entry.tag == "Axiom":
                    for subEntry in entry:
                        if subEntry.tag == "Text":
                            axText = subEntry.text
                            if axText.find("generated type") == 0:
                                dataOpsStr = axText.split("::=")[1]
                                dataOpStrs = dataOpsStr.split("|")
                                for op in dataOpStrs : dataOps[specName].append(op.strip())

                                dataSortStr = axText.split("::=")[0][len("generated type"):].strip()
                                dataSorts[specName].append(dataSortStr)
                            if axText.find(". prioDummyOp = prioDummyOp") == 0:
                                # Priority information is encoded in the name of the axiom with the string above. Each element in this string is separated by the string "--"
                                prioInfo = entry.attrib['name'].split("--")
                                for prioInfoItem in prioInfo:
                                    if len(prioInfoItem.split(":p:")) != 2:
                                        print "WARNING!!! priority information " + prioInfoItem + " in wrong format. Expecting <ElementName>:p:<priorityNumber>. Assigning priority 0 instead."
                                    # prioInfoItem is a strings of the form <ElementName>_<PriorityNumber>
                                    thisPrioNumber = int(prioInfoItem.split(":p:")[1])
                                    thisPrioElementName = prioInfoItem.split(":p:")[0]
                                    opAndSortPriorities[specName][thisPrioElementName] = thisPrioNumber


        # Now that data ops and sorts are determined we can parse for sorts, operators and predictates
        for decAx in dgNode:
            for entry in decAx:
                if entry.tag == "Symbol":
                    if entry.attrib['kind'] == 'sort':
                        sName = entry.attrib['name']
                        sort = CaslSort(sName)
                        sSortArr = entry.text.split("<")
                        if len(sSortArr) == 2:
                            pSort = sSortArr[1].strip()
                            sort.parent = pSort

                        if sName in opAndSortPriorities[specName].keys():
                            sort.priority = opAndSortPriorities[specName][sName]
                        else:
                            sort.priority = 1
                        
                        if sName in dataSorts[specName]:
                            sort.isDataSort = True
                            sort.priority = 0
                        else:
                            sort.isDataSort = False

                        if sort.name == "PriorityDummySort":
                            sort.priority = 0

                        sortExists = False
                        # Check if this sort already exists, possibly without parent sort assignment. 
                        for exSort in thisSpec.sorts:
                            if exSort.name == sort.name:
                                sortExists = True
                                if sort.parent != '' and exSort.parent == '':
                                    exSort.parent = sort.parent
                                break
                        if sortExists == False:
                            thisSpec.sorts.append(sort)
                        
                    if entry.attrib['kind'] == 'op':
                        op = CaslOp.byStr(entry.text)
                        # print "op"
                        # print op.name 
                        if op.name in opAndSortPriorities[specName].keys():
                            op.priority = opAndSortPriorities[specName][op.name]
                        else:
                            op.priority = 1

                        if op.name in dataOps[specName]:
                            op.isDataOp = True
                            op.priority = 0
                        else:
                            op.isDataOp = False
                            # print op.name + " is not removable"

                        if op.name == "prioDummyOp":
                            op.priority = 0

                        
                        thisSpec.ops.append(op)
                        
                    if entry.attrib['kind'] == 'pred':
                        pred = CaslPred.byStr(entry.text)
                        if pred.name in opAndSortPriorities[specName].keys():
                            pred.priority = opAndSortPriorities[specName][pred.name]
                        else:
                            pred.priority = 1
                        thisSpec.preds.append(pred)   
        # Add axioms
        for decAx in dgNode:
            for entry in decAx:                
                if entry.tag == "Axiom":
                    
                    name = ''
                    if 'name' in entry.attrib.keys():
                        name = entry.attrib['name']
                                        
                    for subEntry in entry:
                        if subEntry.tag == "Text":
                            axStr = subEntry.text
                            if axStr == '':
                                continue
                            ax = CaslAx(axCtr,name,axStr)
                            
                            # Check priority:
                            priority = 1
                            if name.find(":p:") != -1 and name.find("--") == -1:
                                priority = int(name.split(":p:")[1].split(":")[0])                        
                            if 'priority' in entry.attrib.keys():
                                priority = int(entry.attrib['priority'])
                            ax.priority = priority

                            # If this is an axiom stating that a data op is not equal to a data op, it is a data axiom.
                            axStrArr = axStr.split(" ")
                            predOpNames = []
                            if len(axStrArr) == 5:
                                if axStrArr[4] in dataOps[specName] and axStrArr[2] in dataOps[specName]:
                                    ax.isDataAxiom = True
                            if axStr.find("generated type") == 0:
                                ax.isDataAxiom = True
                            if ax.isDataAxiom:
                                ax.priority = 0
                            if ax.axStr.find("prioDummyOp") != -1:
                                ax.priority = 0

                            thisSpec.axioms.append(copy.deepcopy(ax))
                    axCtr = axCtr + 1
        thisSpec.setInfoValue()
        specs.append(copy.deepcopy(thisSpec))
    return specs
    
# Turn CASL specs in their internal data structure into a Logic Programming specification that is compatible with the ASP files. 
def toLP(caslSpecs):
    lpStr = ""
    isFirst = True
    for s in caslSpecs:
        if isFirst:
            lpStr = lpStr + "specProvidesVocabulary("+toLPName(s.name,"spec")+"). \n \n "
            isFirst = False
        lpStr = lpStr + s.toLP()
        lpStr += "\n\n\n"
    
    return lpStr
    
def getActFromAtom(a):    
    # print a
    if a[:4] != "exec":
        print "Error, this is not an action atom."
        exit(0)
    actStr = a[5:-1]
    act = {}
    actStrArr = actStr.split(",")
    act["step"] = int(actStrArr[len(actStrArr)-1])
    act["iSpace"] = actStrArr[len(actStrArr)-2]
    atomicActStr = ""
    # re-assemble first parts of this string to obtain the atomic generalization action string.
    for item in actStrArr:
        if item == actStrArr[len(actStrArr)-2]:
            break
        atomicActStr = atomicActStr + item + ","
    atomicActStr = atomicActStr[:-1]
    # print atomicActStr
    act["actType"] = atomicActStr.split("(")[0]
    act["argVect"] = atomicActStr.split("(")[1][:-1].split(",")
    return act


def getGeneralisedSpaceTuples(atoms, originalInputSpaces):
    global renamingMode

    genInputSpaceTuples = []

    inputSpaceTupleSpecs = {}
    for spec in originalInputSpaces:
        inputSpaceTupleSpecs[spec.name] = copy.deepcopy(spec)

    ## There is no initial generalisation action:
    firstGeneralisationAct = {}
    generalisationTuple = GeneralisedCaslSpecTuple(firstGeneralisationAct,inputSpaceTupleSpecs)
    genInputSpaceTuples.append(copy.deepcopy(generalisationTuple))

    # # modify CASL data according to Answer Set atoms. We assume one action per step.
    acts = {}
    for atom in atoms:
        a = str(atom)
        if a[:4] == "exec":
            act = getActFromAtom(a)
            acts[act["step"]] = act

    for step in sorted(acts.keys()):
        act = acts[step]
        # print act
        ## Also add the next generalisation action to the last tuple in the list. 
        genInputSpaceTuples[-1].nextGenAction = act
        cSpec = generalisationTuple.specs[lpToCaslStr(act["iSpace"])]
        newCompressionValue = 0
        
        ########################## BEGIN renaming actions ########################## 
        if act["actType"] in ["renamePred","renameSort","renameOp"]:
            specToName = lpToCaslStr(act["argVect"][2])   
            targetSpec = generalisationTuple.specs[specToName]
            eleFrom = lpToCaslStr(act["argVect"][0])
            eleTo = lpToCaslStr(act["argVect"][1])
            if renamingMode == "mergeNames":
                newEleName = eleFrom + "_" + eleTo
            else: 
                newEleName = eleTo

            # Get axioms in spec that involve the element and rename the operator in them. 
            for ax in cSpec.axioms:
                newAxStr = renameEleInAxiom(ax.axStr, eleFrom, newEleName)
                ax.axStr = newAxStr
            
            # Also rename element in all axioms in target spec. 
            for ax in targetSpec.axioms:                
                newAxStr = renameEleInAxiom(ax.axStr, eleTo, newEleName)
                ax.axStr = newAxStr 

            # Set generalisation steps and rename target spec.
            targetSpec.generalisationSteps = targetSpec.generalisationSteps + 1            
            targetSpec.name = specToName + "_gen_" + str(targetSpec.generalisationSteps)

        if act["actType"] == "renameOp" :            
            # Rename element in spec and add priority to compression value
            for op in cSpec.ops:
                if op.name == eleFrom:
                    cSpec.ops.remove(op)
                    newOp = copy.deepcopy(op)
                    newOp.name = newEleName
                    cSpec.ops.append(newOp)
                    ## Multiply by 100 to allow for more precise blend value computation
                    newCompressionValue += op.priority
                    break
            
            # Rename also element in target spec and add priority to compression value
            for tmpOpTo in targetSpec.ops:
                if tmpOpTo.name == eleTo:
                    tmpOpTo.name = newEleName
                    newCompressionValue += tmpOpTo.priority
                    break
            
        if act["actType"] == "renamePred" :
            # Rename element in spec and add priority to compression value
            for p in cSpec.preds:
                if p.name == eleFrom:
                    cSpec.preds.remove(p)                     
                    newPred = copy.deepcopy(p)
                    newPred.name = newEleName
                    cSpec.preds.append(newPred)
                    newCompressionValue += p.priority
                    break
                    
            # Rename also element in target spec and add priority to compression value
            specToName = lpToCaslStr(act["argVect"][2])
            for tmpPredTo in generalisationTuple.specs[specToName].preds:
                if tmpPredTo.name == eleTo:  
                    tmpPredTo.name = newEleName
                    newCompressionValue += tmpPredTo.priority
                    break

        if act["actType"] == "renameSort" :
            # Rename element in spec and add priority to compression value
            for s in cSpec.sorts:
                if s.name == eleFrom:
                    cSpec.sorts.remove(s)
                    newSort = copy.deepcopy(s)
                    newSort.name = newEleName
                    cSpec.sorts.append(newSort)
                    newCompressionValue += s.priority
                    break
            # Also add priority of sort to which we rename to compression value
            for tmpSortTo in targetSpec.sorts:
                if tmpSortTo.name == eleTo:
                    tmpSortTo.name = newEleName
                    newCompressionValue += tmpSortTo.priority
                    break
                    

            # change parent sorts of other sorts in this spec. 
            for s in cSpec.sorts:
                if s.parent == eleFrom:
                    s.parent = newEleName
                    break
            # change parent sorts of other sorts in target spec.
            for s in targetSpec.sorts:
                if s.parent == eleTo:
                    s.parent = newEleName
                    break                        

            # change sorts in operators of this spec
            for op in cSpec.ops:
                # change domain sort. 
                if op.dom == eleFrom:
                    op.dom = newEleName
                for n,opSort in enumerate(op.args):
                    if opSort == eleFrom:
                        op.args[n] = newEleName

            # change sorts in operators of target spec
            for op in targetSpec.ops:
                # change domain sort. 
                if op.dom == eleTo:
                    op.dom = newEleName
                for n,opSort in enumerate(op.args):
                    if opSort == eleTo:
                        op.args[n] = newEleName

            # change sorts in predicates
            for p in cSpec.preds:
                # change domain sort. 
                for n,pSort in enumerate(p.args):
                    if pSort == eleFrom:
                        p.args[n] = newEleName

            # change sorts in predicates
            for p in targetSpec.preds:
                # change domain sort. 
                for n,pSort in enumerate(p.args):
                    if pSort == eleTo:
                        p.args[n] = newEleName                        
        
        ########################## END renaming actions ########################## 

        ########################## BEGIN removal actions ########################## 
        if act["actType"] == "rmOp" :
            for op in cSpec.ops:
                if toLPName(op.name,"po") == act["argVect"][0]:
                    cSpec.ops.remove(op)
                    break                                    
        if act["actType"] == "rmPred" :
            for p in cSpec.preds:
                if toLPName(p.name,"po") == act["argVect"][0]:
                    cSpec.preds.remove(p)
                    break
        if act["actType"] == "rmSort" :
            for srt in cSpec.sorts:
                if toLPName(srt.name,"sort") == act["argVect"][0]:
                    cSpec.sorts.remove(srt)
                    break
        if act["actType"] == "rmAx" :
            for a in cSpec.axioms:
                if str(a.id) == act["argVect"][0]:
                    cSpec.axioms.remove(a)
                    break
        ########################## END removal actions ########################## 

        ########################## BEGIN genSort     ########################## 
        if act["actType"] == "genSort" :
            sFrom = act["argVect"][0]
            sTo = act["argVect"][1]
            print "generalising sort " + sFrom + " to " + sTo
            for s in cSpec.sorts:
                if toLPName(s.name,"sort") == sFrom:
                    cSpec.sorts.remove(s)
                    newSort = copy.deepcopy(s)
                    newSort.name = lpToCaslStr(sTo)
                    cSpec.sorts.append(newSort)                                    

            # change parent sorts of other sorts in this spec.
            for s in cSpec.sorts:
                if toLPName(s.parent,"sort") == sFrom:
                    s.parent = lpToCaslStr(sTo)
                    break                            

            # Get axioms that involve the sort and rename the sorts
            for ax in cSpec.axioms:
                newAxStr = renameEleInAxiom(ax.axStr, lpToCaslStr(sFrom), lpToCaslStr(sTo))
                ax.axStr = newAxStr

            # change sorts in operators
            for op in cSpec.ops:
                # change domain sort. 
                if op.dom == lpToCaslStr(sFrom):
                    op.dom = newSort.name
                for n,opSort in enumerate(op.args):
                    if opSort == lpToCaslStr(sFrom):
                        op.args[n] = newSort.name

            # change sorts in predicates
            for p in cSpec.preds:
                # change domain sort. 
                for n,pSort in enumerate(p.args):
                    if pSort == lpToCaslStr(sFrom):
                        p.args[n] = newSort.name
        ########################## END genSort     ########################## 

        ## Set compression value of tuple, which is identical to compression value of individual specs. 
        generalisationTuple.compressionValue +=  (newCompressionValue * 100)
        cSpec.compressionValue = generalisationTuple.compressionValue
        
        if act["actType"] in ["renamePred","renameSort","renameOp"]:
            specToName = lpToCaslStr(act["argVect"][2])   
            targetSpec = generalisationTuple.specs[specToName]
            targetSpec.compressionValue = generalisationTuple.compressionValue

        generalisationTuple.lastGenAction = act
        cSpec.generalisationSteps = cSpec.generalisationSteps + 1
        cSpec.name = lpToCaslStr(act["iSpace"]) + "_gen_" + str(cSpec.generalisationSteps)
        cSpec.setInfoValue()
        
        genInputSpaceTuples.append(copy.deepcopy(generalisationTuple))
    
    # for genTuple in genInputSpaceTuples:
        # print genTuple.printInfo()

    return genInputSpaceTuples




# This function works, but it should be more sophisticated and use logical equivalence instead of syntactic equality to check if axioms are equal. 
def getNewAxIdOpRename(axId,op1,op2):
    axInt = int(str(axId))
    op1Str = str(op1)
    op2Str = str(op2)
    global axMap
    # print "Assigning new axiom Id after renaming " + str(op1Str) + " to " + str(op2Str)
    # TODO: This is probably very slow. I have to find another data type that allows of 1-1 mappings with hashing. 
    reverseAxMap = {value:key for key, value in axMap.iteritems()}
    # get original axiom string
    axStr = reverseAxMap[axInt]
    # Now apply renaming operations. Replace ech occurrence of op1, that is not surrounded by alphanumerical symbols a-zA-Z0-9 (encoded as \w in regex), with op2
    newAxStr = re.sub("(?<!\w)"+op1Str+"(?!\w)", op2Str, axStr)
    # print "Replaced " + axStr + " with " + newAxStr
    # exit(0)
    # now add new string to global axiom dictionary if it does not exist already.
    if newAxStr in axMap.keys():
        axId = axMap[newAxStr]
        # print "New ax exists. ID: " + str(axId)
    else:
        if len(axMap.keys()) == 0:
            # this should not happen because there should be at least one axiom when renaming an axiom.
            print "WARNING!! This should not happen. In function: getAxIdOpRename, in langCasl.py"
            exit(0)
        else:
            axId = max(axMap.values())+1
        # print "New ax does not exist. ID: " + str(axId)
        axMap[newAxStr] = axId
    return axId

def getEquivalenceClass(axStr):
    global axEqClasses

    # print "getting new eqClass for " 
    # print axStr

    for eqClassId in axEqClasses.keys():
        if isEquivalent(axStr,axEqClasses[eqClassId]):
            return eqClassId

    newEqClassId = len(axEqClasses)
    axEqClasses[newEqClassId] = axStr
    return newEqClassId


def renameEleAndGetNewEqClass(eqClassId,element,eleFrom,eleTo):
    global axEqClasses

    axStr = axEqClasses[int(eqClassId)]    

    # print "renaming " + str(eleFrom) + " to " + str(eleTo) + " in axiom " + str(axStr)
    newAxStr = renameEleInAxiom(axStr,lpToCaslStr(str(eleFrom)),lpToCaslStr(str(eleTo)))

    # This is necessary to normalize (aggregate) variable list in string
    if axStr != newAxStr:
        newAxStr = aggregateSortsInQuanti(newAxStr)

    return getEquivalenceClass(newAxStr)


def isEquivalent(axStr1,axStr2):
    return axStr1 == axStr2

def renameEleInAxiom(axStr, eleFrom,eleTo):
    return re.sub("(?<!\w)"+eleFrom+"(?!\w)",eleTo,axStr)
