# tidyomics

> A comprehensive R package for visualizing multiomics data

[![CRAN status](https://www.r-pkg.org/badges/version/MultiomicViz)](https://CRAN.R-project.org/package=MultiomicViz)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

## Overview

MultiomicViz provides a unified framework for creating publication-ready visualizations of multiomics data. The package offers intuitive functions for generating a wide range of plots commonly used in genomics, transcriptomics, proteomics, and metabolomics research.

## Features

### 🔥 Core Visualizations
- **Heatmaps** - Expression matrices, correlation matrices, and clustering
- **PCA & Dimensionality Reduction** - Principal component analysis with customizable aesthetics
- **Volcano Plots** - Differential expression visualization with significance thresholds

### 📊 Specialized Genomics Plots
- **Manhattan Plots** - GWAS results and genomic associations
- **Genome Statistics** - Coverage plots, gene density maps, and genomic feature distributions
- **Phylogenetic Trees** - Species relationships and evolutionary analysis
- **Synteny Plots** - Genomic collinearity and structural comparisons

### 🕐 Temporal & Comparative Analysis
- **Time Series Plots** - Longitudinal expression patterns and trends
- **Multiple Sequence Alignments** - Visualization of aligned biological sequences
- **Circus Plots** - Genomic interactions and structural variants

### 🔍 Set Analysis & Comparisons
- **Venn Diagrams** - Set intersections for up to 5 sets
- **UpSet Plots** - Complex set intersections with advanced filtering

## Installation

### From GitHub (Development Version)
```r
# Install devtools if you haven't already
install.packages("devtools")

# Install MultiomicViz
devtools::install_github("yourusername/MultiomicViz")
```

### From CRAN (Stable Release)
```r
install.packages("MultiomicViz")
```

## Dependencies

MultiomicViz builds upon several excellent R packages:
- `ggplot2` - Grammar of graphics
- `ComplexHeatmap` - Advanced heatmap visualizations  
- `ggtree` - Phylogenetic tree plotting
- `UpSetR` - UpSet plot generation
- `VennDiagram` - Venn diagram creation
- `circlize` - Circular visualization

## Quick Start

```r
library(MultiomicViz)

# Load example data
data("example_expression")

# Create a heatmap
plot_heatmap(example_expression, 
             cluster_rows = TRUE, 
             cluster_cols = TRUE,
             show_row_names = FALSE)

# Generate PCA plot
plot_pca(example_expression, 
         color_by = "treatment",
         shape_by = "timepoint")

# Create volcano plot
plot_volcano(deg_results, 
             fc_threshold = 2, 
             pval_threshold = 0.05)
```

## Function Reference

### Expression Analysis
- `plot_heatmap()` - Generate expression heatmaps with clustering
- `plot_pca()` - Principal component analysis plots
- `plot_volcano()` - Volcano plots for differential expression

### Genomics & Phylogenetics  
- `plot_manhattan()` - Manhattan plots for GWAS data
- `plot_genome_coverage()` - Genome coverage visualization
- `plot_gene_density()` - Gene density across chromosomes
- `plot_phylo_tree()` - Phylogenetic tree visualization
- `plot_synteny()` - Synteny and collinearity plots

### Time Series & Alignments
- `plot_timeseries()` - Temporal expression patterns
- `plot_msa()` - Multiple sequence alignment visualization
- `plot_circus()` - Circular genomic plots

### Set Analysis
- `plot_venn()` - Venn diagrams for set intersections
- `plot_upset()` - UpSet plots for complex set relationships

## Example Workflows

### Differential Expression Analysis
```r
# Load your data
expression_data <- read.csv("expression_matrix.csv", row.names = 1)
metadata <- read.csv("sample_metadata.csv")

# Create heatmap of top variable genes
top_genes <- get_variable_genes(expression_data, n = 500)
plot_heatmap(expression_data[top_genes, ], 
             annotation_col = metadata,
             scale = "row")

# PCA analysis
plot_pca(expression_data, 
         metadata = metadata,
         color_by = "condition",
         title = "PCA - Treatment vs Control")
```

### Genomic Association Study
```r
# Load GWAS results
gwas_data <- read.table("gwas_results.txt", header = TRUE)

# Manhattan plot
plot_manhattan(gwas_data, 
               chr_col = "CHR", 
               pos_col = "BP", 
               pval_col = "P",
               highlight_genes = c("APOE", "BRCA1"))
```

### Comparative Genomics
```r
# Synteny analysis
plot_synteny(genome1_coords, genome2_coords,
             links = synteny_links,
             highlight_regions = important_regions)

# Phylogenetic relationships  
tree_data <- read.tree("species_tree.newick")
plot_phylo_tree(tree_data, 
                tip_labels = species_names,
                node_support = TRUE)
```

## Data Formats

MultiomicViz accepts standard bioinformatics data formats:

- **Expression matrices**: Genes × Samples matrices (data.frame, matrix)
- **Metadata**: Sample annotation tables (data.frame)
- **Genomic coordinates**: BED-like format (chr, start, end)
- **Phylogenetic trees**: Newick format via `ape` package
- **GWAS results**: Standard association test output

## Customization

All plotting functions support extensive customization through:
- Color palettes and themes
- Font sizes and styles  
- Plot dimensions and layouts
- Export formats (PDF, PNG, SVG, EPS)

```r
# Custom color palette
my_colors <- c("#E31A1C", "#1F78B4", "#33A02C")

plot_heatmap(data, 
             color_palette = my_colors,
             font_size = 12,
             width = 8, 
             height = 6)
```

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development Setup
```r
# Clone the repository
git clone https://github.com/yourusername/MultiomicViz.git

# Install development dependencies
devtools::install_dev_deps()

# Run tests
devtools::test()
```

## Citation

If you use MultiomicViz in your research, please cite:

```
Author, A. et al. (2025). MultiomicViz: An R package for comprehensive 
multiomics data visualization. Journal of Computational Biology, XX(X), XXX-XXX.
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📖 **Documentation**: [Package website](https://yourusername.github.io/MultiomicViz/)
- 🐛 **Bug reports**: [GitHub Issues](https://github.com/yourusername/MultiomicViz/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/MultiomicViz/discussions)
- 📧 **Email**: your.email@institution.edu

## Changelog

### Version 0.1.0 (Development)
- Initial package structure
- Core visualization functions
- Basic documentation and examples

---

**MultiomicViz** - Making multiomics visualization simple and beautiful 🎨🧬
