# 🧬 Phylogenetic Tree Visualization with Metadata and Clade Highlighting

This R script uses the `ggtree`, `treeio`, `ape`, and `ggplot2` packages to visualize a rooted phylogenetic tree, overlay sample metadata, and highlight clades based on bootstrap support values.

## 📦 Required R Packages

Ensure the following R packages are installed:

```r
install.packages(c("ape", "tidyverse"))
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("ggtree", "treeio"))
