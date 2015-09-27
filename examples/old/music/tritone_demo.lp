#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec G7 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_G7).
hasId(spec_G7,0).

%% sorts %%
hasSort(spec_G7,sort_Chord,0).
isNonDataSort(spec_G7,sort_Chord).
sortHasPriority(spec_G7,sort_Chord,1).

hasSort(spec_G7,sort_Note,0).
isDataSort(spec_G7,sort_Note).
sortHasPriority(spec_G7,sort_Note,0).

%% operators %%
hasOp(spec_G7,po_0,0).
opHasSort(spec_G7,po_0,sort_Note,domain,0).
isDataOp(spec_G7,po_0).
opHasPriority(spec_G7,po_0,0).

hasOp(spec_G7,po_1,0).
opHasSort(spec_G7,po_1,sort_Note,domain,0).
isDataOp(spec_G7,po_1).
opHasPriority(spec_G7,po_1,0).

hasOp(spec_G7,po_2,0).
opHasSort(spec_G7,po_2,sort_Note,domain,0).
isDataOp(spec_G7,po_2).
opHasPriority(spec_G7,po_2,0).

hasOp(spec_G7,po_3,0).
opHasSort(spec_G7,po_3,sort_Note,domain,0).
isDataOp(spec_G7,po_3).
opHasPriority(spec_G7,po_3,0).

hasOp(spec_G7,po_4,0).
opHasSort(spec_G7,po_4,sort_Note,domain,0).
isDataOp(spec_G7,po_4).
opHasPriority(spec_G7,po_4,0).

hasOp(spec_G7,po_5,0).
opHasSort(spec_G7,po_5,sort_Note,domain,0).
isDataOp(spec_G7,po_5).
opHasPriority(spec_G7,po_5,0).

hasOp(spec_G7,po_6,0).
opHasSort(spec_G7,po_6,sort_Note,domain,0).
isDataOp(spec_G7,po_6).
opHasPriority(spec_G7,po_6,0).

hasOp(spec_G7,po_7,0).
opHasSort(spec_G7,po_7,sort_Note,domain,0).
isDataOp(spec_G7,po_7).
opHasPriority(spec_G7,po_7,0).

hasOp(spec_G7,po_8,0).
opHasSort(spec_G7,po_8,sort_Note,domain,0).
isDataOp(spec_G7,po_8).
opHasPriority(spec_G7,po_8,0).

hasOp(spec_G7,po_9,0).
opHasSort(spec_G7,po_9,sort_Note,domain,0).
isDataOp(spec_G7,po_9).
opHasPriority(spec_G7,po_9,0).

hasOp(spec_G7,po_plus,0).
opHasSort(spec_G7,po_plus,sort_Note,arg1,0).
opHasSort(spec_G7,po_plus,sort_Note,arg2,0).
opHasSort(spec_G7,po_plus,sort_Note,domain,0).
isNonDataOp(spec_G7,po_plus).
opHasPriority(spec_G7,po_plus,1).

hasOp(spec_G7,po_c,0).
opHasSort(spec_G7,po_c,sort_Chord,domain,0).
isNonDataOp(spec_G7,po_c).
opHasPriority(spec_G7,po_c,1).

hasOp(spec_G7,po_root,0).
opHasSort(spec_G7,po_root,sort_Chord,arg1,0).
opHasSort(spec_G7,po_root,sort_Note,domain,0).
isNonDataOp(spec_G7,po_root).
opHasPriority(spec_G7,po_root,1).

hasOp(spec_G7,po_suc,0).
opHasSort(spec_G7,po_suc,sort_Note,arg1,0).
opHasSort(spec_G7,po_suc,sort_Note,domain,0).
isNonDataOp(spec_G7,po_suc).
opHasPriority(spec_G7,po_suc,1).

hasOp(spec_G7,po_x,0).
opHasSort(spec_G7,po_x,sort_Note,domain,0).
isDataOp(spec_G7,po_x).
opHasPriority(spec_G7,po_x,0).

hasOp(spec_G7,po_x1,0).
opHasSort(spec_G7,po_x1,sort_Note,domain,0).
isDataOp(spec_G7,po_x1).
opHasPriority(spec_G7,po_x1,0).

