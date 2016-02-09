%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is the LP implementation of the generalization part of the amalgamation module    %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%%% Defining Part %%%
%%%%%%%%%%%%%%%%%%%%%

%%% The base program is iteration independent. These are just some auxiliary predicates.
#program  base. 
%% Determine when an action is not a renaming action
nonRenameAct(A,Spec) :- a(A,Spec), not renameAct(A,Spec).

%%% Define steps
#program cumulative(t).
s(t).

%%% We have a total (or partial) priority order on predicates, operators and axioms, and generalisations should account for that order. Hence, we assign a cost to removal actions that coincides with the priority of the axiom, operator, predicate or sort to remove. This allows us to define when a generalisation action is optimal, i.e., when there is no cheaper action for which the preconditions are met.  Then we count the number of non-optimal generalisation operations as the number of operations that do not respect the priority order. This is used to prune the search space. 
%% stepValue(A,Spec,-C,t)	 :- poss(A,Spec,t), cost(A,Spec,C).
%% stepValue(A,Spec,V,t)	 :- poss(A,Spec,t), val(A,Spec,V).

%% Count the number of non-optimal actions.
%% These all slow things down heavily... Why is that? Hypothesis: its because of comparison ">".
%% isOptimal(A1,Spec,t) 	 :- poss(A1,Spec,t), stepValue(A1,Spec,V1,t), 0{ a(A2,Spec) : poss(A2,Spec,t), stepValue(A2,Spec,V2,t), V2 > V1  }0.
%% nonOptimalSteps(N,Spec,t) :- spec(Spec), N = {a(A,Spec) : exec(A,Spec,T),  not isOptimal(A,Spec,T), T <= t}.

%% isGloballyOptimal(A1,Spec1,t) :- poss(A1,Spec1,t), stepValue(A1,Spec1,V1,t), 0{ a(A2,Spec2) : poss(A2,Spec2,t), stepValue(A2,Spec2,V2,t), V2 > V1  }0.
%% nonGloballyOptimalSteps(N,t) :- N = {a(A,Spec) : exec(A,Spec,T),  not isGloballyOptimal(A,Spec,T), T <= t}.
%% #show nonGloballyOptimalSteps/2.

%% nonGloballyOptimalSteps(0,0).
%% exActWithHigerValue(t) :- exec(A,Spec,t), stepValue(A,Spec,V,t), poss(A1,Spec1,t), stepValue(A1,Spec1,V1,t), V1 > V.
%% nonGloballyOptimalSteps(V_old+1,t+1) :- nonGloballyOptimalSteps(V_old,t), exActWithHigerValue(t).

notGenericReached(t) :- spec(Spec1), spec(Spec2), notEqual(Spec1,Spec2,t), Spec1 != Spec2.

%%%%%%%%%%%%%%%%%%%%%%%
%%% Generating Part %%%
%%%%%%%%%%%%%%%%%%%%%%%
%% %% % Generate generalization search space. If the generic space is not yet reached, execute a generalization operation. 
%% 0{exec(A,Spec,t) : a(A,Spec),  poss(A,Spec,t)}1 :- notGenericReached(t), spec(Spec).
%% This is much faster, but also much more restrictive, because it only allows optimal generalisations:
%% 0{exec(A,Spec,t) : a(A,Spec),  isOptimal(A,Spec,t)}1 :- notGenericReached(t), spec(Spec).
%% This allows only one generalisation on one of the specifications at a time. 
1{exec(A,Spec,t) : nonRenameAct(A,Spec), poss(A,Spec,t)}1 :- notGenericReached(t), findCrossSpaceMapPhaseFinished(t).
%% This allows only one generalisation on one of the specifications at a time, with necessity of optimal steps. Note that this sometimes leads to unsatisfiability. 
%% 1{exec(A,Spec,t) : isGloballyOptimal(A,Spec,t), poss(A,Spec,t)}1 :- notGenericReached(t).

%% First identify the cross-space-mapping by applying renaming actions
1{exec(A,Spec,t) : renameAct(A,Spec), poss(A,Spec,t)}1 :- not findCrossSpaceMapPhaseFinished(t).

%% Decide where cross space mapping phase is over or not. 
%% This produces the maximal cross space mapping because no further renaming action is possible. 
findCrossSpaceMapPhaseFinished(t) :- 0{ poss(A,Spec,t) : renameAct(A,Spec)}0.
%% This produces subsets of the maximal cross space mapping. After each step, the search for the cross domain mapping may or may not have finished.
%% 0{findCrossSpaceMapPhaseFinished(t)}1 :- not findCrossSpaceMapPhaseFinished(t-1).
%% Once the generic space finding phase is finished, it is finished forever.
findCrossSpaceMapPhaseFinished(t) :- findCrossSpaceMapPhaseFinished(t-1).
%% Some debug assertion: It should not happen, that the cross space mapping phase was finished and now renaming is possible again. 
xxx_assertion_xxx(crossSpaceMappingPhaseShouldBeOver,t) :- findCrossSpaceMapPhaseFinished(T), T < t, not findCrossSpaceMapPhaseFinished(t).
#show xxx_assertion_xxx/2.

%% #show nonRenameAct/2.
%% #show nonRenameAct/2.
%%%%%%%%%%%%%%%%%%%%
%%% Testing Part %%%
%%%%%%%%%%%%%%%%%%%%

%% Domain-independent heuristics:
%% Speedup 1: No "gaps" on operation steps if a generalisation is possible to fill the gap: if no operation happens at a step for a certain spec, even though an operation would be possible, then no operations will happen in the future anymore. This has to be disabled if using a generation rule which only applies one operation per step in total. It also might cause problems in cases where something has first to be removed and then to be renamed.
%% specModified(Spec,t) :- exec(_,Spec,t).
%% :- specModified(Spec,t), not specModified(Spec,T_before), T_before < t, s(T_before), poss(_,Spec,T_before).

%% Speedup 2: Allow only a limited number on non-optimal steps. 
%% :- nonOptimalSteps(N,Spec,t), N > 3.
%% :- nonGloballyOptimalSteps(N,t), N > 0.

%% Disable models where the generic space is not yet reached. The external atom query(t) is induced into the Logic Program externally in the iterationCore-py.lp main loop.
genericReached(t) :- not notGenericReached(t).
#show genericReached/1.

#external query(t).
%% :- query(t), not findCrossSpaceMapPhaseFinished(t).
:- query(t), notGenericReached(t).
:- query(t), genericReached(t), exec(A,Spec,t).
:- query(t), notGenericReached(t), not exec(_,_,t).
:- query(t), s(t), genericReached(t-1).

%% #show s/1.
%% #show notGenericReached/1.
#show exec/3.
%% #show findCrossSpaceMapPhaseFinished/1.
#show finalCrossSpaceMap/5.

%%%%%%%%% DEBUG OUTPUT %%%%%%%%%%%%%
%% stepValueAtT(A,Spec,V) :- stepValue(A,Spec,V,t), t = 0, poss(A,Spec,t).
%% #show stepValueAtT/3.
%% In the houseboat example, the po_boat must be renamed to po_resident at some point. Assert this here:
%% #program cumulative(t).
%% execOfInterestFound(t) :- exec(renameOp(po_boat,po_resident,spec_House),spec_Boat,T), s(T).
%% execOfInterestNotFound(t) :- not execOfInterestFound(t).
%% #external query(t).
%% :- query(t), execOfInterestNotFound(t).
