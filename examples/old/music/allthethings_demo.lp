#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Emaj7 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Emaj7).
hasId(spec_Emaj7,0).

%% sorts %%
hasSort(spec_Emaj7,sort_Chord,0).
isNonDataSort(spec_Emaj7,sort_Chord).
sortHasPriority(spec_Emaj7,sort_Chord,1).

hasSort(spec_Emaj7,sort_Note,0).
isDataSort(spec_Emaj7,sort_Note).
sortHasPriority(spec_Emaj7,sort_Note,0).

%% operators %%
hasOp(spec_Emaj7,po_0,0).
opHasSort(spec_Emaj7,po_0,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_0).
opHasPriority(spec_Emaj7,po_0,0).

hasOp(spec_Emaj7,po_1,0).
opHasSort(spec_Emaj7,po_1,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_1).
opHasPriority(spec_Emaj7,po_1,0).

hasOp(spec_Emaj7,po_2,0).
opHasSort(spec_Emaj7,po_2,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_2).
opHasPriority(spec_Emaj7,po_2,0).

hasOp(spec_Emaj7,po_3,0).
opHasSort(spec_Emaj7,po_3,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_3).
opHasPriority(spec_Emaj7,po_3,0).

hasOp(spec_Emaj7,po_4,0).
opHasSort(spec_Emaj7,po_4,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_4).
opHasPriority(spec_Emaj7,po_4,0).

hasOp(spec_Emaj7,po_5,0).
opHasSort(spec_Emaj7,po_5,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_5).
opHasPriority(spec_Emaj7,po_5,0).

hasOp(spec_Emaj7,po_6,0).
opHasSort(spec_Emaj7,po_6,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_6).
opHasPriority(spec_Emaj7,po_6,0).

hasOp(spec_Emaj7,po_7,0).
opHasSort(spec_Emaj7,po_7,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_7).
opHasPriority(spec_Emaj7,po_7,0).

hasOp(spec_Emaj7,po_8,0).
opHasSort(spec_Emaj7,po_8,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_8).
opHasPriority(spec_Emaj7,po_8,0).

hasOp(spec_Emaj7,po_9,0).
opHasSort(spec_Emaj7,po_9,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_9).
opHasPriority(spec_Emaj7,po_9,0).

hasOp(spec_Emaj7,po_plus,0).
opHasSort(spec_Emaj7,po_plus,sort_Note,arg1,0).
opHasSort(spec_Emaj7,po_plus,sort_Note,arg2,0).
opHasSort(spec_Emaj7,po_plus,sort_Note,domain,0).
isNonDataOp(spec_Emaj7,po_plus).
opHasPriority(spec_Emaj7,po_plus,1).

hasOp(spec_Emaj7,po_c,0).
opHasSort(spec_Emaj7,po_c,sort_Chord,domain,0).
isNonDataOp(spec_Emaj7,po_c).
opHasPriority(spec_Emaj7,po_c,1).

hasOp(spec_Emaj7,po_root,0).
opHasSort(spec_Emaj7,po_root,sort_Chord,arg1,0).
opHasSort(spec_Emaj7,po_root,sort_Note,domain,0).
isNonDataOp(spec_Emaj7,po_root).
opHasPriority(spec_Emaj7,po_root,1).

hasOp(spec_Emaj7,po_suc,0).
opHasSort(spec_Emaj7,po_suc,sort_Note,arg1,0).
opHasSort(spec_Emaj7,po_suc,sort_Note,domain,0).
isNonDataOp(spec_Emaj7,po_suc).
opHasPriority(spec_Emaj7,po_suc,1).

hasOp(spec_Emaj7,po_x,0).
opHasSort(spec_Emaj7,po_x,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_x).
opHasPriority(spec_Emaj7,po_x,0).

hasOp(spec_Emaj7,po_x1,0).
opHasSort(spec_Emaj7,po_x1,sort_Note,domain,0).
isDataOp(spec_Emaj7,po_x1).
opHasPriority(spec_Emaj7,po_x1,0).

%% predicates %%
hasPred(spec_Emaj7,po_hasAbsNote,0).
predHasSort(spec_Emaj7,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_Emaj7,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_Emaj7,po_hasAbsNote,1).

hasPred(spec_Emaj7,po_hasRelNote,0).
predHasSort(spec_Emaj7,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_Emaj7,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_Emaj7,po_hasRelNote,1).

%% axioms %%

%% Axiom Ax-abse4:p:2 %%
hasAxiom(spec_Emaj7,0,0).
axHasEquivalenceClass(spec_Emaj7,0,0,0).
isNonDataAx(spec_Emaj7,0).
axHasPriority(spec_Emaj7,0,2).
axInvolvesPredOp(spec_Emaj7,0,po_c,0).
axInvolvesPredOp(spec_Emaj7,0,po_4,0).
axInvolvesPredOp(spec_Emaj7,0,po_hasAbsNote,0).


