COINVENT Amalgamation Module 									
=================================

### Authors:
- Manfred Eppe (meppe@iiia.csic.es)
- Roberto Confalonieri (confalonieri@iiia.csic.es)
- Ewen MacLean (ewenmaclean@gmail.com)


### Overview
This is the amalgamation system which is the core of the blending process. The current state (22.04.15) should run on Ubuntu linux machines with some music examples and the example of blending the theory of naturals with the theory of lists to obtain some novel lemma for the theory of lists. 
It currently works with CASL only, and relies on HETS (via commandline-call) to compute colimits. In future versions it will rely also on language modules to have language-independence, and HDTP to improve generalization search. 

### Module file structure
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
	- iterationGeneralize-py.lp
		This is a Logic Programming file containting the main iteration loops for generalisation as a python script. 
	- caslInterface.lp
		This contains casl specific rules that are an interface to the main amalgamation search programs called generalize.lp. and blending.lp
	- generalize.lp
		This contains the core search rules to generalize towards the generic space. 

- Clingo binaries
	- There are two folders 32bit and 64bit for the respective clingo builds. In each folder there are two files:
		- clingo4 is the binary of clingo v.4.4.0. I complied it with python and lua support. 
		- gringo.so are the python libraries for clingo
	- If your system complains that python or lua are not found, do (in ubuntu): "sudo apt-get install python2.7 python2.7-dev lua5.1 lua5.1-policy-dev"


### Get started
The module will only run on a linux-based 64bit distribution, because of the clingo4 binary. If you want to run on another system (e.g. Mac), you have to get your own clingo4 binary. I suggest to use a Virtual Machine instead.
To run the blending, execute "run-blending.py" using python. By default it will do the naturals and lists example from the LPNMR paper (takes approx. 5 minutes on an i7 machine with 3gb ram). 
If you look at the settings.py, you'll also find a cadence fusion example to obtain the Tritone cadence, as described in the LPNMR and the 2015 IJCAI paper "Computational invention of cadences and chord progressions by conceptual chord-blending" by Eppe et al.  To run another example, adopt the file settings.py as follows:

	- change the "fName" var and provide the CASL file that contains two specifications to blend.
	- modify the "specsToBlend" variable and enter the two specs in the casl file that are to be blended. 
	- Priorities of axioms can be encoded in the axiom names by adding a substring ":p:<number>". Make sure that all prioritised axioms have different names.
	- Priorities of operators, predicates and sorts can be encoded in the name of a dummy-axiom that has the string ". prioDummyOp = prioDummyOp", by adding a substring "--<Sort, operator or predicate name>_p<number>", to the name of the dummy predicate. This requires to have a dummySort "PrioDummySort" and a dummy operator "prioDummyOperator" in each case Spec. If the axiom ". prioDummyOp = prioDummyOp" is not found in a specfication, then priorities will always be 1.
	- A priority of "-1" means that the axiom, operator, predicate or sort is fixed and not removable. 
	

### Important limitations, bugs and TODOs
	- Operator,  predicate and sort names must be disjoint in each specification, i.e. a operator name can 
	not be a predicate name or a sort name. Furthermore, overloading of operators or predicates is not supported. Otherwise this will result in unpredictable behavior.
	- Logical Equivalence of axioms is currently determined by syntactic equivalence. This is of course a much stronger form of equivalence and a serious limitation of the system.
	- IMPORTANT (from category theoretical point of view): If predicates or operator names are equal in different input specifications, they are considered to be equal. 
	- 0-ary predicates currently cause unpredictable behavior and are not supported.
	- There is a conceptual error in how the colimit makes the blend: Currently, the generic space contains all elements to which stuff is renamed. However, this causes a problem with the colimit. For example, let a predicate a in spec1 be renamed to a predicate b in spec2, so that in the generic space there is one predicate a_b which is mapped to both a and b in their respective specifications. Let spec1' and spec2' be more specific versions of spec1 and spec2, where the elements are not yet renamed. Then, blending spec1' and spec2' will cause the blend to have only one predicate a_b, as found in the generic space,l but what we want to have is both predicates a and b separately. This is correct in the sense that the colimit works this way, but its not how we had the blending in mind. Therefore, we need to have different generic spaces for each generalisation tuple. 
	The problem appears in commit 1284230. Compare Blend_v2050__House_4_Boat_3_b_21.casl and Blend_v1850__House_3_Boat_2_b_5_Blend.casl, which have to the same blend with a different value. 
	- This is probably the same problem as the one stated above: There is an unexpected (yet probably correct) behavior by the colimit, which messes up with the value computation of blends. In the colimit, different operators with the same sorts may be blended and at the same time renamed. This happens in commit 0bbd423 from 2nd Oct. 2015: E.G. consider Blend Blend_v28__House_2_Boat_3_b_42.casl. this is identical to a blend with a higher value, namely Blend_v30__House_2_Boat_4_b_60.casl. This should not be the case. It has something to do with the gray arrow from the input space to the blend in the HETS diagram. 
	- Each element in a spec can be only renamed once. Therefore, it is currently not possible to have more than two input specs. To change this, one has to change stuff in the function findLeastGeneralizedBlends, and in the amalgamTmp.casl file generation.
	- Another reason why only two input specs are supported is that the cross space mapping is currently designed for two input specs. 
	- Currently, the cross-space-mapping phase in the generalisation leads to several stable models with the same cross space mapping. This should not happen, because it slows things down and generates duplicate blends. Maybe we can define a total order for applying renaming actions to prevent this and to prune the search space. 
	- There is a problem that if two sorts in one spec get generalised to the same parent sort, the mappings are ambiguous when coming from the Generic Space upwards. E.g. Thing -> House and at the same time Thing -> Resident. 


