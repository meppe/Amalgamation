#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec PhrygianCadence %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_PhrygianCadence).
hasId(spec_PhrygianCadence,0).

%% sorts %%
hasSort(spec_PhrygianCadence,sort_Chord,0).
isNonDataSort(spec_PhrygianCadence,sort_Chord).
sortHasPriority(spec_PhrygianCadence,sort_Chord,1).

hasSort(spec_PhrygianCadence,sort_Note,0).
isDataSort(spec_PhrygianCadence,sort_Note).
sortHasPriority(spec_PhrygianCadence,sort_Note,0).

%% operators %%
hasOp(spec_PhrygianCadence,po_0,0).
opHasSort(spec_PhrygianCadence,po_0,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_0).
opHasPriority(spec_PhrygianCadence,po_0,0).

hasOp(spec_PhrygianCadence,po_1,0).
opHasSort(spec_PhrygianCadence,po_1,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_1).
opHasPriority(spec_PhrygianCadence,po_1,0).

hasOp(spec_PhrygianCadence,po_2,0).
opHasSort(spec_PhrygianCadence,po_2,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_2).
opHasPriority(spec_PhrygianCadence,po_2,0).

hasOp(spec_PhrygianCadence,po_3,0).
opHasSort(spec_PhrygianCadence,po_3,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_3).
opHasPriority(spec_PhrygianCadence,po_3,0).

hasOp(spec_PhrygianCadence,po_4,0).
opHasSort(spec_PhrygianCadence,po_4,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_4).
opHasPriority(spec_PhrygianCadence,po_4,0).

hasOp(spec_PhrygianCadence,po_5,0).
opHasSort(spec_PhrygianCadence,po_5,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_5).
opHasPriority(spec_PhrygianCadence,po_5,0).

hasOp(spec_PhrygianCadence,po_6,0).
opHasSort(spec_PhrygianCadence,po_6,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_6).
opHasPriority(spec_PhrygianCadence,po_6,0).

hasOp(spec_PhrygianCadence,po_7,0).
opHasSort(spec_PhrygianCadence,po_7,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_7).
opHasPriority(spec_PhrygianCadence,po_7,0).

hasOp(spec_PhrygianCadence,po_8,0).
opHasSort(spec_PhrygianCadence,po_8,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_8).
opHasPriority(spec_PhrygianCadence,po_8,0).

hasOp(spec_PhrygianCadence,po_9,0).
opHasSort(spec_PhrygianCadence,po_9,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_9).
opHasPriority(spec_PhrygianCadence,po_9,0).

hasOp(spec_PhrygianCadence,po_plus,0).
opHasSort(spec_PhrygianCadence,po_plus,sort_Note,arg1,0).
opHasSort(spec_PhrygianCadence,po_plus,sort_Note,arg2,0).
opHasSort(spec_PhrygianCadence,po_plus,sort_Note,domain,0).
isNonDataOp(spec_PhrygianCadence,po_plus).
opHasPriority(spec_PhrygianCadence,po_plus,1).

hasOp(spec_PhrygianCadence,po_c1Phrygian,0).
opHasSort(spec_PhrygianCadence,po_c1Phrygian,sort_Chord,domain,0).
isNonDataOp(spec_PhrygianCadence,po_c1Phrygian).
opHasPriority(spec_PhrygianCadence,po_c1Phrygian,40).

hasOp(spec_PhrygianCadence,po_c2Phrygian,0).
opHasSort(spec_PhrygianCadence,po_c2Phrygian,sort_Chord,domain,0).
isNonDataOp(spec_PhrygianCadence,po_c2Phrygian).
opHasPriority(spec_PhrygianCadence,po_c2Phrygian,40).

hasOp(spec_PhrygianCadence,po_root,0).
opHasSort(spec_PhrygianCadence,po_root,sort_Chord,arg1,0).
opHasSort(spec_PhrygianCadence,po_root,sort_Note,domain,0).
isNonDataOp(spec_PhrygianCadence,po_root).
opHasPriority(spec_PhrygianCadence,po_root,1).

