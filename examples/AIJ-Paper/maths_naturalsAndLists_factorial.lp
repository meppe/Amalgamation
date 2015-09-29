#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Nat %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Nat).
hasId(spec_Nat,0).

%% sorts %%
hasSort(spec_Nat,sort_Element,0).
isNonDataSort(spec_Nat,sort_Element).
sortHasPriority(spec_Nat,sort_Element,17).

hasSort(spec_Nat,sort_Nat,0).
isNonDataSort(spec_Nat,sort_Nat).
sortHasPriority(spec_Nat,sort_Nat,16).

%% operators %%
hasOp(spec_Nat,po_canonical_element,0).
opHasSort(spec_Nat,po_canonical_element,sort_Element,domain,0).
isNonDataOp(spec_Nat,po_canonical_element).
opHasPriority(spec_Nat,po_canonical_element,1).

hasOp(spec_Nat,po_fact,0).
opHasSort(spec_Nat,po_fact,sort_Nat,arg1,0).
opHasSort(spec_Nat,po_fact,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_fact).
opHasPriority(spec_Nat,po_fact,10).

hasOp(spec_Nat,po_plus,0).
opHasSort(spec_Nat,po_plus,sort_Nat,arg1,0).
opHasSort(spec_Nat,po_plus,sort_Nat,arg2,0).
opHasSort(spec_Nat,po_plus,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_plus).
opHasPriority(spec_Nat,po_plus,6).

hasOp(spec_Nat,po_qfact,0).
opHasSort(spec_Nat,po_qfact,sort_Nat,arg1,0).
opHasSort(spec_Nat,po_qfact,sort_Nat,arg2,0).
opHasSort(spec_Nat,po_qfact,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_qfact).
opHasPriority(spec_Nat,po_qfact,10).

hasOp(spec_Nat,po_s,0).
opHasSort(spec_Nat,po_s,sort_Element,arg1,0).
opHasSort(spec_Nat,po_s,sort_Nat,arg2,0).
opHasSort(spec_Nat,po_s,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_s).
opHasPriority(spec_Nat,po_s,14).

hasOp(spec_Nat,po_times,0).
opHasSort(spec_Nat,po_times,sort_Nat,arg1,0).
opHasSort(spec_Nat,po_times,sort_Nat,arg2,0).
opHasSort(spec_Nat,po_times,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_times).
opHasPriority(spec_Nat,po_times,13).

hasOp(spec_Nat,po_zero,0).
opHasSort(spec_Nat,po_zero,sort_Nat,domain,0).
isNonDataOp(spec_Nat,po_zero).
opHasPriority(spec_Nat,po_zero,15).

%% predicates %%
%% axioms %%

%% Axiom Ax-qfactzerozero:p:9 %%
hasAxiom(spec_Nat,0,0).
axHasEquivalenceClass(spec_Nat,0,0,0).
isNonDataAx(spec_Nat,0).
axHasPriority(spec_Nat,0,9).
axInvolvesPredOp(spec_Nat,0,po_qfact,0).
axInvolvesPredOp(spec_Nat,0,po_zero,0).
axInvolvesSort(spec_Nat,0,sort_Nat,0).


%% Axiom Ax-timesPlusRel:p:3 %%
hasAxiom(spec_Nat,1,0).
axHasEquivalenceClass(spec_Nat,1,1,0).
isNonDataAx(spec_Nat,1).
axHasPriority(spec_Nat,1,3).
axInvolvesPredOp(spec_Nat,1,po_s,0).
axInvolvesPredOp(spec_Nat,1,po_plus,0).
axInvolvesPredOp(spec_Nat,1,po_canonical_element,0).
axInvolvesPredOp(spec_Nat,1,po_times,0).
axInvolvesSort(spec_Nat,1,sort_Nat,0).


%% Axiom Ax-heurekaLemmaNat:p:20 %%
hasAxiom(spec_Nat,2,0).
axHasEquivalenceClass(spec_Nat,2,2,0).
isNonDataAx(spec_Nat,2).
axHasPriority(spec_Nat,2,20).
axInvolvesPredOp(spec_Nat,2,po_qfact,0).
axInvolvesPredOp(spec_Nat,2,po_fact,0).
axInvolvesPredOp(spec_Nat,2,po_times,0).
axInvolvesSort(spec_Nat,2,sort_Nat,0).


