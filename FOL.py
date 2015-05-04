# This file contains classes that represent FOL expressions
import copy
from auxFunctions import *
import re
# An atom is a predicate with arguments, e.g. livesIn(person,house). We don't use reification. 
class Atom:
    def __init__(self,id,name,args) :
        self.id = id
        self.fName = name
        self.args = args
    
    def toCaslStr(self):
        oStr = self.fName
        if len(self.args) > 0:
            oStr += "("
            for arg in self.args:
                oStr += arg+","
            oStr = oStr[:-1]+")"
        return oStr
    
    def toLPStr(self,specName):
        oStr = ''
        oStr += "atomHasFName(" +specName+","+ self.id + "," + self.fName +",1).\n"
        argCtr = 0
        for arg in self.args:
            oStr += "atomHasArg("  +specName+","+ self.id + "," + str(argCtr) + "," + arg +",1).\n"
            argCtr = argCtr + 1
        return oStr

# A disjunct is part of a disjunction. It has a left hand side (lhs) if its a function statement and only a right hand side (rhs) if its a predicate statement. A left-hand-side or right-hand-side is an atom, i.e. a predicate or function name with arguments.
class Disjunct:
    def __init__(self,id) :
        self.id = id
        self.lhs = None 
        self.rhs = None
        self.negated = False
    
    def toCaslStr(self):
        oStr = ''
        if self.negated:
            oStr = oStr + "not "
        oStr = oStr + self.lhs.toCaslStr()
        if self.rhs != None:
            oStr = oStr + " = " + self.rhs.toCaslStr()
        return oStr
    
    def toLPStr(self, specName):            
        oStr = ''
        # oStr = "disjunct("+str(self.id)+").\n"
        if self.negated:
            oStr = oStr + "disjunctNegated("+str(self.id)+","+self.lhs.id+").\n"
        oStr = oStr + "disjunctHasLhs("+str(self.id)+","+self.lhs.id+").\n"
        oStr = oStr + self.lhs.toLPStr(toLPName(specName))
        if self.rhs != None:
            oStr += "disjunctHasRhs("+str(self.id)+","+self.rhs.id+").\n"
            oStr = oStr + self.rhs.toLPStr(toLPName(specName))
        return oStr

# A conjunct is a part of a conjunction
class Conjunct:
    def __init__(self,id) :
        self.disjuncts = set()
        self.id = id
    
    def toCaslStr(self):
        oStr = ""
        for d in self.disjuncts:
            oStr += d.toCaslStr()
            oStr += " \/ "
        if len(self.disjuncts) > 0:
            oStr = oStr[0:-4]
        if len(self.disjuncts) > 1:
            oStr = "(" + oStr + ")"
        return oStr
    
    def toLPStr(self,specName):   
        oStr = ''         
        # oStr = "conjunct("+str(self.id)+").\n"
        for d in self.disjuncts:
            oStr = oStr + "conjunctHasDisjunct("+str(self.id)+","+str(d.id)+").\n"
            oStr = oStr + d.toLPStr(toLPName(specName))
        return oStr

# This represents a quantification of a type (exists or forall) over several variables of different sorts.
class Quantification:
    def __init__(self,type,id,pos) :
        self.vars = {}      # vars are dictionaries where the keys are the original var strings and the values are generic var strings of the form <var>:<Sort>. 
        self.type = type    # the type is 'forall' or 'exists'
        self.id = id        # a unique id for this quantification
        self.pos = pos      # the position of this quantification in an axiom
    
    def toCaslStr(self):
        oStr = self.type + " "
        for var in self.vars.keys():
            # oStr =  oStr + var + " : " + self.vars[var].split(":")[1] + " ; "
            oStr =  oStr + self.vars[var] + " ; "
        oStr = oStr[:-3]
        return oStr
    
    def toLPStr(self, specName):            
        oStr = ''
        # oStr = "quantification("+str(self.id)+","+self.type+").\n"
        oStr += "quantificationHasPos("+str(self.id)+","+str(self.pos)+").\n"        
        oStr += "quantificationHasType("+str(self.id)+","+self.type+").\n"        
        for var in self.vars.keys():
            oStr += "quantificationHasVar("+str(self.id)+","+self.vars[var].split(":")[0]+","+toLPName(self.vars[var].split(":")[1])+",1).\n"
        return oStr