hasOp(spec_PhrygianCadence,po_suc,0).
opHasSort(spec_PhrygianCadence,po_suc,sort_Note,arg1,0).
opHasSort(spec_PhrygianCadence,po_suc,sort_Note,domain,0).
isNonDataOp(spec_PhrygianCadence,po_suc).
opHasPriority(spec_PhrygianCadence,po_suc,1).

hasOp(spec_PhrygianCadence,po_x,0).
opHasSort(spec_PhrygianCadence,po_x,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_x).
opHasPriority(spec_PhrygianCadence,po_x,0).

hasOp(spec_PhrygianCadence,po_x1,0).
opHasSort(spec_PhrygianCadence,po_x1,sort_Note,domain,0).
isDataOp(spec_PhrygianCadence,po_x1).
opHasPriority(spec_PhrygianCadence,po_x1,0).

%% predicates %%
hasPred(spec_PhrygianCadence,po_hasAbsNote,0).
predHasSort(spec_PhrygianCadence,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_PhrygianCadence,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_PhrygianCadence,po_hasAbsNote,1).

hasPred(spec_PhrygianCadence,po_hasRelNote,0).
predHasSort(spec_PhrygianCadence,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_PhrygianCadence,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_PhrygianCadence,po_hasRelNote,1).

hasPred(spec_PhrygianCadence,po_hasSucc,0).
predHasSort(spec_PhrygianCadence,po_hasSucc,sort_Chord,arg1,0).
predHasSort(spec_PhrygianCadence,po_hasSucc,sort_Chord,arg2,0).
predHasPriority(spec_PhrygianCadence,po_hasSucc,1).

hasPred(spec_PhrygianCadence,po_isInitialChord,0).
predHasSort(spec_PhrygianCadence,po_isInitialChord,sort_Chord,arg1,0).
predHasPriority(spec_PhrygianCadence,po_isInitialChord,1).

hasPred(spec_PhrygianCadence,po_isTerminalChord,0).
predHasSort(spec_PhrygianCadence,po_isTerminalChord,sort_Chord,arg1,0).
predHasPriority(spec_PhrygianCadence,po_isTerminalChord,1).

%% axioms %%

%% Axiom succPhrygian:p:30 %%
hasAxiom(spec_PhrygianCadence,0,0).
axHasEquivalenceClass(spec_PhrygianCadence,0,0,0).
isNonDataAx(spec_PhrygianCadence,0).
axHasPriority(spec_PhrygianCadence,0,30).
axInvolvesPredOp(spec_PhrygianCadence,0,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,0,po_hasSucc,0).
axInvolvesPredOp(spec_PhrygianCadence,0,po_c2Phrygian,0).


%% Axiom initialPhrygian:p:30 %%
hasAxiom(spec_PhrygianCadence,1,0).
axHasEquivalenceClass(spec_PhrygianCadence,1,1,0).
isNonDataAx(spec_PhrygianCadence,1).
axHasPriority(spec_PhrygianCadence,1,30).
axInvolvesPredOp(spec_PhrygianCadence,1,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,1,po_isInitialChord,0).


%% Axiom terminalPhrygian:p:30 %%
hasAxiom(spec_PhrygianCadence,2,0).
axHasEquivalenceClass(spec_PhrygianCadence,2,2,0).
isNonDataAx(spec_PhrygianCadence,2).
axHasPriority(spec_PhrygianCadence,2,30).
axInvolvesPredOp(spec_PhrygianCadence,2,po_isTerminalChord,0).
axInvolvesPredOp(spec_PhrygianCadence,2,po_c2Phrygian,0).


%% Axiom Ax1 %%
hasAxiom(spec_PhrygianCadence,4,0).
axHasEquivalenceClass(spec_PhrygianCadence,4,4,0).
isNonDataAx(spec_PhrygianCadence,4).
axHasPriority(spec_PhrygianCadence,4,1).
axInvolvesPredOp(spec_PhrygianCadence,4,po_isTerminalChord,0).
axInvolvesSort(spec_PhrygianCadence,4,sort_Chord,0).


