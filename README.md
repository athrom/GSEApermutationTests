# GSEApermutationTests
Contains code for multiple hypothesis testing of data from javaGSEA desktop app

Gene set enrichment analysis (GSEA) is a useful technique to the analysis of microarray datasets. However, when multiple GSEA comparisons are run (ex. patient vs. control for multiple stimulation conditions), multiple hypothesis correction is not taken into account. To account for this, sample labels can randomly be shuffled, and the number of falsely identified significant sets can be noted to compute a false discovery rate (FDR). This repository contains code I used to shuffle around sample labels 1000X to run GSEA (labelsforpermgsea.m). It also contains python functions to run GSEA 1000X using the software and extract significant sets, compute an FDR, and delete all generate files for the 1000 permutations from the appropriate directory. 

Note that code in this repository contains variables specific to my computer, as I wrote these quickly just to finish a data analysis, but I included them in my repository in case these examples are useful for someone else trying to compensate for multiple hypothesis correction with the javaGSEA desktop application.
