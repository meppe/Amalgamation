************************************************************************
*** COINVENT Amalgamation Module 									 ***
*** author: Manfred Eppe (meppe@iiia.csic.es)						 ***
*** author: Roberto Confalonieri (confalonieri@iiia.csic.es)         ***
*** author: Ewen MacLean (ewenmaclean@gmail.com)        			 ***
************************************************************************

** OVERVIEW **
This is the amalgamation system which is the core of the blending process. The current state (22.04.15) should run on Ubuntu linux machines with some music examples and the example of blending the theory of naturals with the theory of lists to obtain some novel lemma for the theory of lists. 
It currently works with CASL only, and relies on HETS (via commandline-call) to compute colimits. In future versions it will rely also on language modules to have language-independence, and HDTP to improve generalization search. 

** MODULE FILE STRUCTURE **
- Python code:
	- run-blending.py 
		This is the file to be called to start the blending. It invokes the ASP solver clingo4, which in turn invokes Python for parsing and other stuff and HETS for computing colimits. 
	- langCasl.py 
		This is a language specific file to parse CASL specifications, and to produce CASL syntax output from the internal datastructure.
	- settings.py 
		This is used to set the casl input file, the number of stable models produced, and other things. 
	- blendFunctions.py
		This contains functions to perform the actual blending of the generalized input spaces. 

- Answer Set Programming code:
	- iterationCore-py.lp
		This is a Logic Programming file containting the main iteration loops as a python script. 
	- caslInterface.lp
		This contains casl specific rules that are an interface to the main amalgamation search programs called generalize.lp. and blending.lp
	- generalize.lp
		This contains the core search rules to generalize towards the generic space. 

- Clingo binary
	- clingo4 is the 64bit binary of clingo v.4.4.0. I complied it with python and lua support. 
	- gringo.so are the python libraries for clingo
	If your system complains that python or lua are not found, do (in ubuntu):
	
	sudo apt-get install python2.7 python2.7-dev lua5.1 lua5.1-policy-dev


** GET STARTED **
The module will only run on a linux-based 64bit distribution, because of the clingo4 binary. If you want to run on another system (e.g. Mac), you have to get your own clingo4 binary. I suggest to use a Virtual Machine instead.
To run the blending, execute "run-blending.py" using python. By default it will do a cadence fusion example to obtain the Tritone cadence, as described in the 2015 IJCAI paper "Computational invention of cadences and chord progressions by conceptual chord-blending" by Eppe et al.  To run another example, adopt the file settings.py.

If you want to do other blendings, modify the settings.py as follows:
	+ change the "fName" var and provide the CASL file that contains two specifications to blend.
	+ modify the "specsToBlend" variable and enter the two specs in the casl file that are to be blended. 
	+ Priorities of axioms can be encoded in the axiom names by adding a substring ":p:<number>". Make sure that all prioritised axioms have different names.
	+ Priorities of operators, predicates and sorts can be encoded in the name of a dummy-axiom that has the string ". prioDummyOp = prioDummyOp", by adding a substring "--<Sort, operator or predicate name>_p<number>", to the name of the dummy predicate. This requires to have a dummySort "PrioDummySort" and a dummy operator "prioDummyOperator" in each case Spec. If the axiom ". prioDummyOp = prioDummyOp" is not found in a specfication, then prioritis will always be 0.
	+ A priority of "-1" means that the axiom, operator, predicate or sort is fixed and not removable. 
	

** Important limitations and TODOs ** 
	+ Operator,  predicate and sort names must be disjoint in each specification, i.e. a operator name can 
	not be a predicate name or a sort name. Furthermore, overloading of operators or predicates is not supported. Otherwise this will result in unpredictable behavior.
	+ Logical Equivalence of axioms is currently determined by syntactic equivalence. This is of course a much stronger form of equivalence and a serious limitation of the system.
	+ IMPORTANT (from category theoretical point of view): If predicates or operator names are equal in different input specifications, they are considered to be equal. 
	+ 0-ary predicates currently cause unpredictable behavior and are not supported.


