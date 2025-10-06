# Load required libraries for the analysis
library(conMItion)
library(parallel)

# Load pre-existing test data for cell fraction in cancer
load(file = '../data/CellFraction.Rdata')

# Set the number of cores for parallel computation to 6
numCores = 20

# Use MI to calculate association
calculate_MI <- function(i, cell_composition) {
  cat(i,'\n')
  MImat2mat(
    cell_composition,
    matrix(rep(cell_composition[i,], each = nrow(cell_composition)), nrow = nrow(cell_composition), byrow = FALSE),
    bin = 8, sp_order = 2
  )
}

# Use CMI (one condition variable) to calculate association
calculate_CMI <- function(i, cell_composition, malignant) {
  cat(i,'\n')
  CMImat2mat(
    cell_composition,
    matrix(rep(cell_composition[i,], each = nrow(cell_composition)), nrow = nrow(cell_composition), byrow = FALSE),
    malignant,
    bin = 8, sp_order = 2
  )
}

MIMatrix <- t(mcmapply(
  calculate_MI,
  1:nrow(cell_composition),
  MoreArgs = list(cell_composition = cell_composition),
  mc.cores = numCores
))

CMIMatrix <- t(mcmapply(
  calculate_CMI,
  1:nrow(cell_composition),
  MoreArgs = list(cell_composition = cell_composition, malignant = malignant),
  mc.cores = numCores
))

row.names(CMIMatrix) = row.names(cell_composition)
colnames(CMIMatrix) = row.names(cell_composition)
row.names(MIMatrix) = row.names(cell_composition)
colnames(MIMatrix) = row.names(cell_composition)

# Create a directory to store the results; if it exists, no warning is shown
dir.create('result', showWarnings = F)

# Save the resulting matrices to files in the 'result' directory
save(MIMatrix,
     file = paste('result',
                  paste('MI','Rdata',sep = '.'),
                  sep = '/'))
save(CMIMatrix,
     file = paste('result',
                  paste('CMI','Rdata',sep = '.'),
                  sep = '/'))
