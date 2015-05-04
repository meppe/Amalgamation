%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This is the LP implementation of the generalization part of the amalgamation module    %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%%% Defining Part %%%
%%%%%%%%%%%%%%%%%%%%%

%%% The base program is iteration independent. These are just some auxiliary predicates.
#program  base. 

%%% Define steps
#program cumulative(t).
s(t).

%%% We have a total (or partial) priority order on predicates, operators and axioms, and generalisations should account for that order. Hence, we assign a cost to removal actions that coincides with the priority of the axiom, operator, predicate or sort to remove. This allows us to define when a generalisation action is optimal, i.e., when there is no cheaper action for which the preconditions are met.  Then we count the number of non-optimal generalisation operations as the number of operations that do not respect the priority order. This is used to prune the search space. 
stepValue(A,Spec,-C,t)	 :- poss(A,Spec,t), cost(A,Spec,C).
stepValue(A,Spec,V,t)	 :- poss(A,Spec,t), val(A,Spec,V).
isOptimal(A1,Spec,t) 	 :- poss(A1,Spec,t), stepValue(A1,Spec,V1,t), 0{ a(A2,Spec) : poss(A2,Spec,t), stepValue(A2,Spec,V2,t), V2 > V1  }0.
nonOptimalSteps(N,Spec,t) :- spec(Spec), N = {a(A,Spec) : exec(A,Spec,T),  not isOptimal(A,Spec,T), T <= t}.

notGenericReached(t) :- spec(Spec1), spec(Spec2), notEqual(Spec1,Spec2,t), Spec1 != Spec2.

%%%%%%%%%%%%%%%%%%%%%%%
%%% Generating Part %%%
%%%%%%%%%%%%%%%%%%%%%%%

%% %% % Generate generalization search space. If the generic space is not yet reached, execute a generalization operation. 
%% 0{exec(A,Spec,t) : a(A,Spec),  poss(A,Spec,t)}1 :- notGenericReached(t), spec(Spec).
%% This is much faster, but also much more restrictive:
0{exec(A,Spec,t) : a(A,Spec),  isOptimal(A,Spec,t)}1 :- notGenericReached(t), spec(Spec).

%%%%%%%%%%%%%%%%%%%%
%%% Testing Part %%%
%%%%%%%%%%%%%%%%%%%%

%% Domain-independent heuristics:
%% Speedup 1: No "gaps" on operation steps if a generalisation is possible to fill the gap: if no operation happens at a step for a certain spec, even though an operation would be possible, then no operations will happen in the future anymore. This has to be disabled if using a generation rule which only applies one operation per step in total. It also might cause problems in cases where something has first to be removed and then to be renamed.
specModified(Spec,t) :- exec(_,Spec,t).
:- specModified(Spec,t), not specModified(Spec,T_before), T_before < t, s(T_before), poss(_,Spec,T_before).

%% Speedup 2: Allow only a limited number on non-optimal steps. 
%% :- nonOptimalSteps(N,Spec,t), N > 3.

%% Disable models where the generic space is not yet reached. The external atom query(t) is induced into the Logic Program externally in the iterationCore-py.lp main loop.
#external query(t).
:- query(t), notGenericReached(t).



#show s/1.
#show notGenericReached/1.
#show exec/3.
%% #show poss/3.
