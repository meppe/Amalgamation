#program base.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec House %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_House).
hasId(spec_House,0).

%% sorts %%
hasSort(spec_House,sort_Medium,0).
isDataSort(spec_House,sort_Medium).
sortHasPriority(spec_House,sort_Medium,0).

hasSort(spec_House,sort_Object,0).
isNonDataSort(spec_House,sort_Object).
sortHasPriority(spec_House,sort_Object,1).

hasSort(spec_House,sort_Person,0).
isNonDataSort(spec_House,sort_Person).
sortHasPriority(spec_House,sort_Person,1).

%% operators %%
hasOp(spec_House,po_house,0).
opHasSort(spec_House,po_house,sort_Object,domain,0).
isNonDataOp(spec_House,po_house).
opHasPriority(spec_House,po_house,1).

hasOp(spec_House,po_land,0).
opHasSort(spec_House,po_land,sort_Medium,domain,0).
isDataOp(spec_House,po_land).
opHasPriority(spec_House,po_land,0).

hasOp(spec_House,po_object,0).
opHasSort(spec_House,po_object,sort_Object,domain,0).
isNonDataOp(spec_House,po_object).
opHasPriority(spec_House,po_object,1).

hasOp(spec_House,po_person,0).
opHasSort(spec_House,po_person,sort_Person,domain,0).
isNonDataOp(spec_House,po_person).
opHasPriority(spec_House,po_person,1).

hasOp(spec_House,po_resident,0).
opHasSort(spec_House,po_resident,sort_Person,domain,0).
isNonDataOp(spec_House,po_resident).
opHasPriority(spec_House,po_resident,1).

hasOp(spec_House,po_water,0).
opHasSort(spec_House,po_water,sort_Medium,domain,0).
isDataOp(spec_House,po_water).
opHasPriority(spec_House,po_water,0).

%% predicates %%
hasPred(spec_House,po_on,0).
predHasSort(spec_House,po_on,sort_Object,arg1,0).
predHasSort(spec_House,po_on,sort_Medium,arg2,0).
predHasPriority(spec_House,po_on,1).

%% axioms %%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% spec Boat %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

spec(spec_Boat).
hasId(spec_Boat,1).

%% sorts %%
hasSort(spec_Boat,sort_Medium,0).
isDataSort(spec_Boat,sort_Medium).
sortHasPriority(spec_Boat,sort_Medium,0).

hasSort(spec_Boat,sort_Object,0).
isNonDataSort(spec_Boat,sort_Object).
sortHasPriority(spec_Boat,sort_Object,1).

hasSort(spec_Boat,sort_Person,0).
isNonDataSort(spec_Boat,sort_Person).
sortHasPriority(spec_Boat,sort_Person,1).

%% operators %%
hasOp(spec_Boat,po_boat,0).
opHasSort(spec_Boat,po_boat,sort_Object,domain,0).
isNonDataOp(spec_Boat,po_boat).
opHasPriority(spec_Boat,po_boat,1).

hasOp(spec_Boat,po_land,0).
opHasSort(spec_Boat,po_land,sort_Medium,domain,0).
isDataOp(spec_Boat,po_land).
opHasPriority(spec_Boat,po_land,0).

hasOp(spec_Boat,po_object,0).
opHasSort(spec_Boat,po_object,sort_Object,domain,0).
isNonDataOp(spec_Boat,po_object).
opHasPriority(spec_Boat,po_object,1).

hasOp(spec_Boat,po_passenger,0).
opHasSort(spec_Boat,po_passenger,sort_Person,domain,0).
isNonDataOp(spec_Boat,po_passenger).
opHasPriority(spec_Boat,po_passenger,1).

hasOp(spec_Boat,po_person,0).
opHasSort(spec_Boat,po_person,sort_Person,domain,0).
isNonDataOp(spec_Boat,po_person).
opHasPriority(spec_Boat,po_person,1).

hasOp(spec_Boat,po_water,0).
opHasSort(spec_Boat,po_water,sort_Medium,domain,0).
isDataOp(spec_Boat,po_water).
opHasPriority(spec_Boat,po_water,0).

%% predicates %%
hasPred(spec_Boat,po_on,0).
predHasSort(spec_Boat,po_on,sort_Object,arg1,0).
predHasSort(spec_Boat,po_on,sort_Medium,arg2,0).
predHasPriority(spec_Boat,po_on,1).

%% axioms %%



