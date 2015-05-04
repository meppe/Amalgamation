#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Boat %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Boat).
hasId(spec_Boat,0).

%% sorts %%
hasSort(spec_Boat,sort_Boat,1).
isNonDataSort(spec_Boat,sort_Boat).
sortHasPriority(spec_Boat,sort_Boat,3).

hasSort(spec_Boat,sort_Passenger,1).
isNonDataSort(spec_Boat,sort_Passenger).
sortHasPriority(spec_Boat,sort_Passenger,2).

hasSort(spec_Boat,sort_Person,1).
isNonDataSort(spec_Boat,sort_Person).
sortHasPriority(spec_Boat,sort_Person,3).

hasSort(spec_Boat,sort_Thing,1).
isNonDataSort(spec_Boat,sort_Thing).
sortHasPriority(spec_Boat,sort_Thing,5).

hasSort(spec_Boat,sort_Value,1).
isDataSort(spec_Boat,sort_Value).
sortHasPriority(spec_Boat,sort_Value,0).

hasSort(spec_Boat,sort_Boat,1).
hasParentSort(spec_Boat,sort_Boat,sort_Thing,1).
isNonDataSort(spec_Boat,sort_Boat).
sortHasPriority(spec_Boat,sort_Boat,3).

hasSort(spec_Boat,sort_Passenger,1).
hasParentSort(spec_Boat,sort_Passenger,sort_Person,1).
isNonDataSort(spec_Boat,sort_Passenger).
sortHasPriority(spec_Boat,sort_Passenger,2).

hasSort(spec_Boat,sort_Person,1).
hasParentSort(spec_Boat,sort_Person,sort_Thing,1).
isNonDataSort(spec_Boat,sort_Person).
sortHasPriority(spec_Boat,sort_Person,3).

%% operators %%
hasOp(spec_Boat,po_boat1,1).
opHasSort(spec_Boat,po_boat1,sort_Boat,domain,1).
isNonDataOp(spec_Boat,po_boat1).
opHasPriority(spec_Boat,po_boat1,2).

hasOp(spec_Boat,po_captainOf,1).
opHasSort(spec_Boat,po_captainOf,sort_Boat,arg1,1).
opHasSort(spec_Boat,po_captainOf,sort_Passenger,domain,1).
isNonDataOp(spec_Boat,po_captainOf).
opHasPriority(spec_Boat,po_captainOf,3).

hasOp(spec_Boat,po_passenger1,1).
opHasSort(spec_Boat,po_passenger1,sort_Passenger,domain,1).
isNonDataOp(spec_Boat,po_passenger1).
opHasPriority(spec_Boat,po_passenger1,2).

hasOp(spec_Boat,po_v1,1).
opHasSort(spec_Boat,po_v1,sort_Value,domain,1).
isDataOp(spec_Boat,po_v1).
opHasPriority(spec_Boat,po_v1,0).

hasOp(spec_Boat,po_v2,1).
opHasSort(spec_Boat,po_v2,sort_Value,domain,1).
isDataOp(spec_Boat,po_v2).
opHasPriority(spec_Boat,po_v2,0).

%% predicates %%
%% axioms %%

%% Axiom Ax-AssignCaptain:p:2 %%
hasAxiom(spec_Boat,0,1).
axHasEquivalenceClass(spec_Boat,0,0,1).
isNonDataAx(spec_Boat,0).
axHasPriority(spec_Boat,0,2).
axInvolvesPredOp(spec_Boat,0,po_boat1,1).
axInvolvesPredOp(spec_Boat,0,po_passenger1,1).
axInvolvesPredOp(spec_Boat,0,po_captainOf,1).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec House %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_House).
hasId(spec_House,1).

%% sorts %%
hasSort(spec_House,sort_House,1).
isNonDataSort(spec_House,sort_House).
sortHasPriority(spec_House,sort_House,3).

hasSort(spec_House,sort_Inhabitant,1).
isNonDataSort(spec_House,sort_Inhabitant).
sortHasPriority(spec_House,sort_Inhabitant,2).