%% Axiom targetTheoremNat:p:20 %%
hasAxiom(spec_Nat,3,0).
axHasEquivalenceClass(spec_Nat,3,3,0).
isNonDataAx(spec_Nat,3).
axHasPriority(spec_Nat,3,20).
axInvolvesPredOp(spec_Nat,3,po_qfact,0).
axInvolvesPredOp(spec_Nat,3,po_zero,0).
axInvolvesPredOp(spec_Nat,3,po_fact,0).
axInvolvesSort(spec_Nat,3,sort_Nat,0).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec List %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_List).
hasId(spec_List,1).

%% sorts %%
hasSort(spec_List,sort_El,0).
isNonDataSort(spec_List,sort_El).
sortHasPriority(spec_List,sort_El,17).

hasSort(spec_List,sort_L,0).
isNonDataSort(spec_List,sort_L).
sortHasPriority(spec_List,sort_L,16).

%% operators %%
hasOp(spec_List,po_app,0).
opHasSort(spec_List,po_app,sort_L,arg1,0).
opHasSort(spec_List,po_app,sort_L,arg2,0).
opHasSort(spec_List,po_app,sort_L,domain,0).
isNonDataOp(spec_List,po_app).
opHasPriority(spec_List,po_app,13).

hasOp(spec_List,po_cons,0).
opHasSort(spec_List,po_cons,sort_El,arg1,0).
opHasSort(spec_List,po_cons,sort_L,arg2,0).
opHasSort(spec_List,po_cons,sort_L,domain,0).
isNonDataOp(spec_List,po_cons).
opHasPriority(spec_List,po_cons,4).

hasOp(spec_List,po_nil,0).
opHasSort(spec_List,po_nil,sort_L,domain,0).
isNonDataOp(spec_List,po_nil).
opHasPriority(spec_List,po_nil,15).

hasOp(spec_List,po_qrev,0).
opHasSort(spec_List,po_qrev,sort_L,arg1,0).
opHasSort(spec_List,po_qrev,sort_L,arg2,0).
opHasSort(spec_List,po_qrev,sort_L,domain,0).
isNonDataOp(spec_List,po_qrev).
opHasPriority(spec_List,po_qrev,10).

hasOp(spec_List,po_rev,0).
opHasSort(spec_List,po_rev,sort_L,arg1,0).
opHasSort(spec_List,po_rev,sort_L,domain,0).
isNonDataOp(spec_List,po_rev).
opHasPriority(spec_List,po_rev,10).

%% predicates %%
%% axioms %%

%% Axiom Ax-qrevnilxx:p:4 %%
hasAxiom(spec_List,5,0).
axHasEquivalenceClass(spec_List,5,5,0).
isNonDataAx(spec_List,5).
axHasPriority(spec_List,5,4).
axInvolvesPredOp(spec_List,5,po_qrev,0).
axInvolvesPredOp(spec_List,5,po_nil,0).
axInvolvesSort(spec_List,5,sort_L,0).


%% Axiom Ax2 %%
hasAxiom(spec_List,6,0).
axHasEquivalenceClass(spec_List,6,6,0).
isNonDataAx(spec_List,6).
axHasPriority(spec_List,6,1).
axInvolvesPredOp(spec_List,6,po_rev,0).
axInvolvesPredOp(spec_List,6,po_nil,0).


%% Axiom Ax3 %%
hasAxiom(spec_List,7,0).
axHasEquivalenceClass(spec_List,7,7,0).
isNonDataAx(spec_List,7).
axHasPriority(spec_List,7,1).
axInvolvesPredOp(spec_List,7,po_app,0).
axInvolvesPredOp(spec_List,7,po_cons,0).
axInvolvesPredOp(spec_List,7,po_rev,0).
axInvolvesPredOp(spec_List,7,po_nil,0).
axInvolvesSort(spec_List,7,sort_El,0).
axInvolvesSort(spec_List,7,sort_L,0).


%% Axiom Ax-targetTheoremLists:p:20 %%
hasAxiom(spec_List,8,0).
axHasEquivalenceClass(spec_List,8,8,0).
isNonDataAx(spec_List,8).
axHasPriority(spec_List,8,20).
axInvolvesPredOp(spec_List,8,po_qrev,0).
axInvolvesPredOp(spec_List,8,po_rev,0).
axInvolvesPredOp(spec_List,8,po_nil,0).
axInvolvesSort(spec_List,8,sort_L,0).




