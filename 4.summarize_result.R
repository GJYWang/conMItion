library(conMItion)

# Define the cancer type BLCA (Bladder Cancer)
cancerType = 'BLCA'

# Function to convert a matrix to a sorted dataframe
matrix_to_dataframe <- function(mat) {
  # Find indices in the matrix where values are non-NA and greater than zero
  indices <- which((!is.na(mat) & mat > 0), arr.ind = TRUE)
  
  # Create a dataframe from the indices and corresponding matrix values
  df <- data.frame(
    Row = indices[, 1],     # Row indices
    Column = indices[, 2],  # Column indices
    Value = mat[indices]    # Corresponding values in the matrix
  )
  
  # Sort the dataframe by the 'Value' column in descending order
  sorted_df = df[order(df$Value, decreasing = TRUE),]
  
  # Return the sorted dataframe
  return(sorted_df)
}

# Loop over each association type: "CMIBi", "CMI", and "MI"
for (asso_type in c("CMIBi", "CMI", "MI")) {
  
  # Capture the list of objects in the environment before loading the data
  before_load = ls()
  
  # Load the result data for the current association type and cancer type
  load(file = paste('result',
                    paste(asso_type, cancerType, 'Rdata', sep = '.'),
                    sep = '/'))
  
  # Capture the list of objects after loading, to identify the newly loaded object
  after_load = ls()
  loaded_table = setdiff(after_load, before_load)  # Determine the new object loaded
  association_table = get(loaded_table)  # Retrieve the loaded data matrix
  rm(list = loaded_table)  # Remove the loaded object to clean the environment
  
  # Convert the association matrix into a sorted dataframe
  association_df <- matrix_to_dataframe(association_table)
  
  # Load the pre-sorted permutation vector for the current association type and cancer type
  load(file = paste('permutation_sorted',
                    paste('permutationVector',
                          asso_type, cancerType,
                          'Rdata', sep = '.'),
                    sep = '/'))
  
  # Calculate p-values for each entry in the association dataframe
  P_Value = sapply(1:nrow(association_df), 
                   function(x) 
                     getPValue(association_df[x, 3], permutationMIVector))  # assuming getPValue is a function provided by conMItion or defined elsewhere
  
  # Add the calculated p-values as a new column to the association dataframe
  association_df = data.frame(association_df, P = P_Value)
  
  # Save the modified association dataframe, which includes p-values, to a file
  save(association_df, file = paste('result',
                                    paste(asso_type, cancerType, 'asso_df', 'Rdata', sep = '.'),
                                    sep = '/'))
}