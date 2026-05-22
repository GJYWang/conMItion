mkdir -p permutation
# Start a loop that counts downwards from 500 to 1
# The bootstrapping distribution is calculated through different nodes
for (( i=500; i>=1; i-- )); do
  # Print the current value of i to the terminal
  echo $i

  # Iterate over a set of association types: "CMIBi", "CMI", and "MI"
  for asso_type in "CMIBi" "CMI" "MI"; do
    # Submit a job to the queue using `mxqsub` with specific arguments
    # mxqsub is the job submission command with MARIUX
    # This should be replaced by other submission command, e.g. qsub, based on the OS
    mxqsub --stdout=stdout.log --stderr=stderr.log \
        --group-name=permutation.test --tmpdir=2G \
        --threads=1 --memory=10G -t 1w \
    Rscript $asso_type.permutation.R $i 200000

    # Sleep for 1 seconds before proceeding to the next task, to avoid overwhelming the system
    sleep 1
  done
done
