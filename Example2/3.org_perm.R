# Define the maximum index for the data processing
bulkIdx_Max = 200

# Create a directory called 'permutation_sorted' to store sorted permutation result files
# Suppress warnings if the directory already exists
dir.create('permutation_sorted', showWarnings = FALSE)

# Loop over each association type: "CMI", and "MI"
for (asso_type in c("CMI", "MI")) {
  # Initialize a vector to store all permutation vectors for the current association type
  permutationMIVectorAll = NULL

  # Loop over each index from 1 to the maximum bulk index
  for (bulkIdx in 1:bulkIdx_Max) {
    # Load the permutation vector from the corresponding file for the current bulk index
    load(file = paste('permutation',
                      paste('permutationVector',
                            asso_type,
                            bulkIdx,'Rdata',sep = '.'),
                      sep = '/'))
    # Append the loaded permutation vector to the cumulative vector for all iterations
    permutationMIVectorAll = c(permutationMIVectorAll, permutationMIVector)

  }
  # Sort the combined permutation vector in ascending order
  permutationMIVector = sort(permutationMIVectorAll)

  # Save the sorted permutation vector to a file in 'permutation_sorted' directory
  save(permutationMIVector,
       file = paste('permutation_sorted',
                    paste('permutationVector',
                          asso_type,
                          'Rdata',sep = '.'),
                    sep = '/'))
}
