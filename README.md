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
- `expressionMatrix`: Contains gene expression data.
- `CNVMatrix`: Contains Copy Number data, where the copy numbers of 40 neighboring genes are averaged to reduce runtime.
- `reducedGeneList`: Stores the corresponding gene identifiers for the CNVMatrix.
- `PurityVector`: Includes tumor purity data.
- `mutationBurden`: Represents the mutation burden.

## Workflow

This use case focuses on association analysis between Copy Number and gene expression. But replacing `expressionMatrix` to `mutationMatrix`, association between mutation and copy number will be analyzed. The entire process is organized into four main steps:

### Step 1: Calculate Associations

Calculate the associations using MI and CMI. This step utilizes the `parallel` package to enhance computational efficiency.

To execute this step, run:
```bash
Rscript 1.Calc.Asso.R
```

### Step 2: Generate Permutation Distributions

Generate bootstrapped/permutation distributions for estimating statistical significance. This step is divided into 500 jobs and distributed across multiple computing nodes. Please change mxqsub to other job submission command such as qsub based on the system. 
To execute this step, run:
```bash
bash 2.permu.sh
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


## Additional Use Case: Cell Fraction Associations (Example2)

In addition to the primary use case, we provide a second example located in the `Example2` folder. This use case demonstrates how the `conMItion` package can be used to calculate associations between cell fractions in single cell cancer data.

### Overview

The objective of this use case is to explore the relationships between various cell fractions using the `conMItion` package. Similar to the primary use case, this analysis employs the metrics of MI and CMI.

### Data

The dataset for this use case is available in `data/CellFraction.Rdata`. This Rdata file includes:

- `cell_composition`: Contains the cell fraction data for different cell types.
- `malignant`: Includes fraction of malignant cells.

### Workflow

This use case is structured into the following similar steps (Please run the codes below in the `Example2` folder):

### Step 1 & 2: Calculate Associations & Generate Permutation Distributions

Calculate the associations using MI and CMI. This step utilizes the `parallel` package to enhance computational efficiency. Generate bootstrapped/permutation distributions for estimating statistical significance. This step is divided into 500 jobs and distributed across multiple computing nodes. Please change mxqsub to other job submission command such as qsub based on the system. 


To execute these steps, run:
```bash
Rscript 1.Calc.Asso.R
bash 2.FRAC_permu.sh
```

### Step 3: Organize Permutation & Summarize Results 

Collect and sort all permutation results generated in Step 2 to prepare them for the final analysis. Summarize the results from Steps 1 and 3. The script generates a summary dataframe in R, including P values for the associations.


To execute these steps, run:
```bash
Rscript 3.org_permu.R
Rscript 4.summarize_result.R
```