%% Axiom Ax2 %%
hasAxiom(spec_PhrygianCadence,5,0).
axHasEquivalenceClass(spec_PhrygianCadence,5,5,0).
isNonDataAx(spec_PhrygianCadence,5).
axHasPriority(spec_PhrygianCadence,5,1).
axInvolvesPredOp(spec_PhrygianCadence,5,po_isInitialChord,0).
axInvolvesSort(spec_PhrygianCadence,5,sort_Chord,0).


%% Axiom Ax3 %%
hasAxiom(spec_PhrygianCadence,6,0).
axHasEquivalenceClass(spec_PhrygianCadence,6,6,0).
isNonDataAx(spec_PhrygianCadence,6).
axHasPriority(spec_PhrygianCadence,6,1).
axInvolvesPredOp(spec_PhrygianCadence,6,po_hasSucc,0).
axInvolvesPredOp(spec_PhrygianCadence,6,po_isTerminalChord,0).
axInvolvesSort(spec_PhrygianCadence,6,sort_Chord,0).


%% Axiom Ax4 %%
hasAxiom(spec_PhrygianCadence,7,0).
axHasEquivalenceClass(spec_PhrygianCadence,7,7,0).
isNonDataAx(spec_PhrygianCadence,7).
axHasPriority(spec_PhrygianCadence,7,1).
axInvolvesPredOp(spec_PhrygianCadence,7,po_hasSucc,0).
axInvolvesPredOp(spec_PhrygianCadence,7,po_isInitialChord,0).
axInvolvesSort(spec_PhrygianCadence,7,sort_Chord,0).


%% Axiom Ax-absb10:p:1 %%
hasAxiom(spec_PhrygianCadence,43,0).
axHasEquivalenceClass(spec_PhrygianCadence,43,43,0).
isNonDataAx(spec_PhrygianCadence,43).
axHasPriority(spec_PhrygianCadence,43,1).
axInvolvesPredOp(spec_PhrygianCadence,43,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,43,po_x,0).
axInvolvesPredOp(spec_PhrygianCadence,43,po_hasAbsNote,0).


%% Axiom Ax-absb1:p:3 %%
hasAxiom(spec_PhrygianCadence,44,0).
axHasEquivalenceClass(spec_PhrygianCadence,44,44,0).
isNonDataAx(spec_PhrygianCadence,44).
axHasPriority(spec_PhrygianCadence,44,3).
axInvolvesPredOp(spec_PhrygianCadence,44,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,44,po_1,0).
axInvolvesPredOp(spec_PhrygianCadence,44,po_hasAbsNote,0).


%% Axiom Ax-absb5:p:2 %%
hasAxiom(spec_PhrygianCadence,45,0).
axHasEquivalenceClass(spec_PhrygianCadence,45,45,0).
isNonDataAx(spec_PhrygianCadence,45).
axHasPriority(spec_PhrygianCadence,45,2).
axInvolvesPredOp(spec_PhrygianCadence,45,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,45,po_5,0).
axInvolvesPredOp(spec_PhrygianCadence,45,po_hasAbsNote,0).


%% Axiom Ax-rootb10:p:2 %%
hasAxiom(spec_PhrygianCadence,46,0).
axHasEquivalenceClass(spec_PhrygianCadence,46,46,0).
isNonDataAx(spec_PhrygianCadence,46).
axHasPriority(spec_PhrygianCadence,46,2).
axInvolvesPredOp(spec_PhrygianCadence,46,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,46,po_x,0).
axInvolvesPredOp(spec_PhrygianCadence,46,po_root,0).


%% Axiom Ax-relb0:p:2 %%
hasAxiom(spec_PhrygianCadence,47,0).
axHasEquivalenceClass(spec_PhrygianCadence,47,47,0).
isNonDataAx(spec_PhrygianCadence,47).
axHasPriority(spec_PhrygianCadence,47,2).
axInvolvesPredOp(spec_PhrygianCadence,47,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,47,po_0,0).
axInvolvesPredOp(spec_PhrygianCadence,47,po_hasRelNote,0).


