# conMItion Package Use Case Tutorial

This repository provides a practical use case of the `conMItion` package, designed as a tutorial to help users understand how to leverage the package for analyzing associations such as mutual information (MI) and conditional mutual information (CMI) in cancer genomics data. Specifically, this example focuses on utilizing MI and CMI, with tumor purity and mutation burden as condition variables, to explore associations in the context of The Cancer Genome Atlas (TCGA) Bladder Cancer (BLCA) dataset.

## Overview

The primary objective of this use case is to identify associations between Copy Number and Mutation data using the following metrics:

- **Mutual Information (MI)**
- **Conditional Mutual Information (CMI)**: 
  - Given tumor purity as a conditional variable.
  - Given both tumor purity and mutation burden as conditional variables.

## Data

The dataset used in this example is from TCGA BLCA and is stored in `data/conMItion.TestData.BLCA.Rdata`. The key variables included in this Rdata file are:

- `mutationMatrix`: Contains MC3 mutation data.
- `CNVMatrix`: Contains Copy Number data, where the copy numbers of 40 neighboring genes are averaged to reduce runtime.
- `reducedGeneList`: Stores the corresponding gene identifiers for the CNVMatrix.
- `PurityVector`: Includes tumor purity data.
- `mutationBurden`: Represents the mutation burden.

## Workflow

The entire process is organized into four main steps:

### Step 1: Calculate Associations

Calculate the associations using MI and CMI. This step utilizes the `parallel` package to enhance computational efficiency.

To execute this step, run:
```bash
Rscript 1.Calc.Asso.R
```

### Step 2: Generate Permutation Distributions

Generate bootstrapped/permutation distributions for estimating statistical significance. This step is divided into 500 jobs and distributed across multiple computing nodes.

To execute this step, run:
```bash
bash 2.Mut_CNV_permu.sh
```

### Step 3: Organize Permutation Results

Collect and sort all permutation results generated in Step 2 to prepare them for the final analysis.

To execute this step, run:
```bash
Rscript 3.org_permu.R
```

### Step 4: Summarize Results

Summarize the results from Steps 1 and 3. The script generates a summary dataframe in R, including P values for the associations.

To execute this step, run:
```bash
Rscript 4.summarize_result.R
```