%% predicates %%
hasPred(spec_G7,po_hasAbsNote,0).
predHasSort(spec_G7,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_G7,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_G7,po_hasAbsNote,1).

hasPred(spec_G7,po_hasRelNote,0).
predHasSort(spec_G7,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_G7,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_G7,po_hasRelNote,1).

%% axioms %%

%% Axiom Ax-absg7:p:1 %%
hasAxiom(spec_G7,0,0).
axHasEquivalenceClass(spec_G7,0,0,0).
isNonDataAx(spec_G7,0).
axHasPriority(spec_G7,0,1).
axInvolvesPredOp(spec_G7,0,po_c,0).
axInvolvesPredOp(spec_G7,0,po_7,0).
axInvolvesPredOp(spec_G7,0,po_hasAbsNote,0).


%% Axiom Ax-absg11:p:3 %%
hasAxiom(spec_G7,1,0).
axHasEquivalenceClass(spec_G7,1,1,0).
isNonDataAx(spec_G7,1).
axHasPriority(spec_G7,1,3).
axInvolvesPredOp(spec_G7,1,po_c,0).
axInvolvesPredOp(spec_G7,1,po_x1,0).
axInvolvesPredOp(spec_G7,1,po_hasAbsNote,0).


%% Axiom Ax-absg2:p:1 %%
hasAxiom(spec_G7,2,0).
axHasEquivalenceClass(spec_G7,2,2,0).
isNonDataAx(spec_G7,2).
axHasPriority(spec_G7,2,1).
axInvolvesPredOp(spec_G7,2,po_c,0).
axInvolvesPredOp(spec_G7,2,po_2,0).
axInvolvesPredOp(spec_G7,2,po_hasAbsNote,0).


%% Axiom Ax-absg5:p:2 %%
hasAxiom(spec_G7,3,0).
axHasEquivalenceClass(spec_G7,3,3,0).
isNonDataAx(spec_G7,3).
axHasPriority(spec_G7,3,2).
axInvolvesPredOp(spec_G7,3,po_c,0).
axInvolvesPredOp(spec_G7,3,po_5,0).
axInvolvesPredOp(spec_G7,3,po_hasAbsNote,0).


%% Axiom Ax-rootg7:p:1 %%
hasAxiom(spec_G7,4,0).
axHasEquivalenceClass(spec_G7,4,4,0).
isNonDataAx(spec_G7,4).
axHasPriority(spec_G7,4,1).
axInvolvesPredOp(spec_G7,4,po_c,0).
axInvolvesPredOp(spec_G7,4,po_root,0).
axInvolvesPredOp(spec_G7,4,po_7,0).


%% Axiom Ax-relg0:p:3 %%
hasAxiom(spec_G7,5,0).
axHasEquivalenceClass(spec_G7,5,5,0).
isNonDataAx(spec_G7,5).
axHasPriority(spec_G7,5,3).
axInvolvesPredOp(spec_G7,5,po_0,0).
axInvolvesPredOp(spec_G7,5,po_c,0).
axInvolvesPredOp(spec_G7,5,po_hasRelNote,0).


%% Axiom Ax-relg4:p:3 %%
hasAxiom(spec_G7,6,0).
axHasEquivalenceClass(spec_G7,6,6,0).
isNonDataAx(spec_G7,6).
axHasPriority(spec_G7,6,3).
axInvolvesPredOp(spec_G7,6,po_c,0).
axInvolvesPredOp(spec_G7,6,po_4,0).
axInvolvesPredOp(spec_G7,6,po_hasRelNote,0).


%% Axiom Ax-relg7:p:0 %%
hasAxiom(spec_G7,7,0).
axHasEquivalenceClass(spec_G7,7,7,0).
isNonDataAx(spec_G7,7).
axHasPriority(spec_G7,7,0).
axInvolvesPredOp(spec_G7,7,po_c,0).
axInvolvesPredOp(spec_G7,7,po_7,0).
axInvolvesPredOp(spec_G7,7,po_hasRelNote,0).