%% Axiom Ax-relb3:p:1 %%
hasAxiom(spec_PhrygianCadence,48,0).
axHasEquivalenceClass(spec_PhrygianCadence,48,48,0).
isNonDataAx(spec_PhrygianCadence,48).
axHasPriority(spec_PhrygianCadence,48,1).
axInvolvesPredOp(spec_PhrygianCadence,48,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,48,po_3,0).
axInvolvesPredOp(spec_PhrygianCadence,48,po_hasRelNote,0).


%% Axiom Ax-relb7:p:1 %%
hasAxiom(spec_PhrygianCadence,49,0).
axHasEquivalenceClass(spec_PhrygianCadence,49,49,0).
isNonDataAx(spec_PhrygianCadence,49).
axHasPriority(spec_PhrygianCadence,49,1).
axInvolvesPredOp(spec_PhrygianCadence,49,po_c1Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,49,po_7,0).
axInvolvesPredOp(spec_PhrygianCadence,49,po_hasRelNote,0).


%% Axiom Ax-rootc0:p:1 %%
hasAxiom(spec_PhrygianCadence,50,0).
axHasEquivalenceClass(spec_PhrygianCadence,50,50,0).
isNonDataAx(spec_PhrygianCadence,50).
axHasPriority(spec_PhrygianCadence,50,1).
axInvolvesPredOp(spec_PhrygianCadence,50,po_0,0).
axInvolvesPredOp(spec_PhrygianCadence,50,po_c2Phrygian,0).
axInvolvesPredOp(spec_PhrygianCadence,50,po_root,0).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec PerfectCadence %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_PerfectCadence).
hasId(spec_PerfectCadence,1).

%% sorts %%
hasSort(spec_PerfectCadence,sort_Chord,0).
isNonDataSort(spec_PerfectCadence,sort_Chord).
sortHasPriority(spec_PerfectCadence,sort_Chord,1).

hasSort(spec_PerfectCadence,sort_Note,0).
isDataSort(spec_PerfectCadence,sort_Note).
sortHasPriority(spec_PerfectCadence,sort_Note,0).

%% operators %%
hasOp(spec_PerfectCadence,po_0,0).
opHasSort(spec_PerfectCadence,po_0,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_0).
opHasPriority(spec_PerfectCadence,po_0,0).

hasOp(spec_PerfectCadence,po_1,0).
opHasSort(spec_PerfectCadence,po_1,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_1).
opHasPriority(spec_PerfectCadence,po_1,0).

hasOp(spec_PerfectCadence,po_2,0).
opHasSort(spec_PerfectCadence,po_2,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_2).
opHasPriority(spec_PerfectCadence,po_2,0).

hasOp(spec_PerfectCadence,po_3,0).
opHasSort(spec_PerfectCadence,po_3,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_3).
opHasPriority(spec_PerfectCadence,po_3,0).

hasOp(spec_PerfectCadence,po_4,0).
opHasSort(spec_PerfectCadence,po_4,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_4).
opHasPriority(spec_PerfectCadence,po_4,0).

hasOp(spec_PerfectCadence,po_5,0).
opHasSort(spec_PerfectCadence,po_5,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_5).
opHasPriority(spec_PerfectCadence,po_5,0).

hasOp(spec_PerfectCadence,po_6,0).
opHasSort(spec_PerfectCadence,po_6,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_6).
opHasPriority(spec_PerfectCadence,po_6,0).

hasOp(spec_PerfectCadence,po_7,0).
opHasSort(spec_PerfectCadence,po_7,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_7).
opHasPriority(spec_PerfectCadence,po_7,0).

hasOp(spec_PerfectCadence,po_8,0).
opHasSort(spec_PerfectCadence,po_8,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_8).
opHasPriority(spec_PerfectCadence,po_8,0).

hasOp(spec_PerfectCadence,po_9,0).
opHasSort(spec_PerfectCadence,po_9,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_9).
opHasPriority(spec_PerfectCadence,po_9,0).

