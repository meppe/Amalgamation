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
eproverTimeLimit = 5
darwinTimeLimit = 0.1

###### Path to the HETS executable ######
hetsExe = 'hets'

###### Switch to enable the explicit generation of blend files (see function writeBlends.py) ######
genExplicitBlendFiles = False

###### Switch to enable pause after generalisation phase. Useful for demos
pauseAfterGenPhase = True


###################################################################

## Here is space to quickly overwrite the above settings for debugging purposes.

# inputFile = "examples/music/tritone_demo.casl"
# inputSpaceNames = ["G7","Bbmin"]

# inputFile = "examples/music/cadenceBlendFusionBackdoor.casl"
# inputSpaceNames = ["PhrygianCadence","PerfectCadence"]

# inputFile = "examples/maths/naturalsAndLists_sum.casl"
# inputSpaceNames = ["Nat","List"]

inputFile = "examples/maths/naturalsAndLists_sum_minimal.casl"
inputSpaceNames = ["Nat","List"]

# inputFile = "examples/maths/naturalsAndLists_fact.casl"
# inputSpaceNames = ["Nat","List"]

# inputFile = "examples/music/allthethings_demo.casl"
# inputSpaceNames = ["Emaj7","Fmin7"]