%% Axiom Ax-relg10:p:2 %%
hasAxiom(spec_G7,8,0).
axHasEquivalenceClass(spec_G7,8,8,0).
isNonDataAx(spec_G7,8).
axHasPriority(spec_G7,8,2).
axInvolvesPredOp(spec_G7,8,po_x,0).
axInvolvesPredOp(spec_G7,8,po_c,0).
axInvolvesPredOp(spec_G7,8,po_hasRelNote,0).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Bbmin %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Bbmin).
hasId(spec_Bbmin,1).

%% sorts %%
hasSort(spec_Bbmin,sort_Chord,0).
isNonDataSort(spec_Bbmin,sort_Chord).
sortHasPriority(spec_Bbmin,sort_Chord,1).

hasSort(spec_Bbmin,sort_Note,0).
isDataSort(spec_Bbmin,sort_Note).
sortHasPriority(spec_Bbmin,sort_Note,0).

%% operators %%
hasOp(spec_Bbmin,po_0,0).
opHasSort(spec_Bbmin,po_0,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_0).
opHasPriority(spec_Bbmin,po_0,0).

hasOp(spec_Bbmin,po_1,0).
opHasSort(spec_Bbmin,po_1,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_1).
opHasPriority(spec_Bbmin,po_1,0).

hasOp(spec_Bbmin,po_2,0).
opHasSort(spec_Bbmin,po_2,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_2).
opHasPriority(spec_Bbmin,po_2,0).

hasOp(spec_Bbmin,po_3,0).
opHasSort(spec_Bbmin,po_3,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_3).
opHasPriority(spec_Bbmin,po_3,0).

hasOp(spec_Bbmin,po_4,0).
opHasSort(spec_Bbmin,po_4,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_4).
opHasPriority(spec_Bbmin,po_4,0).

hasOp(spec_Bbmin,po_5,0).
opHasSort(spec_Bbmin,po_5,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_5).
opHasPriority(spec_Bbmin,po_5,0).

hasOp(spec_Bbmin,po_6,0).
opHasSort(spec_Bbmin,po_6,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_6).
opHasPriority(spec_Bbmin,po_6,0).

hasOp(spec_Bbmin,po_7,0).
opHasSort(spec_Bbmin,po_7,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_7).
opHasPriority(spec_Bbmin,po_7,0).

hasOp(spec_Bbmin,po_8,0).
opHasSort(spec_Bbmin,po_8,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_8).
opHasPriority(spec_Bbmin,po_8,0).

hasOp(spec_Bbmin,po_9,0).
opHasSort(spec_Bbmin,po_9,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_9).
opHasPriority(spec_Bbmin,po_9,0).

hasOp(spec_Bbmin,po_plus,0).
opHasSort(spec_Bbmin,po_plus,sort_Note,arg1,0).
opHasSort(spec_Bbmin,po_plus,sort_Note,arg2,0).
opHasSort(spec_Bbmin,po_plus,sort_Note,domain,0).
isNonDataOp(spec_Bbmin,po_plus).
opHasPriority(spec_Bbmin,po_plus,1).

hasOp(spec_Bbmin,po_c,0).
opHasSort(spec_Bbmin,po_c,sort_Chord,domain,0).
isNonDataOp(spec_Bbmin,po_c).
opHasPriority(spec_Bbmin,po_c,1).

hasOp(spec_Bbmin,po_root,0).
opHasSort(spec_Bbmin,po_root,sort_Chord,arg1,0).
opHasSort(spec_Bbmin,po_root,sort_Note,domain,0).
isNonDataOp(spec_Bbmin,po_root).
opHasPriority(spec_Bbmin,po_root,1).

hasOp(spec_Bbmin,po_suc,0).
opHasSort(spec_Bbmin,po_suc,sort_Note,arg1,0).
opHasSort(spec_Bbmin,po_suc,sort_Note,domain,0).
isNonDataOp(spec_Bbmin,po_suc).
opHasPriority(spec_Bbmin,po_suc,1).

hasOp(spec_Bbmin,po_x,0).
opHasSort(spec_Bbmin,po_x,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_x).
opHasPriority(spec_Bbmin,po_x,0).

