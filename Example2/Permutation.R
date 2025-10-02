require(conMItion)
# Parse parameter
args <- commandArgs(TRUE)
bulkIdx = as.numeric(args[1])
permutationTimes = as.numeric(args[2])
# Load pre-existing test data for cell fraction in cancer
load(file = '../data/CellFraction.Rdata')

permutationMIVector = MImat2matPermu(cell_composition,
                                     cell_composition,
                                     bin = 8, sp_order = 2,
                                     bulkIdx = bulkIdx,
                                     permutationTimes = permutationTimes)

save(permutationMIVector,
     file = paste('permutation',
                  paste('permutationVector','MI',bulkIdx,'Rdata',sep = '.'),
                  sep = '/'))

permutationMIVector = CMImat2matPermu(cell_composition,
                                      cell_composition,
                                      malignant,
                                      bin = 8, sp_order = 2,
                                      bulkIdx = bulkIdx,
                                      permutationTimes = permutationTimes)

save(permutationMIVector,
     file = paste('permutation',
                  paste('permutationVector','CMI',bulkIdx,'Rdata',sep = '.'),
                  sep = '/'))
