mkdir -p permutation
# Start a loop that counts downwards from 200 to 1
# The bootstrapping distribution is calculated through different nodes
for (( i=200; i>=1; i-- ))
do
  echo $i
  # Submit a job to the queue using `mxqsub` with specific arguments
  # mxqsub is the job submission command with MARIUX
  # This should be replaced by other submission command, e.g. qsub, based on the OS
  mxqsub --stdout=stdout.log --stderr=stderr.log \
      --group-name=permutation.Exam.2 --tmpdir=2G \
      --threads=1 --memory=10G -t 1w \
  Rscript Permutation.R $i 50000

  # Sleep for 1 seconds before proceeding to the next task, to avoid overwhelming the system
  sleep 1
done