# This class represents a CASL Axiom.        
class CaslAx:    

    def __init__(self, id, name, axStr):
        self.id = id
        self.name = name
        self.axStr = axStr
        self.isDataAxiom = False # THis determines whether only data operators (generated type constants) are part of this axiom. Typicallay, such axioms denote, e.g., that natural numbers are not equal, that the boolean true is not equal to false, or that the tones of a chord (which are data operators) are not equal. 
        self.priority = 0
        # self.atoms = []
        self.involvedPredicates = {}
        self.involvedOperators = {}
        self.involvedSorts = {}
        # self.quantifications = [] # a list of quantifications. 
        # self.conjuncts = set() # This is a set of conjuncts. A conjunct is a set of disjuncts. A disjunct is a set of strings that represent atoms.
        self.fromAxStr(axStr)

    def getCaslAnnotationStr(self):
        aStr = ''
        aStr += "\t%("+self.name+")%\t%priority(" + str(self.priority) + ")%\t%%id:"+str(self.id)
        if self.isDataAxiom:
            aStr += "\t(data axiom)"
        return  aStr

    def toCaslStr(self):
        # if self.axStr.find("generated type") != -1:
            return "\t" + self.axStr + self.getCaslAnnotationStr() + "\n"
        # oStr = 
        if len(self.quantifications) > 0: 
            oStr += "\t"
        for q in self.quantifications:
            oStr += q.toCaslStr()
            oStr += " . "
        oStr = oStr[:-3]
        if len(self.quantifications) > 0:
            oStr = oStr + "\n\t"

        oStr += "\t. "
        for c in self.conjuncts:
            oStr += c.toCaslStr() +" /\ "
        if len(self.conjuncts) > 0:
            oStr = oStr[:-4]

        oStr += self.getCaslAnnotationStr() + "\n"

        # oStr = oStr + "\n"

        return oStr
        # return self.axStr + " " + "%("+self.name+")% \t " + "%priority(" + str(self.priority) + ")% \t %%rem:" + str(self.removable)+" %%id:"+str(self.id)+" \n"
        
    def toLPStr(self, specName):
        if self.axStr.find("generated type") != -1:
            return ""
        oStr = "\n%% Axiom " + self.name + " %%\n"
        oStr += "hasAxiom("+toLPName(specName)+","+str(self.id)+",1).\n"
        if self.isDataAxiom == False:
            oStr = oStr + "isNonDataAx("+toLPName(specName) +","+str(self.id)+").\n"
        else:
            oStr = oStr + "isDataAx("+toLPName(specName) +","+str(self.id)+").\n"
        oStr = oStr + "axHasPriority("+toLPName(specName) +","+str(self.id)+","+str(self.priority)+").\n"
        for q in self.quantifications:
            # oStr = oStr + "axHasQuantification("+str(self.id) + "," + str(q) + "," + self.quantifications[q].type + "," + self.quantifications[q].id +").\n"
            oStr = oStr + "axHasQuantification("+str(self.id) + "," + q.id +").\n"
            oStr = oStr + q.toLPStr(toLPName(specName))
        for c in self.conjuncts:
            oStr = oStr + "axHasConjunct("+str(self.id) + "," + c.id +").\n"
            oStr = oStr + c.toLPStr(toLPName(specName))

        return oStr

    # This generates the internal axiom representation from an axiom string in CASL
    def fromAxStr(self, text):
        if text.find("generated type") != -1:
            return True
        self.conjuncts = set()
      
        # first extract quantifications
        axStr = copy.deepcopy(text)
        
        # print "axiom"
        # print axStr    

        qId = 0
        axStr = axStr.replace("\n", "")
        while True:
            forallPos = axStr.find("forall")
            existsPos = axStr.find("exists")
            thisQType = ''
            if forallPos != -1:
                if existsPos == -1:
                    thisQType = 'fa'
                if forallPos < existsPos:
                    thisQType = 'fa'
            if existsPos != -1:
                if forallPos == -1:
                    thisQType = 'ex'
                if existsPos < forallPos:
                    thisQType = 'ex'
            
            # no quantification exists anymore
            if thisQType == '':
                break

            thisQId = "q"+str(qId) + "_" + str(self.id)

            if thisQType == 'fa':
                axStr = axStr[forallPos+len('forall'):]
                thisQ  =  Quantification('forall',thisQId,qId)
            if thisQType == 'ex':
                axStr = axStr[existsPos+len('exists'):]
                thisQ  =  Quantification('exists',thisQId,qId)

            qVars = []

            nextQPos = axStr.find(".")

            varsStr = axStr[:nextQPos]
            varsStr = re.sub(" ", "", varsStr)
            axStr = axStr[nextQPos+1:]

            origQVars = varsStr.split(';')
            qVars = {}
            varNum = 0
            for varSort in origQVars:
                sort = varSort.split(":")[1]
                var = varSort.split(":")[0]
                vName = "v"+str(varNum)+"_"+str(qId)#+"_"+var.split(":")[1].lower()
                qVars[var] = vName+":"+sort
                varNum = varNum + 1

                # Now replace original varname in axiom string with replacement. This helps to determine equivalence with a simple syntactic check. TODO: THis is still not really logical equivalence, because the order of variables within the same quantification matters. E.g. forall v1,v2. p(v1,v2) is not equivalent to forall v2,v1. p(v1,v2) in our framework, but it should be equivalent. 
                axStr = re.sub("(?<!\w)"+var.split(":")[0]+"(?!\w)",vName,axStr)

            thisQ.vars = qVars
            self.quantifications.append(copy.deepcopy(thisQ))
            qId = qId + 1
        
        # # Having all the quantifications, we can look at the conjuncts. First remove white spaces from string and then split by \wedge symbol /\
        axStr = axStr.replace("not ", "not#")
        axStr = axStr.replace(" ", "")
        axStr = axStr.replace(".", "")
        axStr = axStr.replace("not#", "not ")

        #remove opening and closing bracket for axiom string
        # if axStr[:1] == "(" and axStr[-1:] == ")":
        #     axStr = axStr[1:]
        #     axStr = axStr[:-1]
    

        conjuncts = axStr.split("/\\")

        conId = 0
        for con in conjuncts:
            thisCName = "c"+str(conId) + "_" + str(self.id)
            thisC = Conjunct(thisCName)

            # remove possible brackets at end and beginning of conjunct
            # if con[:1] == "(" and con[-1:] == ")":
            #     con = con[1:]
            #     con = con[:-1]
            
            # print "conjunct"
            # print con

            disjuncts = con.split("\\/")
            disId = 0
            for dis in disjuncts:
                thisDName = "d"+str(disId) + "_" + thisCName
                thisD = Disjunct(thisDName)
                
                # remove possible brackets at end and beginning of disjunct
                if dis[:1] == "(" and dis.count("(") == dis.count(")") + 1:
                    dis = dis[1:]
                if dis[-1:] == ")" and dis.count(")") == dis.count("(") + 1:
                    dis = dis[:-1]

                # print "disjunct"
                # print dis

                if dis.find("not ") == 0:
                    thisD.negated = True
                    dis = dis[4:]

                disLhsRhs = dis.split("=")
                # print "dislhsrhs"
                # print disLhsRhs
                name = disLhsRhs[0].split("(")[0]
                args = re.search("\(.*\)",disLhsRhs[0])
                argVect = []
                if args:
                    # print "args lhs"
                    # print args.group(0)
                    argVect = args.group(0)[1:-1].split(",")
                lhsId = "lhs_"+thisDName
                lhs = Atom(lhsId, name, argVect)
                thisD.lhs = lhs
                if len(disLhsRhs) == 2:
                    name = disLhsRhs[1].split("(")[0]
                    args = re.search("\(.*\)",disLhsRhs[1])
                    argVect = []
                    if args:
                        # print "args rhs"
                        # print args.group(0)
                        argVect = args.group(0)[1:-1].split(",")
                    rhsId = "lhs_"+thisDName
                    rhs = Atom(rhsId,name, argVect)
                    thisD.rhs = rhs

                # print "caslStr:"
                # print thisD.toCaslStr()

                thisC.disjuncts.add(copy.deepcopy(thisD))

                disId = disId + 1

            self.conjuncts.add(copy.deepcopy(thisC))
            # print "conjunct LP"
            # print thisC.toLPStr()
            conId = conId + 1

        # print "ax in LP"
        # print self.toLPStr("thisSpec")

        # print "ax in Casl"
        # print self.toCaslStr()

# 