hasOp(spec_PerfectCadence,po_plus,0).
opHasSort(spec_PerfectCadence,po_plus,sort_Note,arg1,0).
opHasSort(spec_PerfectCadence,po_plus,sort_Note,arg2,0).
opHasSort(spec_PerfectCadence,po_plus,sort_Note,domain,0).
isNonDataOp(spec_PerfectCadence,po_plus).
opHasPriority(spec_PerfectCadence,po_plus,1).

hasOp(spec_PerfectCadence,po_c1Perfect,0).
opHasSort(spec_PerfectCadence,po_c1Perfect,sort_Chord,domain,0).
isNonDataOp(spec_PerfectCadence,po_c1Perfect).
opHasPriority(spec_PerfectCadence,po_c1Perfect,40).

hasOp(spec_PerfectCadence,po_c2Perfect,0).
opHasSort(spec_PerfectCadence,po_c2Perfect,sort_Chord,domain,0).
isNonDataOp(spec_PerfectCadence,po_c2Perfect).
opHasPriority(spec_PerfectCadence,po_c2Perfect,40).

hasOp(spec_PerfectCadence,po_root,0).
opHasSort(spec_PerfectCadence,po_root,sort_Chord,arg1,0).
opHasSort(spec_PerfectCadence,po_root,sort_Note,domain,0).
isNonDataOp(spec_PerfectCadence,po_root).
opHasPriority(spec_PerfectCadence,po_root,1).

hasOp(spec_PerfectCadence,po_suc,0).
opHasSort(spec_PerfectCadence,po_suc,sort_Note,arg1,0).
opHasSort(spec_PerfectCadence,po_suc,sort_Note,domain,0).
isNonDataOp(spec_PerfectCadence,po_suc).
opHasPriority(spec_PerfectCadence,po_suc,1).

hasOp(spec_PerfectCadence,po_x,0).
opHasSort(spec_PerfectCadence,po_x,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_x).
opHasPriority(spec_PerfectCadence,po_x,0).

hasOp(spec_PerfectCadence,po_x1,0).
opHasSort(spec_PerfectCadence,po_x1,sort_Note,domain,0).
isDataOp(spec_PerfectCadence,po_x1).
opHasPriority(spec_PerfectCadence,po_x1,0).

%% predicates %%
hasPred(spec_PerfectCadence,po_hasAbsNote,0).
predHasSort(spec_PerfectCadence,po_hasAbsNote,sort_Chord,arg1,0).
predHasSort(spec_PerfectCadence,po_hasAbsNote,sort_Note,arg2,0).
predHasPriority(spec_PerfectCadence,po_hasAbsNote,1).

hasPred(spec_PerfectCadence,po_hasRelNote,0).
predHasSort(spec_PerfectCadence,po_hasRelNote,sort_Chord,arg1,0).
predHasSort(spec_PerfectCadence,po_hasRelNote,sort_Note,arg2,0).
predHasPriority(spec_PerfectCadence,po_hasRelNote,1).

hasPred(spec_PerfectCadence,po_hasSucc,0).
predHasSort(spec_PerfectCadence,po_hasSucc,sort_Chord,arg1,0).
predHasSort(spec_PerfectCadence,po_hasSucc,sort_Chord,arg2,0).
predHasPriority(spec_PerfectCadence,po_hasSucc,1).

hasPred(spec_PerfectCadence,po_isInitialChord,0).
predHasSort(spec_PerfectCadence,po_isInitialChord,sort_Chord,arg1,0).
predHasPriority(spec_PerfectCadence,po_isInitialChord,1).

hasPred(spec_PerfectCadence,po_isTerminalChord,0).
predHasSort(spec_PerfectCadence,po_isTerminalChord,sort_Chord,arg1,0).
predHasPriority(spec_PerfectCadence,po_isTerminalChord,1).

%% axioms %%

%% Axiom succPerfect:p:30 %%
hasAxiom(spec_PerfectCadence,51,0).
axHasEquivalenceClass(spec_PerfectCadence,51,51,0).
isNonDataAx(spec_PerfectCadence,51).
axHasPriority(spec_PerfectCadence,51,30).
axInvolvesPredOp(spec_PerfectCadence,51,po_hasSucc,0).
axInvolvesPredOp(spec_PerfectCadence,51,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,51,po_c2Perfect,0).