%% Axiom Ax-abse8:p:3 %%
hasAxiom(spec_Emaj7,1,0).
axHasEquivalenceClass(spec_Emaj7,1,1,0).
isNonDataAx(spec_Emaj7,1).
axHasPriority(spec_Emaj7,1,3).
axInvolvesPredOp(spec_Emaj7,1,po_8,0).
axInvolvesPredOp(spec_Emaj7,1,po_c,0).
axInvolvesPredOp(spec_Emaj7,1,po_hasAbsNote,0).


%% Axiom Ax-abse3:p:1 %%
hasAxiom(spec_Emaj7,2,0).
axHasEquivalenceClass(spec_Emaj7,2,2,0).
isNonDataAx(spec_Emaj7,2).
axHasPriority(spec_Emaj7,2,1).
axInvolvesPredOp(spec_Emaj7,2,po_c,0).
axInvolvesPredOp(spec_Emaj7,2,po_3,0).
axInvolvesPredOp(spec_Emaj7,2,po_hasAbsNote,0).


%% Axiom Ax-roote4:p:2 %%
hasAxiom(spec_Emaj7,3,0).
axHasEquivalenceClass(spec_Emaj7,3,3,0).
isNonDataAx(spec_Emaj7,3).
axHasPriority(spec_Emaj7,3,2).
axInvolvesPredOp(spec_Emaj7,3,po_c,0).
axInvolvesPredOp(spec_Emaj7,3,po_root,0).
axInvolvesPredOp(spec_Emaj7,3,po_4,0).


%% Axiom Ax-rele0:p:3 %%
hasAxiom(spec_Emaj7,4,0).
axHasEquivalenceClass(spec_Emaj7,4,4,0).
isNonDataAx(spec_Emaj7,4).
axHasPriority(spec_Emaj7,4,3).
axInvolvesPredOp(spec_Emaj7,4,po_0,0).
axInvolvesPredOp(spec_Emaj7,4,po_c,0).
axInvolvesPredOp(spec_Emaj7,4,po_hasRelNote,0).


%% Axiom Ax-rele4:p:3 %%
hasAxiom(spec_Emaj7,5,0).
axHasEquivalenceClass(spec_Emaj7,5,5,0).
isNonDataAx(spec_Emaj7,5).
axHasPriority(spec_Emaj7,5,3).
axInvolvesPredOp(spec_Emaj7,5,po_c,0).
axInvolvesPredOp(spec_Emaj7,5,po_4,0).
axInvolvesPredOp(spec_Emaj7,5,po_hasRelNote,0).


%% Axiom Ax-rele11:p:1 %%
hasAxiom(spec_Emaj7,6,0).
axHasEquivalenceClass(spec_Emaj7,6,6,0).
isNonDataAx(spec_Emaj7,6).
axHasPriority(spec_Emaj7,6,1).
axInvolvesPredOp(spec_Emaj7,6,po_c,0).
axInvolvesPredOp(spec_Emaj7,6,po_x1,0).
axInvolvesPredOp(spec_Emaj7,6,po_hasRelNote,0).


%% Axiom Ax6 %%
hasAxiom(spec_Emaj7,12,0).
axHasEquivalenceClass(spec_Emaj7,12,12,0).
isNonDataAx(spec_Emaj7,12).
axHasPriority(spec_Emaj7,12,1).
axInvolvesPredOp(spec_Emaj7,12,po_Chord,0).
axInvolvesPredOp(spec_Emaj7,12,po_hasAbsNote,0).
axInvolvesPredOp(spec_Emaj7,12,po_6,0).
axInvolvesPredOp(spec_Emaj7,12,po_1,0).
axInvolvesPredOp(spec_Emaj7,12,po_7,0).
axInvolvesPredOp(spec_Emaj7,12,po_hasRelNote,0).
axInvolvesPredOp(spec_Emaj7,12,po_var,0).
axInvolvesPredOp(spec_Emaj7,12,po_root,0).
axInvolvesSort(spec_Emaj7,12,sort_Chord,0).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Fmin7 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Fmin7).
hasId(spec_Fmin7,1).

%% sorts %%
hasSort(spec_Fmin7,sort_Chord,0).
isNonDataSort(spec_Fmin7,sort_Chord).
sortHasPriority(spec_Fmin7,sort_Chord,1).

hasSort(spec_Fmin7,sort_Note,0).
isDataSort(spec_Fmin7,sort_Note).
sortHasPriority(spec_Fmin7,sort_Note,0).

