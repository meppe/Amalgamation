###### In this settings file we define some global variables ######

##### The input file should contain the input spaces, i.e. specifications to be blended. The file can also contain other specifications, so that e.g., in CASL, the input spaces can inherit structure from a same parent space. However, a parent space is not necessarily a generic space. Currently, only two input spaces are supported.

inputFile = "examples/minimal.casl"
inputSpaceNames = ["S1","S2"]

###### The number of models to be generated (0 for all models)
numModels = 20

###### The maximal number of iterations for generalization
maxIterationsGeneralize = 160

###### Percentage of blend value below the currently highest value found so far that we want to keep in the results. 0 means that we only keep the blends with the highest value found so far, 100 means to consider all blends.
blendValuePercentageBelowHighestValueToKeep = 20

###### Time limit for eprover and darwin consistency check, and for clingo (ASP solving), in seconds CPU time
eproverTimeLimit = 4
darwinTimeLimit = 0 ### 0 means that we don't use darwin at all. 
clingoTimeLimit = 600345

###### Number of cores to be used for ASP solving (currently only one supported)
numCores = 4

###### Consistency check: brave or careful
consistencyCheckBehavior = "brave" ### If we can not prove inconsistency, we assume the blend is consistent
# consistencyCheckBehavior = "careful"  ### If we can not prove consistency, we assume the blend is inconsistent

###### Path to the HETS executable ######
useHetsAPI = 0
hetsUrl = 'http://localhost:8000/'
hetsExe = 'hets'

###### Switch to enable the explicit generation of blend files (see function writeBlends.py) ######
genExplicitBlendFiles = False

###### A switch to determine whether to only generalise or whether to also  (mostly for debugging...)
generaliseOnly = False

###### Determines the renaming mode. Can be either mergeNames or renameTo. This determines whether renamed elements in a spec are merged, i.e., connecged with a "-" to generate a new name or whether one name is selected as target name. 
# renamingMode = "renameTo"
renamingMode = "mergeNames"


###################################################################

## Here is space to quickly overwrite the above settings for debugging purposes.

# inputFile = "examples/maths/naturalsAndLists_fact.casl"
# inputFile = "examples/maths/naturalsAndLists_fact_minimal.casl"
# inputSpaceNames = ["Nat","List"]

# inputFile = "examples/LPNMR/naturalsAndLists_fact.casl"
# inputFile = "examples/maths/naturalsAndLists_sum_minimal.casl"
# inputSpaceNames = ["Nat","List"]

## This runs fine
# inputFile = "examples/music/tritone_demo.casl"
# inputSpaceNames = ["G7","Bbmin"]

# inputFile = "examples/testExamples/generaliseSortTest.casl"
# inputSpaceNames = ["S1","S2"]

########## AIJ-paper examples ##############
# inputFile = "examples/AIJ-paper/tritone_demo.casl"
# inputSpaceNames = ["G7","Bbmin"]

# inputFile = "examples/AIJ-paper/naturalsAndLists_sum_minimal.casl"
# inputFile = "examples/AIJ-paper/naturalsAndLists_fact_minimal.casl"
# inputSpaceNames = ["List","Nat"]

# inputFile = "examples/AIJ-paper/HouseBoat_GoguenWebsite.casl"
# inputFile = "examples/AIJ-paper/HouseBoat_simple.casl"
# inputFile = "examples/AIJ-paper/HouseBoat_movingProp.casl" # This works very well, results are as expected. 
# inputFile = "examples/AIJ-paper/BoatHouse.casl" # This works very well, results are as expected. 
# inputSpaceNames = ["House","Boat"]

# inputFile = "examples/AIJ-paper/coltraneChanges.casl" 
# inputSpaceNames = ["List","PerfectCadence"]

# inputFile = "examples/AIJ-paper/Chord_CycGroup.casl" 
# inputSpaceNames = ["GeneratorChord","CycEls"]

inputFile = "examples/AIJ-paper/Chord_CycGroup.casl" 
inputSpaceNames = ["Progression","Cyc12"]


