%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This contains the LP interface for the amalgams module for the language CASL, extended with priorities. 
%% OUTPUT:
%% The module triggers the following atoms which are needed in the language-independent part of the amalgamation module:
%% 1. non-equality of conceptual spaces 
%% 		-- notEqual(<spec>,<spec>,t)
%% 2. Definition of atomic generalisation operations 
%% 		-- a(<act>) 					%% the declaration of an operation
%%		-- poss(<act>,<spec>,t)			%% the language specific precondition of an operation
%%		-- cost(<act>,<spec>,<cost>)	%% the cost of an action
%%		-- val(<act>,<spec>,<cost>)		%% the value of an action
%% INPUT:
%% The module relies on the following axioms which are produced by the language-independent part of the amalgamation module:
%% 1. Execution of an operation
%% 		-- exec(<act>,<spec>,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Main Interface  Part %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% The base program is iteration independent. These are just some auxiliary predicates.
#program  base. 

% The specification that provides the vocabulary is the one with the lowest id (for now). 
specProvidesVocabulary(Spec1) :- spec(Spec1), hasId(Spec1,Id1), 0{spec(Spec2) : hasId(Spec2,Id2), Id2 > Id1}0.

%%%% Operator declaration %%%%

% Removal operators
a(rmOp(Op),Spec) 		:- removableOp(Spec,Op).
a(rmPred(Pred),Spec) 	:- removablePred(Spec,Pred).
a(rmSort(Sort),Spec) 	:- removableSort(Spec,Sort).
a(rmAx(Ax),Spec) 		:- removableAx(Spec,Ax).

% Renaming operators. Only non-data elements can be renamed.
a(renameOp(Op1,Op2,Spec2),Spec1) 		:- 	hasOp(Spec1,Op1,0), hasOp(Spec2,Op2,0), Spec1 != Spec2, Op1 != Op2, 
											isNonDataOp(Spec1,Op1), isNonDataOp(Spec2,Op2).
%% a(renamedToOp(Op2),Spec2)				:-  a(renameOp(_,Op2,Spec2),_).											

% Renaming predicates.
a(renamePred(Pred1,Pred2,Spec2),Spec1) 	:- 	hasPred(Spec1,Pred1,0), hasPred(Spec2,Pred2,0), Spec1 != Spec2, Pred1 != Pred2.
%% a(renamedToPred(Pred2),Spec2) 			:-  a(renamePred(Pred1,Pred2,Spec2),Spec1).

% Renaming sorts.
a(renameSort(Sort1,Sort2,Spec2),Spec1) 	:- 	hasSort(Spec1,Sort1,0), hasSort(Spec2,Sort2,0), Spec1 != Spec2, Sort1 != Sort2,
											isNonDataSort(Spec1,Sort1), isNonDataSort(Spec2,Sort2).
%% a(renamedToSort(Sort2),Spec2)			:- 	a(renameSort(Sort1,Sort2,Spec2),Spec1).

%%%% Cost of actions %%%%
% Cost of removal actions is equal to priority of the elements to be removed.  
cost(rmOp(Op),Spec,C) 		:- a(rmOp(Op),Spec), 		opHasPriority(Spec,Op,C).
cost(rmPred(Pred),Spec,C) 	:- a(rmPred(Pred),Spec), 	predHasPriority(Spec,Pred,C).
cost(rmSort(Sort),Spec,C) 	:- a(rmSort(Sort),Spec), 	sortHasPriority(Spec,Sort,C).
cost(rmAx(Ax),Spec,C) 		:- a(rmAx(Ax),Spec), 		axHasPriority(Spec,Ax,C).
% Value of renaming actions is equal to priority.
val(renameOp(Op1,Op2,Spec2),Spec1,V)		:- a(renameOp(Op1,Op2,Spec2),Spec1),			opHasPriority(Spec1,Op1,P),		V = P.
%% val(renamedToOp(Op),Spec,V)					:- a(renamedToOp(Op),Spec),						opHasPriority(Spec,Op,P),		V = P.
val(renamePred(Pred1,Pred2,Spec2),Spec1,V)	:- a(renamePred(Pred1,Pred2,Spec2),Spec1),		predHasPriority(Spec1,Pred1,P),	V = P.
%% val(renamedToPred(Pred),Spec,V)				:- a(renamedToPred(Pred),Spec),					predHasPriority(Spec,Pred,P),	V = P.
val(renameSort(Sort1,Sort2,Spec2),Spec1,V)	:- a(renameSort(Sort1,Sort2,Spec2),Spec1),		sortHasPriority(Spec1,Sort1,P),	V = P.
%% val(renamedToSort(Sort),Spec,V)				:- a(renamedToSort(Sort),Spec),					sortHasPriority(Spec,Sort,P),	V = P.

%%% Start to iterate over t.
#program cumulative(t).

%%%% Action preconditions %%%%%

%%% Removal Operators
% Remove Operator
poss(rmOp(Op),Spec,t) 		:- 	hasOp(Spec,Op,t),	removableOp(Spec,Op), exOtherSpecWithoutOp(Spec,Op,t),
								0{hasAxiom(Spec,Ax,t) : axInvolvesPredOp(Spec,Ax,Op,t)}0.
exOtherSpecWithoutOp(Spec1,Op,t) :- hasOp(Spec1,Op,t), not hasOp(Spec2,Op,t), spec(Spec2), Spec1 != Spec2. 

% Remove Predicate
poss(rmPred(Pred),Spec,t) 	:- 	hasPred(Spec,Pred,t), removablePred(Spec,Pred), exOtherSpecWithoutPred(Spec,Pred,t), 
								0{hasAxiom(Spec,Ax,t) : axInvolvesPredOp(Spec,Ax,Pred,t)}0.
exOtherSpecWithoutPred(Spec1,Pred,t) :- hasPred(Spec1,Pred,t), not hasPred(Spec2,Pred,t), spec(Spec2), Spec1 != Spec2. 

% Remove Axiom
poss(rmAx(Ax),Spec,t) 		:- 	hasAxiom(Spec,Ax,t), removableAx(Spec,Ax), exOtherSpecWithoutEqivAx(Spec,Ax,t).
exOtherSpecWithoutEqivAx(Spec1,Ax,t) 	:- 	hasAxiom(Spec1,Ax,t), 0{axEquivalent(Spec1,Ax,Spec2,_,t)}0, 
											spec(Spec2), Spec1 != Spec2. 
% Remove Sort 
poss(rmSort(Sort),Spec,t) 	:- 	hasSort(Spec,Sort,t), removableSort(Spec,Sort), exOtherSpecWithoutSort(Spec,Sort,t),
								isNotParentSort(Spec,Sort,t),
								noOpUsesSort(Spec,Sort,t), noPredUsesSort(Spec,Sort,t), noAxUsesSort(Spec,Sort,t).
exOtherSpecWithoutSort(Spec1,Sort,t) :- hasSort(Spec1,Sort,t), not hasSort(Spec2,Sort,t), spec(Spec2), Spec1 != Spec2. 								

isNotParentSort(Spec,Sort,t) 	:- 	0{hasParentSort(Spec,_,Sort,t)}0, 							hasSort(Spec,Sort,t).
noOpUsesSort(Spec,Sort,t) 		:- 	0{hasOp(Spec,Op,t) : opHasSort(Spec,Op,Sort,_,t)}0, 		hasSort(Spec,Sort,t).
noPredUsesSort(Spec,Sort,t) 	:- 	0{hasPred(Spec,Pred,t) : predHasSort(Spec,Pred,Sort,_,t)}0, hasSort(Spec,Sort,t).
noAxUsesSort(Spec,Sort,t) 		:- 	0{hasAxiom(Spec,Ax,t) : axInvolvesSort(Spec,Ax,Sort,t)}0, 	hasSort(Spec,Sort,t).


%%% Rename Operator
poss(renameOp(Op1,Op2,Spec2),Spec1,t) :- 	a(renameOp(Op1,Op2,Spec2),Spec1), 
											hasOp(Spec1,Op1,t), hasOp(Spec2,Op2,t),
											not exec(rmOp(Op2),Spec2,t),
											not opSortsNotEquivalent(Spec1,Op1,Spec2,Op2,t), 
											not hasOp(Spec1,Op2,t), not hasOp(Spec2,Op1,t),
											specProvidesVocabulary(Spec2).
%% poss(renamedToOp(Op2),Spec2,t) :- exec(renameOp(_,Op2,Spec2),_,t). 											

%%% Rename Predicate
poss(renamePred(Pred1,Pred2,Spec2),Spec1,t) :- 	a(renamePred(Pred1,Pred2,Spec2),Spec1), 
												hasPred(Spec1,Pred1,t), hasPred(Spec2,Pred2,t), 
												not exec(rmPred(Pred2),Spec2,t),
												not predSortsNotEquivalent(Spec1,Pred1,Spec2,Pred2,t), 
												not hasPred(Spec1,Pred2,t), not hasPred(Spec2,Pred1,t),
												specProvidesVocabulary(Spec2).
%% poss(renamedToPred(Pred2),Spec2,t) :- exec(renamePred(_,Pred2,Spec2),_,t). 																							
%%% Rename Sort
poss(renameSort(Sort1,Sort2,Spec2),Spec1,t) :- 	a(renameSort(Sort1,Sort2,Spec2),Spec1), 
												hasSort(Spec1,Sort1,t), hasSort(Spec2,Sort2,t), 
												not exec(rmSort(Sort2),Spec2,t),
												not hasSort(Spec1,Sort2,t), not hasSort(Spec2,Sort1,t),
												specProvidesVocabulary(Spec2).
%% poss(renamedToSort(Sort2),Spec2,t) :- exec(renameSort(_,Sort2,Spec2),_,t). 																											
%%%% Equality of conceptual spaces %%%%
%% equal(Spec,Spec,t) 		:- 	spec(Spec).
%% equal(Spec1,Spec2,t) 	:- 	not notEqual(Spec1,Spec2,t), spec(Spec1), spec(Spec2).

notEqual(Spec1,Spec2,t) :- opNotEquivalent(Spec1,Spec2,_,t).
notEqual(Spec1,Spec2,t) :- predNotEquivalent(Spec1,Spec2,_,t).
notEqual(Spec1,Spec2,t) :- sortNotEquivalent(Spec1,Spec2,_,t).
notEqual(Spec1,Spec2,t) :- axNotEquivalent(Spec1,Spec2,_,t).


sortNotEquivalent(Spec1,Spec2,Sort,t) 	:- hasSort(Spec1,Sort,t), 	spec(Spec2), not sortEquivalent(Spec1,Spec2,Sort,t), Spec1 != Spec2.
sortNotEquivalent(Spec1,Spec2,Sort,t) 	:- hasSort(Spec1,Sort,t), 	spec(Spec2), not hasSort(Spec2,Sort,t), Spec1 != Spec2.
opNotEquivalent(Spec1,Spec2,Op,t) 		:- hasOp(Spec1,Op,t), 		spec(Spec2), not opEquivalent(Spec1,Spec2,Op,t), Spec1 != Spec2.
opNotEquivalent(Spec1,Spec2,Op,t) 		:- hasOp(Spec1,Op,t), 		spec(Spec2), not hasOp(Spec2,Op,t), Spec1 != Spec2.
predNotEquivalent(Spec1,Spec2,Pred,t) 	:- hasPred(Spec1,Pred,t), 	spec(Spec2), not predEquivalent(Spec1,Spec2,Pred,t), Spec1 != Spec2.
predNotEquivalent(Spec1,Spec2,Pred,t) 	:- hasPred(Spec1,Pred,t), 	spec(Spec2), not hasPred(Spec2,Pred,t), Spec1 != Spec2.
axNotEquivalent(Spec1,Spec2,Ax1,t)		:- hasAxiom(Spec1,Ax1,t), 	spec(Spec2), 0{axEquivalent(Spec1,Ax1,Spec2,Ax2,t)}0, Spec1 != Spec2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Language Specific Part %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Constraints on action execution.
% If something is renamed, then, from perspective of the other specification it is renamed to this specification.
%% exec(renamedToOp(Op2),Spec2,t) 		:-  exec(renameOp(Op1,Op2,Spec2),Spec1,t).	
%% exec(renamedToPred(Pred2),Spec2,t) 	:-  exec(renamePred(Pred1,Pred2,Spec2),Spec1,t).	
%% exec(renamedToSort(Sort2),Spec2,t) 	:-  exec(renameSort(Sort1,Sort2,Spec2),Spec1,t).	

%%% Determine removability of elements. This is static and hence belongs to the base part of the LP.
#program base.
% Only non-data elements with a priority != -1 can be removed. (Setting priority to -1 is a workaround to manually define non-removable elements in a spec.)
removableOp(Spec,Op) 		:- isNonDataOp(Spec,Op), not opHasPriority(Spec,Op,-1).
removablePred(Spec,Pred) 	:- predHasPriority(Spec,Pred,P), P != -1.
removableSort(Spec,Sort) 	:- isNonDataSort(Spec,Sort), not sortHasPriority(Spec,Sort,-1).
removableAx(Spec,Ax) 		:- isNonDataAx(Spec,Ax), not axHasPriority(Spec,Ax,-1).

%%%% Inertia rules for sorts, operators, predicates and axioms. This is dynamic and we need to iterate over t, hence we have a cumulative part again.
#program cumulative(t).
noninertial(Spec,Ax,t)		:- 	exec(rmAx(Ax),Spec,t).
noninertial(Spec,Op,t)		:- 	exec(rmOp(Op),Spec,t).
noninertial(Spec,Op,t)		:- 	exec(renameOp(Op,_,_),Spec,t).
noninertial(Spec,Pred,t)	:-	exec(rmPred(Pred),Spec,t).
noninertial(Spec,Pred,t)	:- 	exec(renamePred(Pred,_,_),Spec,t).
noninertial(Spec,Sort,t)	:-	exec(rmSort(Sort),Spec,t).
noninertial(Spec,Sort,t)	:-	exec(renameSort(Sort,_,_),Spec,t).		


hasAxiom(Spec,Ax,t+1) 	:- 	hasAxiom(Spec,Ax,t), 	not noninertial(Spec,Ax,t).
hasOp(Spec,Op,t+1) 		:- 	hasOp(Spec,Op,t), 		not noninertial(Spec,Op,t).
hasPred(Spec,Pred,t+1) 	:- 	hasPred(Spec,Pred,t), 	not noninertial(Spec,Pred,t).
hasSort(Spec,Sort,t+1) 	:- 	hasSort(Spec,Sort,t), 	not noninertial(Spec,Sort,t).

axInvolvesPredOp(Spec,Ax,PredOp,t+1)	:- axInvolvesPredOp(Spec,Ax,PredOp,t),	not noninertial(Spec,PredOp,t), not noninertial(Spec,Ax,t).
axInvolvesSort(Spec,Ax,Sort,t+1) 		:- axInvolvesSort(Spec,Ax,Sort,t), 		not noninertial(Spec,Sort,t), 	not noninertial(Spec,Ax,t).

hasParentSort(Spec,Sort_child,Sort,t+1) :- hasParentSort(Spec,Sort_child,Sort,t),	not noninertial(Spec,Sort,t).
hasParentSort(Spec,Sort,Sort_par,t+1) 	:- hasParentSort(Spec,Sort,Sort_par,t), 	not noninertial(Spec,Sort,t).

opHasSort(Spec,Op,Sort,Pos,t+1) 		:- 	opHasSort(Spec,Op,Sort,Pos,t), 	   not noninertial(Spec,Op,t), not noninertial(Spec,Sort,t).
predHasSort(Spec,Pred,Sort,Pos,t+1) 	:- 	predHasSort(Spec,Pred,Sort,Pos,t), not noninertial(Spec,Pred,t), not noninertial(Spec,Sort,t).


%%%% Effect axioms of renamings for sorts, operators, predicates and axioms (i.e. quantifications and atoms in axioms)
% Effects of renaming sorts:
hasSort(Spec,Sort2,t+1) 					:-	hasSort(Spec,Sort1,t), 					exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
hasParentSort(Spec,Sort_child,Sort2,t+1) 	:-	hasParentSort(Spec,Sort_child,Sort1,t),	exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
hasParentSort(Spec,Sort2,Sort_par,t+1) 		:-	hasParentSort(Spec,Sort1,Sort_par,t), 	exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
opHasSort(Spec,Op,Sort2,Pos,t+1) 			:-	opHasSort(Spec,Op,Sort1,Pos,t),			exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
predHasSort(Spec,Pred,Sort2,Pos,t+1) 		:- 	predHasSort(Spec,Pred,Sort1,Pos,t), 	exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
axInvolvesSort(Spec,Ax,Sort2,t+1) 			:- 	axInvolvesSort(Spec,Ax,Sort1,t),		exec(renameSort(Sort1,Sort2,Spec2),Spec,t).
% Effects of renaming operators:
hasOp(Spec1,Op2,t+1) 						:-	hasOp(Spec1,Op1,t),						exec(renameOp(Op1,Op2,Spec2),Spec1,t).
opHasSort(Spec1,Op2,Sort,Pos,t+1)			:-	opHasSort(Spec1,Op1,Sort,Pos,t),		exec(renameOp(Op1,Op2,Spec2),Spec1,t).
axInvolvesPredOp(Spec1,Ax,Op2,t+1) 			:- 	axInvolvesPredOp(Spec1,Ax,Op1,t),		exec(renameOp(Op1,Op2,Spec2),Spec1,t).

% Effects of renaming predicates:
hasPred(Spec1,Pred2,t+1) 					:- 	hasPred(Spec1,Pred1,t),					exec(renamePred(Pred1,Pred2,Spec2),Spec1,t).
predHasSort(Spec1,Pred2,Sort,Pos,t+1)		:-	predHasSort(Spec1,Pred1,Sort,Pos,t),	exec(renamePred(Pred1,Pred2,Spec2),Spec1,t).
axInvolvesPredOp(Spec1,Ax,Pred2,t+1) 		:- 	axInvolvesPredOp(Spec1,Ax,Pred1,t),		exec(renamePred(Pred1,Pred2,Spec2),Spec1,t).

%%%% Equivalence of axioms, operators, predicates and sorts %%%%

% Sorts are equivalent if their names and parent sorts are equal. 
sortEquivalent(Spec1,Spec2,Sort,t) 	:- 	Spec1 != Spec2, hasSort(Spec1,Sort,t), hasSort(Spec2,Sort1,t), 
										hasParentSort(Spec1,Sort,PSort,t), hasParentSort(Spec2,Sort,PSort,t), 
										sortEquivalent(Spec1,Spec2,PSort,t).
% Sorts are equivalent if their names and are equal and they don't have parent sorts. 
sortEquivalent(Spec1,Spec2,Sort,t) 	:- 	Spec1 != Spec2, hasSort(Spec1,Sort,t), hasSort(Spec2,Sort,t), 
										0{hasParentSort(Spec1,Sort,PSort,t) : hasSort(Spec1,PSort,t)}0,
										0{hasParentSort(Spec2,Sort,PSort,t) : hasSort(Spec2,PSort,t)}0.						
																		
%  An operator is equivalent in two different specs if its sorts are equivalent. 
opEquivalent(Spec1,Spec2,Op,t) 				:- 	Spec1 != Spec2, hasOp(Spec1,Op,t), hasOp(Spec2,Op,t), 
												not opSortsNotEquivalent(Spec1,Spec2,Op,t). 
opEquivalent(Spec1,Spec2,Op,t)				:- 	opEquivalent(Spec2,Spec1,Op,t).

opSortsNotEquivalent(Spec1,Spec2,Op,t) 		:- 	Spec1 != Spec2, opSortsNotEquivalent(Spec1,Op,Spec2,Op,t).
opSortsNotEquivalent(Spec1,Op1,Spec2,Op2,t) :- 	Spec1 != Spec2, hasOp(Spec1,Op1,t), hasOp(Spec2,Op2,t), 
												opHasSort(Spec1,Op1,Sort,Pos,t), not opSortsEquivalentAtPos(Spec1,Op1,Spec2,Op2,Pos,t).
opSortsNotEquivalent(Spec1,Op1,Spec2,Op2,t) :- 	opSortsNotEquivalent(Spec2,Op2,Spec1,Op1,t).

opSortsEquivalentAtPos(Spec1,Op1,Spec2,Op2,Pos,t) 	:- 	Spec1 != Spec2, hasOp(Spec1,Op1,t), hasOp(Spec2,Op2,t),
														opHasSort(Spec1,Op1,Sort,Pos,t), opHasSort(Spec2,Op2,Sort,Pos,t),
														sortEquivalent(Spec1,Spec2,Sort,t).

%  A predicate is equivalent in two different specs if its sorts are equivalent. 
predEquivalent(Spec1,Spec2,Pred,t) 					:- 	Spec1 != Spec2, hasPred(Spec1,Pred,t), hasPred(Spec2,Pred,t), 
														not predSortsNotEquivalent(Spec1,Spec2,Pred,t). 
predEquivalent(Spec1,Spec2,Pred,t)					:- 	predEquivalent(Spec2,Spec1,Pred,t).													

predSortsNotEquivalent(Spec1,Spec2,Pred,t)			:- 	predSortsNotEquivalent(Spec1,Pred,Spec2,Pred,t).
predSortsNotEquivalent(Spec1,Pred1,Spec2,Pred2,t) 	:- 	Spec1 != Spec2, hasPred(Spec1,Pred1,t), hasPred(Spec2,Pred2,t), 
														predHasSort(Spec1,Pred1,Sort,Pos,t), not predSortsEquivalentAtPos(Spec1,Pred1,Spec2,Pred2,Pos,t).
predSortsNotEquivalent(Spec1,Pred1,Spec2,Pred2,t) 	:- 	predSortsNotEquivalent(Spec2,Pred2,Spec1,Pred1,t).														

predSortsEquivalentAtPos(Spec1,Pred1,Spec2,Pred2,Pos,t) 	:- 	Spec1 != Spec2, hasPred(Spec1,Pred1,t), hasPred(Spec2,Pred2,t), 
																predHasSort(Spec1,Pred1,Sort,Pos,t), predHasSort(Spec2,Pred2,Sort,Pos,t), 
																sortEquivalent(Spec1,Spec2,Sort,t).


axChanged(Spec1,Ax,op,Op1,Op2,t) 		:- exec(renameOp(Op1,Op2,Spec2),Spec1,t), axInvolvesPredOp(Spec1,Ax,Op1,t).
axChanged(Spec1,Ax,pred,Pred1,Pred2,t) 	:- exec(renamePred(Pred1,Pred2,Spec2),Spec1,t), axInvolvesPredOp(Spec1,Ax,Pred1,t).
axChanged(Spec1,Ax,sort,Sort1,Sort2,t) 	:- exec(renameSort(Sort1,Sort2,Spec2),Spec1,t), axInvolvesSort(Spec1,Ax,Sort1,t).
axChanged(Spec,Ax,t) :- axChanged(Spec,Ax,_,_,_,t).


axEquivalent(Spec1,Ax1,Spec2,Ax2,t) :- 	hasAxiom(Spec1,Ax1,t), axHasEquivalenceClass(Spec1,Ax1,C,t), 
										hasAxiom(Spec2,Ax2,t), axHasEquivalenceClass(Spec2,Ax2,C,t), Spec1 != Spec2.

axHasEquivalenceClass(Spec,Ax,EC,t+1) :- axHasEquivalenceClass(Spec,Ax,EC,t), not axChanged(Spec,Ax,t), hasAxiom(Spec,Ax,t).

axHasEquivalenceClass(Spec,Ax,ECNew,t+1) :- 	axHasEquivalenceClass(Spec,Ax,ECOld,t), axChanged(Spec,Ax,Element,EleFrom,EleTo,t), 
												hasAxiom(Spec,Ax,t), ECNew = @renameEleAndGetNewEqClass(ECOld,Element,EleFrom,EleTo).
