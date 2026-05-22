require(conMItion)
# Parse parameter
args <- commandArgs(TRUE)
bulkIdx = as.numeric(args[1])
permutationTimes = as.numeric(args[2])
# Load pre-existing test data for bladder cancer
load('data/conMItion.TestData.BLCA.Rdata')

permutationMIVector = CMImat2matPermu(expressionMatrix,
                                      CNVMatrix,
                                      PurityVector,
                                      bin = 8, sp_order = 2,
                                      bulkIdx = bulkIdx,
                                      permutationTimes = permutationTimes)

save(permutationMIVector,
     file = paste('permutation',
                  paste('permutationVector','CMI','BLCA',bulkIdx,'Rdata',sep = '.'),
                  sep = '/'))