%% operators %%
hasOp(spec_Fmin7,po_0,0).
opHasSort(spec_Fmin7,po_0,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_0).
opHasPriority(spec_Fmin7,po_0,0).

hasOp(spec_Fmin7,po_1,0).
opHasSort(spec_Fmin7,po_1,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_1).
opHasPriority(spec_Fmin7,po_1,0).

hasOp(spec_Fmin7,po_2,0).
opHasSort(spec_Fmin7,po_2,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_2).
opHasPriority(spec_Fmin7,po_2,0).

hasOp(spec_Fmin7,po_3,0).
opHasSort(spec_Fmin7,po_3,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_3).
opHasPriority(spec_Fmin7,po_3,0).

hasOp(spec_Fmin7,po_4,0).
opHasSort(spec_Fmin7,po_4,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_4).
opHasPriority(spec_Fmin7,po_4,0).

hasOp(spec_Fmin7,po_5,0).
opHasSort(spec_Fmin7,po_5,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_5).
opHasPriority(spec_Fmin7,po_5,0).

hasOp(spec_Fmin7,po_6,0).
opHasSort(spec_Fmin7,po_6,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_6).
opHasPriority(spec_Fmin7,po_6,0).

hasOp(spec_Fmin7,po_7,0).
opHasSort(spec_Fmin7,po_7,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_7).
opHasPriority(spec_Fmin7,po_7,0).

hasOp(spec_Fmin7,po_8,0).
opHasSort(spec_Fmin7,po_8,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_8).
opHasPriority(spec_Fmin7,po_8,0).

hasOp(spec_Fmin7,po_9,0).
opHasSort(spec_Fmin7,po_9,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_9).
opHasPriority(spec_Fmin7,po_9,0).

hasOp(spec_Fmin7,po_plus,0).
opHasSort(spec_Fmin7,po_plus,sort_Note,arg1,0).
opHasSort(spec_Fmin7,po_plus,sort_Note,arg2,0).
opHasSort(spec_Fmin7,po_plus,sort_Note,domain,0).
isNonDataOp(spec_Fmin7,po_plus).
opHasPriority(spec_Fmin7,po_plus,1).

hasOp(spec_Fmin7,po_c,0).
opHasSort(spec_Fmin7,po_c,sort_Chord,domain,0).
isNonDataOp(spec_Fmin7,po_c).
opHasPriority(spec_Fmin7,po_c,1).

hasOp(spec_Fmin7,po_root,0).
opHasSort(spec_Fmin7,po_root,sort_Chord,arg1,0).
opHasSort(spec_Fmin7,po_root,sort_Note,domain,0).
isNonDataOp(spec_Fmin7,po_root).
opHasPriority(spec_Fmin7,po_root,1).

hasOp(spec_Fmin7,po_suc,0).
opHasSort(spec_Fmin7,po_suc,sort_Note,arg1,0).
opHasSort(spec_Fmin7,po_suc,sort_Note,domain,0).
isNonDataOp(spec_Fmin7,po_suc).
opHasPriority(spec_Fmin7,po_suc,1).

hasOp(spec_Fmin7,po_x,0).
opHasSort(spec_Fmin7,po_x,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_x).
opHasPriority(spec_Fmin7,po_x,0).

hasOp(spec_Fmin7,po_x1,0).
opHasSort(spec_Fmin7,po_x1,sort_Note,domain,0).
isDataOp(spec_Fmin7,po_x1).
opHasPriority(spec_Fmin7,po_x1,0).

%% predicates %%
hasPred(spec_Fmin7,po_hasAbsNote,0).
predHasSort(spec_Fmin7,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_Fmin7,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_Fmin7,po_hasAbsNote,1).

hasPred(spec_Fmin7,po_hasRelNote,0).
predHasSort(spec_Fmin7,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_Fmin7,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_Fmin7,po_hasRelNote,1).

%% axioms %%

%% Axiom Ax-absf5:p:1 %%
hasAxiom(spec_Fmin7,45,0).
axHasEquivalenceClass(spec_Fmin7,45,45,0).
isNonDataAx(spec_Fmin7,45).
axHasPriority(spec_Fmin7,45,1).
axInvolvesPredOp(spec_Fmin7,45,po_c,0).
axInvolvesPredOp(spec_Fmin7,45,po_5,0).
axInvolvesPredOp(spec_Fmin7,45,po_hasAbsNote,0).


%% Axiom Ax-absf8:p:3 %%
hasAxiom(spec_Fmin7,46,0).
axHasEquivalenceClass(spec_Fmin7,46,1,0).
isNonDataAx(spec_Fmin7,46).
axHasPriority(spec_Fmin7,46,3).
axInvolvesPredOp(spec_Fmin7,46,po_8,0).
axInvolvesPredOp(spec_Fmin7,46,po_c,0).
axInvolvesPredOp(spec_Fmin7,46,po_hasAbsNote,0).