%% Axiom initialChordPerfect:p:30 %%
hasAxiom(spec_PerfectCadence,52,0).
axHasEquivalenceClass(spec_PerfectCadence,52,52,0).
isNonDataAx(spec_PerfectCadence,52).
axHasPriority(spec_PerfectCadence,52,30).
axInvolvesPredOp(spec_PerfectCadence,52,po_isInitialChord,0).
axInvolvesPredOp(spec_PerfectCadence,52,po_c1Perfect,0).


%% Axiom terminalChordPerfect:p:30 %%
hasAxiom(spec_PerfectCadence,53,0).
axHasEquivalenceClass(spec_PerfectCadence,53,53,0).
isNonDataAx(spec_PerfectCadence,53).
axHasPriority(spec_PerfectCadence,53,30).
axInvolvesPredOp(spec_PerfectCadence,53,po_isTerminalChord,0).
axInvolvesPredOp(spec_PerfectCadence,53,po_c2Perfect,0).


%% Axiom Ax1 %%
hasAxiom(spec_PerfectCadence,55,0).
axHasEquivalenceClass(spec_PerfectCadence,55,4,0).
isNonDataAx(spec_PerfectCadence,55).
axHasPriority(spec_PerfectCadence,55,1).
axInvolvesPredOp(spec_PerfectCadence,55,po_isTerminalChord,0).
axInvolvesSort(spec_PerfectCadence,55,sort_Chord,0).


%% Axiom Ax2 %%
hasAxiom(spec_PerfectCadence,56,0).
axHasEquivalenceClass(spec_PerfectCadence,56,5,0).
isNonDataAx(spec_PerfectCadence,56).
axHasPriority(spec_PerfectCadence,56,1).
axInvolvesPredOp(spec_PerfectCadence,56,po_isInitialChord,0).
axInvolvesSort(spec_PerfectCadence,56,sort_Chord,0).


%% Axiom Ax3 %%
hasAxiom(spec_PerfectCadence,57,0).
axHasEquivalenceClass(spec_PerfectCadence,57,6,0).
isNonDataAx(spec_PerfectCadence,57).
axHasPriority(spec_PerfectCadence,57,1).
axInvolvesPredOp(spec_PerfectCadence,57,po_hasSucc,0).
axInvolvesPredOp(spec_PerfectCadence,57,po_isTerminalChord,0).
axInvolvesSort(spec_PerfectCadence,57,sort_Chord,0).


%% Axiom Ax4 %%
hasAxiom(spec_PerfectCadence,58,0).
axHasEquivalenceClass(spec_PerfectCadence,58,7,0).
isNonDataAx(spec_PerfectCadence,58).
axHasPriority(spec_PerfectCadence,58,1).
axInvolvesPredOp(spec_PerfectCadence,58,po_hasSucc,0).
axInvolvesPredOp(spec_PerfectCadence,58,po_isInitialChord,0).
axInvolvesSort(spec_PerfectCadence,58,sort_Chord,0).


%% Axiom Ax-absg7:p:1 %%
hasAxiom(spec_PerfectCadence,94,0).
axHasEquivalenceClass(spec_PerfectCadence,94,54,0).
isNonDataAx(spec_PerfectCadence,94).
axHasPriority(spec_PerfectCadence,94,1).
axInvolvesPredOp(spec_PerfectCadence,94,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,94,po_hasAbsNote,0).
axInvolvesPredOp(spec_PerfectCadence,94,po_7,0).


%% Axiom Ax-absg11:p:3 %%
hasAxiom(spec_PerfectCadence,95,0).
axHasEquivalenceClass(spec_PerfectCadence,95,55,0).
isNonDataAx(spec_PerfectCadence,95).
axHasPriority(spec_PerfectCadence,95,3).
axInvolvesPredOp(spec_PerfectCadence,95,po_x1,0).
axInvolvesPredOp(spec_PerfectCadence,95,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,95,po_hasAbsNote,0).


