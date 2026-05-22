# Load required libraries for the analysis
library(conMItion)
library(parallel)

# Load pre-existing test data for bladder cancer
load('data/conMItion.TestData.BLCA.Rdata')

# Create a directory to store the results; if it exists, no warning is shown
dir.create('result', showWarnings = FALSE)

# Set the number of cores for parallel computation to 6
numCores = 60

# Use MI to calculate association
calculate_MI <- function(i, expressionMatrix, CNVMatrix) {
  cat(i,'\n')
  MImat2mat(
    CNVMatrix,
    matrix(rep(expressionMatrix[i,], each = nrow(CNVMatrix)), nrow = nrow(CNVMatrix), byrow = FALSE),
    bin = 8, sp_order = 2
  )
}

MIMatrix <- t(mcmapply(
  calculate_MI,
  1:nrow(expressionMatrix),
  MoreArgs = list(expressionMatrix = expressionMatrix, CNVMatrix = CNVMatrix),
  mc.cores = numCores
))

# Save the resulting matrix to a file in the 'result' directory
save(MIMatrix,
     file = paste('result',
                  paste('MI','BLCA','Rdata',sep = '.'),
                  sep = '/'))
#########

# Use CMI (one condition variable) to calculate association
calculate_CMI <- function(i, expressionMatrix, CNVMatrix, PurityVector) {
  cat(i,'\n')
  CMImat2mat(
    CNVMatrix,
    matrix(rep(expressionMatrix[i,], each = nrow(CNVMatrix)), nrow = nrow(CNVMatrix), byrow = FALSE),
    PurityVector,
    bin = 8, sp_order = 2
  )
}

CMIMatrix <- t(mcmapply(
  calculate_CMI,
  1:nrow(expressionMatrix),
  MoreArgs = list(expressionMatrix = expressionMatrix, CNVMatrix = CNVMatrix, PurityVector = PurityVector),
  mc.cores = numCores
))

# Save the resulting matrix to a file in the 'result' directory
save(CMIMatrix,
     file = paste('result',
                  paste('CMI','BLCA','Rdata',sep = '.'),
                  sep = '/'))
#########

# Use CMI (two condition variables) to calculate association
calculate_CMIBi <- function(i, expressionMatrix, CNVMatrix, PurityVector, MutBurdenVector) {
  cat(i,'\n')
  CMIBiCondimat2mat(
    CNVMatrix,
    matrix(rep(expressionMatrix[i,], each = nrow(CNVMatrix)), nrow = nrow(CNVMatrix), byrow = FALSE),
    PurityVector, MutBurdenVector,
    bin = 8, sp_order = 2
  )
}

CMIBiCondiMatrix <- t(mcmapply(
  calculate_CMIBi,
  1:nrow(expressionMatrix),
  MoreArgs = list(expressionMatrix = expressionMatrix, CNVMatrix = CNVMatrix, PurityVector = PurityVector, MutBurdenVector = mutationBurden),
  mc.cores = numCores
))

# Save the resulting matrix to a file in the 'result' directory
save(CMIBiCondiMatrix,
     file = paste('result',
                  paste('CMIBi','BLCA','Rdata',sep = '.'),
                  sep = '/'))
#########
