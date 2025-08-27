library(ggplot2)
library(dplyr)

plot_manhattan <- function(
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
) {
  # Compute -log10(p)
  gwas_data <- gwas_data %>%
    mutate(logp = -log10(.data[[pval_col]]))

  # Optionally subsample non-significant points
  if (light_version) {
    gwas_data <- gwas_data %>%
      mutate(sig = .data[[pval_col]] < sig_threshold) %>%
      group_by(sig) %>%
      sample_frac(ifelse(unique(sig), 1, nonsig_fraction)) %>%
      ungroup()
  }

  # Compute cumulative chromosome offsets
  cumulative_df <- gwas_data %>%
    group_by(.data[[chr_col]]) %>%
    summarize(chr_len = max(.data[[pos_col]], na.rm = TRUE), .groups = "drop") %>%
    mutate(cum_offset = cumsum(lag(chr_len + chr_spacing, default = 0)))

  # Add cumulative positions
  gwas_data <- gwas_data %>%
    left_join(cumulative_df %>% rename(!!chr_col := .data[[chr_col]]), by = chr_col) %>%
    mutate(pos_cum = .data[[pos_col]] + cum_offset)

  # Compute center of each chromosome for axis breaks
  axis_df <- gwas_data %>%
    group_by(.data[[chr_col]]) %>%
    summarize(center = mean(pos_cum), .groups = "drop")

  # Build color palette
  chrom_levels <- unique(gwas_data[[chr_col]])
  color_palette <- rep(colors, length.out = length(chrom_levels))
  names(color_palette) <- chrom_levels

  # Plot
  p <- ggplot(gwas_data, aes(x = pos_cum, y = logp, color = factor(.data[[chr_col]]))) +
    geom_point(alpha = 0.6, size = 2) +
    scale_color_manual(values = color_palette) +
    scale_x_continuous(
      name = "Chromosome",
      breaks = axis_df$center,
      labels = axis_df[[chr_col]],
      expand = expansion(mult = c(0.01, 0.01))
    ) +
    scale_y_continuous(
      name = expression(-log[10](p)),
      expand = c(0, 0)
    ) +
    labs(
      title = title,
      x = "Chromosome",
      y = expression(-log[10](p))
    ) +
    theme_bw() +
    theme(
      text = element_text(size = 15, family = "Helvetica"),
      plot.title = element_text(hjust = 0.5),
      legend.position = "none",
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.border = element_rect(linewidth = 0.75),
      panel.grid.minor.y = element_line(color = "grey85", linewidth = .3, linetype = "dashed"),
      panel.grid.major.y = element_line(color = "grey85", linewidth = .3, linetype = "dashed"),
      axis.ticks.length = unit(0.25, "cm"),
      axis.ticks = element_line(size = 0.5)
    )

  return(p)
}
