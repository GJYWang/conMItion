library(conMItion)

before_load = NULL

# Loop over each association type: "CMI", and "MI"
for (asso_type in c("CMI", "MI")) {
  # Capture the list of objects in the environment before loading the data
  before_load = ls()

  # Load the result data for the current association type and cancer type
  load(file = paste('result',
                    paste(asso_type,'Rdata',sep = '.'),
                    sep = '/'))

  # Capture the list of objects after loading, to identify the newly loaded object
  after_load = ls()
  loaded_table = setdiff(after_load,before_load)
  association_martix = get(loaded_table)
  rm(list = loaded_table)

  # Load the pre-sorted permutation vector for the current association type and cancer type
  load(file = paste('permutation_sorted',
                    paste('permutationVector',
                          asso_type,
                          'Rdata',sep = '.'),
                    sep = '/'))

  # Define P value matrix and set it to be 1
  P_Value_Mat = association_martix
  P_Value_Mat = P_Value_Mat*0+1

  # Calculate p-values for each entry in the matrix
  for (i in 1:(nrow(P_Value_Mat)-1)) {
    for (j in (i+1):nrow(P_Value_Mat) ) {
      P_Value_Mat[i,j] = getPValue(association_martix[i,j],permutationMIVector)
    }
  }

  # Save the association matrix, and P value, to a file
  save(association_martix, P_Value_Mat, file = paste('result',
                    paste(asso_type,'stats.sig','Rdata',sep = '.'),
                    sep = '/'))

}