hasSort(spec_House,sort_Person,1).
isNonDataSort(spec_House,sort_Person).
sortHasPriority(spec_House,sort_Person,3).

hasSort(spec_House,sort_Thing,1).
isNonDataSort(spec_House,sort_Thing).
sortHasPriority(spec_House,sort_Thing,5).

hasSort(spec_House,sort_Value,1).
isDataSort(spec_House,sort_Value).
sortHasPriority(spec_House,sort_Value,0).

hasSort(spec_House,sort_House,1).
hasParentSort(spec_House,sort_House,sort_Thing,1).
isNonDataSort(spec_House,sort_House).
sortHasPriority(spec_House,sort_House,3).

hasSort(spec_House,sort_Inhabitant,1).
hasParentSort(spec_House,sort_Inhabitant,sort_Person,1).
isNonDataSort(spec_House,sort_Inhabitant).
sortHasPriority(spec_House,sort_Inhabitant,2).

hasSort(spec_House,sort_Person,1).
hasParentSort(spec_House,sort_Person,sort_Thing,1).
isNonDataSort(spec_House,sort_Person).
sortHasPriority(spec_House,sort_Person,3).

%% operators %%
hasOp(spec_House,po_house1,1).
opHasSort(spec_House,po_house1,sort_House,domain,1).
isNonDataOp(spec_House,po_house1).
opHasPriority(spec_House,po_house1,2).

hasOp(spec_House,po_inhabitant1,1).
opHasSort(spec_House,po_inhabitant1,sort_Inhabitant,domain,1).
isNonDataOp(spec_House,po_inhabitant1).
opHasPriority(spec_House,po_inhabitant1,0).

hasOp(spec_House,po_mainTenant,1).
opHasSort(spec_House,po_mainTenant,sort_House,arg1,1).
opHasSort(spec_House,po_mainTenant,sort_Inhabitant,domain,1).
isNonDataOp(spec_House,po_mainTenant).
opHasPriority(spec_House,po_mainTenant,0).

hasOp(spec_House,po_owner1,1).
opHasSort(spec_House,po_owner1,sort_Person,domain,1).
isNonDataOp(spec_House,po_owner1).
opHasPriority(spec_House,po_owner1,2).

hasOp(spec_House,po_ownerOf,1).
opHasSort(spec_House,po_ownerOf,sort_House,arg1,1).
opHasSort(spec_House,po_ownerOf,sort_Person,domain,1).
isNonDataOp(spec_House,po_ownerOf).
opHasPriority(spec_House,po_ownerOf,3).

hasOp(spec_House,po_v1,1).
opHasSort(spec_House,po_v1,sort_Value,domain,1).
isDataOp(spec_House,po_v1).
opHasPriority(spec_House,po_v1,0).

hasOp(spec_House,po_v2,1).
opHasSort(spec_House,po_v2,sort_Value,domain,1).
isDataOp(spec_House,po_v2).
opHasPriority(spec_House,po_v2,0).

%% predicates %%
%% axioms %%

%% Axiom Ax-AssignOwner:p:2 %%
hasAxiom(spec_House,4,1).
axHasEquivalenceClass(spec_House,4,4,1).
isNonDataAx(spec_House,4).
axHasPriority(spec_House,4,2).
axInvolvesPredOp(spec_House,4,po_owner1,1).
axInvolvesPredOp(spec_House,4,po_ownerOf,1).
axInvolvesPredOp(spec_House,4,po_house1,1).


%% Axiom Ax-AssignMainTenant:p:2 %%
hasAxiom(spec_House,5,1).
axHasEquivalenceClass(spec_House,5,5,1).
isNonDataAx(spec_House,5).
axHasPriority(spec_House,5,2).
axInvolvesPredOp(spec_House,5,po_inhabitant1,1).
axInvolvesPredOp(spec_House,5,po_house1,1).
axInvolvesPredOp(spec_House,5,po_mainTenant,1).