%% Axiom Ax-absf0:p:2 %%
hasAxiom(spec_Fmin7,47,0).
axHasEquivalenceClass(spec_Fmin7,47,46,0).
isNonDataAx(spec_Fmin7,47).
axHasPriority(spec_Fmin7,47,2).
axInvolvesPredOp(spec_Fmin7,47,po_0,0).
axInvolvesPredOp(spec_Fmin7,47,po_c,0).
axInvolvesPredOp(spec_Fmin7,47,po_hasAbsNote,0).


%% Axiom Ax-absf3:p:2 %%
hasAxiom(spec_Fmin7,48,0).
axHasEquivalenceClass(spec_Fmin7,48,2,0).
isNonDataAx(spec_Fmin7,48).
axHasPriority(spec_Fmin7,48,2).
axInvolvesPredOp(spec_Fmin7,48,po_c,0).
axInvolvesPredOp(spec_Fmin7,48,po_3,0).
axInvolvesPredOp(spec_Fmin7,48,po_hasAbsNote,0).


%% Axiom Ax-rootf5:p:1 %%
hasAxiom(spec_Fmin7,49,0).
axHasEquivalenceClass(spec_Fmin7,49,47,0).
isNonDataAx(spec_Fmin7,49).
axHasPriority(spec_Fmin7,49,1).
axInvolvesPredOp(spec_Fmin7,49,po_5,0).
axInvolvesPredOp(spec_Fmin7,49,po_c,0).
axInvolvesPredOp(spec_Fmin7,49,po_root,0).


%% Axiom Ax-relf0:p:3 %%
hasAxiom(spec_Fmin7,50,0).
axHasEquivalenceClass(spec_Fmin7,50,4,0).
isNonDataAx(spec_Fmin7,50).
axHasPriority(spec_Fmin7,50,3).
axInvolvesPredOp(spec_Fmin7,50,po_0,0).
axInvolvesPredOp(spec_Fmin7,50,po_c,0).
axInvolvesPredOp(spec_Fmin7,50,po_hasRelNote,0).


%% Axiom Ax-relf3:p:2 %%
hasAxiom(spec_Fmin7,51,0).
axHasEquivalenceClass(spec_Fmin7,51,48,0).
isNonDataAx(spec_Fmin7,51).
axHasPriority(spec_Fmin7,51,2).
axInvolvesPredOp(spec_Fmin7,51,po_c,0).
axInvolvesPredOp(spec_Fmin7,51,po_3,0).
axInvolvesPredOp(spec_Fmin7,51,po_hasRelNote,0).


%% Axiom Ax-relf7:p:2 %%
hasAxiom(spec_Fmin7,52,0).
axHasEquivalenceClass(spec_Fmin7,52,49,0).
isNonDataAx(spec_Fmin7,52).
axHasPriority(spec_Fmin7,52,2).
axInvolvesPredOp(spec_Fmin7,52,po_c,0).
axInvolvesPredOp(spec_Fmin7,52,po_7,0).
axInvolvesPredOp(spec_Fmin7,52,po_hasRelNote,0).


%% Axiom Ax-relf10:p:1 %%
hasAxiom(spec_Fmin7,53,0).
axHasEquivalenceClass(spec_Fmin7,53,50,0).
isNonDataAx(spec_Fmin7,53).
axHasPriority(spec_Fmin7,53,1).
axInvolvesPredOp(spec_Fmin7,53,po_x,0).
axInvolvesPredOp(spec_Fmin7,53,po_c,0).
axInvolvesPredOp(spec_Fmin7,53,po_hasRelNote,0).


%% Axiom Ax6 %%
hasAxiom(spec_Fmin7,59,0).
axHasEquivalenceClass(spec_Fmin7,59,12,0).
isNonDataAx(spec_Fmin7,59).
axHasPriority(spec_Fmin7,59,1).
axInvolvesPredOp(spec_Fmin7,59,po_Chord,0).
axInvolvesPredOp(spec_Fmin7,59,po_hasAbsNote,0).
axInvolvesPredOp(spec_Fmin7,59,po_6,0).
axInvolvesPredOp(spec_Fmin7,59,po_1,0).
axInvolvesPredOp(spec_Fmin7,59,po_7,0).
axInvolvesPredOp(spec_Fmin7,59,po_hasRelNote,0).
axInvolvesPredOp(spec_Fmin7,59,po_var,0).
axInvolvesPredOp(spec_Fmin7,59,po_root,0).
axInvolvesSort(spec_Fmin7,59,sort_Chord,0).




