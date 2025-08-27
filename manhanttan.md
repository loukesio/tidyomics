Here's a comprehensive README section for your `plot_manhattan` function:

```markdown
## plot_manhattan

A flexible and efficient function for creating publication-ready Manhattan plots from GWAS results. Features intelligent subsampling of non-significant SNPs for faster rendering with large datasets.

### Installation

```r
# Required packages
library(ggplot2)
library(dplyr)
```

### Usage

```r
plot_manhattan(
  gwas_data,
  chr_col = "chrom",
  pos_col = "pos",
  pval_col = "pval",
  title = "Manhattan Plot",
  chr_spacing = 20,
  sig_threshold = 0.05,
  light_version = TRUE,
  nonsig_fraction = 0.1,
  colors = c("#0E7175", "#FD7901")
)
```

### Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `gwas_data` | - | Data frame containing GWAS results |
| `chr_col` | `"chrom"` | Name of the chromosome column |
| `pos_col` | `"pos"` | Name of the base pair position column |
| `pval_col` | `"pval"` | Name of the p-value column |
| `title` | `"Manhattan Plot"` | Plot title |
| `chr_spacing` | `20` | Spacing (in BP units) between chromosomes on the plot |
| `sig_threshold` | `0.05` | P-value threshold for determining significant SNPs |
| `light_version` | `TRUE` | Enable intelligent subsampling of non-significant SNPs |
| `nonsig_fraction` | `0.1` | Fraction of non-significant SNPs to keep (0-1) |
| `colors` | `c("#0E7175", "#FD7901")` | Colors for alternating chromosomes |

### Features

#### 🚀 Performance Optimization
The `light_version` parameter enables intelligent subsampling that:
- **Preserves ALL significant SNPs** (p < `sig_threshold`)
- **Randomly samples non-significant SNPs** to reduce plot density
- **Dramatically speeds up rendering** for datasets with millions of SNPs
- **Maintains visual integrity** of the Manhattan plot

#### 🎨 Customization
- Flexible column naming to work with any GWAS output format
- Customizable chromosome colors
- Adjustable chromosome spacing for better visualization
- Clean, publication-ready theme with minimal gridlines

### Examples

#### Basic Usage
```r
# Load your GWAS results
gwas_results <- read.csv("gwas_output.csv")

# Create a standard Manhattan plot
plot_manhattan(gwas_results)
```

#### Full Dataset (No Subsampling)
```r
# Plot all SNPs - useful for smaller datasets or when full detail is needed
plot_manhattan(
  gwas_results,
  light_version = False,
  title = "Complete GWAS Results"
)
```

#### Aggressive Subsampling for Large Datasets
```r
# Keep only 1% of non-significant SNPs for very large datasets
plot_manhattan(
  gwas_results,
  light_version = TRUE,
  nonsig_fraction = 0.01,
  title = "GWAS Summary (1% non-significant SNPs)"
)
```

#### Custom Column Names
```r
# Work with different GWAS output formats
plot_manhattan(
  gwas_results,
  chr_col = "CHR",
  pos_col = "BP", 
  pval_col = "P",
  title = "PLINK Output Manhattan Plot"
)
```

#### Custom Colors and Spacing
```r
# Customize appearance
plot_manhattan(
  gwas_results,
  colors = c("darkblue", "lightblue"),
  chr_spacing = 50,  # Increase spacing between chromosomes
  title = "Custom Manhattan Plot"
)
```

### Performance Guidelines

| Dataset Size | Recommended `nonsig_fraction` | Rendering Time* |
|-------------|-------------------------------|-----------------|
| < 100K SNPs | 1.0 (no subsampling) | < 1 sec |
| 100K - 1M SNPs | 0.1 - 0.5 | 1-5 sec |
| 1M - 10M SNPs | 0.01 - 0.1 | 5-15 sec |
| > 10M SNPs | 0.001 - 0.01 | 10-30 sec |

*Approximate times on standard hardware

### Tips

1. **Start with default settings** - The defaults work well for most GWAS datasets
2. **Use `light_version = TRUE`** for initial exploration of large datasets
3. **Set `light_version = FALSE`** for final publication figures if you need complete data
4. **Adjust `nonsig_fraction`** based on your dataset size and computational resources
5. **The function preserves ALL significant findings** regardless of subsampling settings

### Input Data Format

Your input data frame should have at minimum three columns:
```r
# Example structure
gwas_data <- data.frame(
  chrom = c(1, 1, 2, 2, 3),           # Chromosome number
  pos = c(1000, 2000, 1500, 3000, 2500), # Base pair position
  pval = c(0.001, 0.5, 1e-8, 0.3, 0.05)  # P-values
)
```

### Output

Returns a `ggplot2` object that can be:
- Displayed directly
- Saved using `ggsave()`
- Further customized with additional `ggplot2` layers

```r
# Save the plot
p <- plot_manhattan(gwas_results)
ggsave("manhattan_plot.png", p, width = 12, height = 6, dpi = 300)

# Add custom annotations
p + annotate("text", x = 1000000, y = 10, label = "Gene of Interest")
```
```

This README section provides comprehensive documentation with practical examples, performance guidelines, and clear explanations of the subsampling feature that makes your function particularly useful for large GWAS datasets.