%% Axiom Ax-absg2:p:1 %%
hasAxiom(spec_PerfectCadence,96,0).
axHasEquivalenceClass(spec_PerfectCadence,96,56,0).
isNonDataAx(spec_PerfectCadence,96).
axHasPriority(spec_PerfectCadence,96,1).
axInvolvesPredOp(spec_PerfectCadence,96,po_2,0).
axInvolvesPredOp(spec_PerfectCadence,96,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,96,po_hasAbsNote,0).


%% Axiom Ax-absg5:p:2 %%
hasAxiom(spec_PerfectCadence,97,0).
axHasEquivalenceClass(spec_PerfectCadence,97,57,0).
isNonDataAx(spec_PerfectCadence,97).
axHasPriority(spec_PerfectCadence,97,2).
axInvolvesPredOp(spec_PerfectCadence,97,po_5,0).
axInvolvesPredOp(spec_PerfectCadence,97,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,97,po_hasAbsNote,0).


%% Axiom Ax-rootg7:p:2 %%
hasAxiom(spec_PerfectCadence,98,0).
axHasEquivalenceClass(spec_PerfectCadence,98,58,0).
isNonDataAx(spec_PerfectCadence,98).
axHasPriority(spec_PerfectCadence,98,2).
axInvolvesPredOp(spec_PerfectCadence,98,po_root,0).
axInvolvesPredOp(spec_PerfectCadence,98,po_7,0).
axInvolvesPredOp(spec_PerfectCadence,98,po_c1Perfect,0).


%% Axiom Ax-relg0:p:3 %%
hasAxiom(spec_PerfectCadence,99,0).
axHasEquivalenceClass(spec_PerfectCadence,99,59,0).
isNonDataAx(spec_PerfectCadence,99).
axHasPriority(spec_PerfectCadence,99,3).
axInvolvesPredOp(spec_PerfectCadence,99,po_0,0).
axInvolvesPredOp(spec_PerfectCadence,99,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,99,po_hasRelNote,0).


%% Axiom Ax-relg4:p:3 %%
hasAxiom(spec_PerfectCadence,100,0).
axHasEquivalenceClass(spec_PerfectCadence,100,60,0).
isNonDataAx(spec_PerfectCadence,100).
axHasPriority(spec_PerfectCadence,100,3).
axInvolvesPredOp(spec_PerfectCadence,100,po_4,0).
axInvolvesPredOp(spec_PerfectCadence,100,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,100,po_hasRelNote,0).


%% Axiom Ax-relg7:p:2 %%
hasAxiom(spec_PerfectCadence,101,0).
axHasEquivalenceClass(spec_PerfectCadence,101,61,0).
isNonDataAx(spec_PerfectCadence,101).
axHasPriority(spec_PerfectCadence,101,2).
axInvolvesPredOp(spec_PerfectCadence,101,po_7,0).
axInvolvesPredOp(spec_PerfectCadence,101,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,101,po_hasRelNote,0).


%% Axiom Ax-relg10:p:3 %%
hasAxiom(spec_PerfectCadence,102,0).
axHasEquivalenceClass(spec_PerfectCadence,102,62,0).
isNonDataAx(spec_PerfectCadence,102).
axHasPriority(spec_PerfectCadence,102,3).
axInvolvesPredOp(spec_PerfectCadence,102,po_x,0).
axInvolvesPredOp(spec_PerfectCadence,102,po_c1Perfect,0).
axInvolvesPredOp(spec_PerfectCadence,102,po_hasRelNote,0).


%% Axiom Ax-rootc0:p:1 %%
hasAxiom(spec_PerfectCadence,103,0).
axHasEquivalenceClass(spec_PerfectCadence,103,63,0).
isNonDataAx(spec_PerfectCadence,103).
axHasPriority(spec_PerfectCadence,103,1).
axInvolvesPredOp(spec_PerfectCadence,103,po_0,0).
axInvolvesPredOp(spec_PerfectCadence,103,po_root,0).
axInvolvesPredOp(spec_PerfectCadence,103,po_c2Perfect,0).




