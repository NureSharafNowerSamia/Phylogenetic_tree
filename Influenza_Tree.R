library(ggtree)
library(treeio)
library(ape)
library(tidyverse)

tree <- read.tree("your_treefile.treefile")
tree_rooted <- midpoint.root(tree)

metadata <- read.csv("your_metadata.csv", stringsAsFactors = FALSE)

p <- ggtree(tree_rooted, branch.length = "none") %<+% metadata +
  geom_tippoint(aes(color = Categories), size = 2) +  
  theme_tree2() +
  labs(color = "Category")
  

p <- p + geom_tiplab(size = 2)

# Ensure tip labels are consistent
head(tree_rooted$tip.label)
head(metadata$Node.IDs)

meta_matched <- metadata[match(tree_rooted$tip.label, metadata$Node.IDs), , drop = FALSE]

# Confirm no NAs were introduced (i.e., all matches were successful)
sum(is.na(meta_matched$Country))  

rownames(metadata) <- metadata$Node.IDs  # Check if the names matched
g <- gheatmap(p,
              meta_matched[, c("Country"), drop = FALSE],
              colnames_position = "top",
              colnames_angle = 0,
              width = 0.2) +
  scale_fill_brewer(palette = "Set3", na.value = "white")
  
####Identify clades with bootstrap <70% and label them as a new clade
# Extract internal node labels
support_vals <- as.numeric(tree_rooted$node.label)
low_support_nodes <- which(!is.na(support_vals) & support_vals < 70) + length(tree_rooted$tip.label)  

all_internal_nodes <- (length(tree_rooted$tip.label) + 1):(length(tree_rooted$tip.label) + tree_rooted$Nnode)

high_support_nodes <- setdiff(all_internal_nodes, low_support_nodes)

#### Highlight the clades in accordance to your node labels
for (node in high_support_nodes) {
  g <- g + geom_hilight(node = 170,
                           fill="gold")
}

for (node in low_support_nodes) {
  g1 <- g + geom_hilight(node = 169,
                           fill="red")
}


