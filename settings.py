###### In this settings file we define some global variables ######

##### The input file should contain the input spaces, i.e. specifications to be blended. The file can also contain other specifications, so that e.g., in CASL, the input spaces can inherit structure from a same parent space. However, a parent space is not necessarily a generic space. Currently, only two input spaces are supported.

inputFile = "examples/minimal.casl"
inputSpaceNames = ["S1","S2"]

###### The number of models to be generated (0 for all models)
numModels = 1

###### The minimal number of iterations for generalization
minIterationsGeneralize = 1

###### The maximal number of iterations for generalization
maxIterationsGeneralize = 20

###### Percentage of blend value below the currently highest value found so far that we want to keep in the results. 0 means that we only keep the blends with the highest value found so far, 100 means to consider all blends.
blendValuePercentageBelowHighestValueToKeep = 0

###### Time limit for eprover and darwin consistency check in seconds CPU time
eproverTimeLimit = 4
darwinTimeLimit = 0.1


###### Path to the HETS executable ######
useHetsAPI = 0
hetsUrl = 'http://localhost:8000/'
hetsExe = 'hets'

###### Switch to enable the explicit generation of blend files (see function writeBlends.py) ######
genExplicitBlendFiles = True




###################################################################

## Here is space to quickly overwrite the above settings for debugging purposes.

# inputFile = "examples/LPNMR/houseBoat.casl"
# inputSpaceNames = ["Boat","House"]

# inputFile = "examples/LPNMR/naturalsAndLists_fact.casl"
# inputFile = "examples/LPNMR/naturalsAndLists_fact_minimal.casl"
# inputSpaceNames = ["Nat","List"]

inputFile = "examples/music_IJCAI/music_blend.casl"
inputSpaceNames = ["Emaj7","Fmin7"]

inputFile = "examples/demo_examples/tritone_demo.casl"
inputSpaceNames = ["G7","Bbmin"]