hasOp(spec_Bbmin,po_x1,0).
opHasSort(spec_Bbmin,po_x1,sort_Note,domain,0).
isDataOp(spec_Bbmin,po_x1).
opHasPriority(spec_Bbmin,po_x1,0).

%% predicates %%
hasPred(spec_Bbmin,po_hasAbsNote,0).
predHasSort(spec_Bbmin,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_Bbmin,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_Bbmin,po_hasAbsNote,1).

hasPred(spec_Bbmin,po_hasRelNote,0).
predHasSort(spec_Bbmin,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_Bbmin,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_Bbmin,po_hasRelNote,1).

%% axioms %%

%% Axiom Ax-absb10:p:1 %%
hasAxiom(spec_Bbmin,46,0).
axHasEquivalenceClass(spec_Bbmin,46,46,0).
isNonDataAx(spec_Bbmin,46).
axHasPriority(spec_Bbmin,46,1).
axInvolvesPredOp(spec_Bbmin,46,po_x,0).
axInvolvesPredOp(spec_Bbmin,46,po_c,0).
axInvolvesPredOp(spec_Bbmin,46,po_hasAbsNote,0).


%% Axiom Ax-absb1:p:3 %%
hasAxiom(spec_Bbmin,47,0).
axHasEquivalenceClass(spec_Bbmin,47,47,0).
isNonDataAx(spec_Bbmin,47).
axHasPriority(spec_Bbmin,47,3).
axInvolvesPredOp(spec_Bbmin,47,po_1,0).
axInvolvesPredOp(spec_Bbmin,47,po_c,0).
axInvolvesPredOp(spec_Bbmin,47,po_hasAbsNote,0).


%% Axiom Ax-absb5:p:2 %%
hasAxiom(spec_Bbmin,48,0).
axHasEquivalenceClass(spec_Bbmin,48,3,0).
isNonDataAx(spec_Bbmin,48).
axHasPriority(spec_Bbmin,48,2).
axInvolvesPredOp(spec_Bbmin,48,po_c,0).
axInvolvesPredOp(spec_Bbmin,48,po_5,0).
axInvolvesPredOp(spec_Bbmin,48,po_hasAbsNote,0).


%% Axiom Ax-rootb10:p:2 %%
hasAxiom(spec_Bbmin,49,0).
axHasEquivalenceClass(spec_Bbmin,49,48,0).
isNonDataAx(spec_Bbmin,49).
axHasPriority(spec_Bbmin,49,2).
axInvolvesPredOp(spec_Bbmin,49,po_x,0).
axInvolvesPredOp(spec_Bbmin,49,po_c,0).
axInvolvesPredOp(spec_Bbmin,49,po_root,0).


%% Axiom Ax-relb0:p:2 %%
hasAxiom(spec_Bbmin,50,0).
axHasEquivalenceClass(spec_Bbmin,50,5,0).
isNonDataAx(spec_Bbmin,50).
axHasPriority(spec_Bbmin,50,2).
axInvolvesPredOp(spec_Bbmin,50,po_0,0).
axInvolvesPredOp(spec_Bbmin,50,po_c,0).
axInvolvesPredOp(spec_Bbmin,50,po_hasRelNote,0).


%% Axiom Ax-relb3:p:1 %%
hasAxiom(spec_Bbmin,51,0).
axHasEquivalenceClass(spec_Bbmin,51,49,0).
isNonDataAx(spec_Bbmin,51).
axHasPriority(spec_Bbmin,51,1).
axInvolvesPredOp(spec_Bbmin,51,po_c,0).
axInvolvesPredOp(spec_Bbmin,51,po_3,0).
axInvolvesPredOp(spec_Bbmin,51,po_hasRelNote,0).


%% Axiom Ax-relbb7:p:0 %%
hasAxiom(spec_Bbmin,52,0).
axHasEquivalenceClass(spec_Bbmin,52,7,0).
isNonDataAx(spec_Bbmin,52).
axHasPriority(spec_Bbmin,52,0).
axInvolvesPredOp(spec_Bbmin,52,po_c,0).
axInvolvesPredOp(spec_Bbmin,52,po_7,0).
axInvolvesPredOp(spec_Bbmin,52,po_hasRelNote,0).




