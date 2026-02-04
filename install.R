# install.R
options(repos = c(CRAN = "https://cloud.r-project.org"))

# ---- CRAN packages ----
cran_pkgs <- c(
  "RColorBrewer",
  "dplyr",
  "tidyr",
  "plotly",
  "ggplot2",
  "stringr",
  "httr",
  "jsonlite",
  "ggrepel",
  "cowplot"
)

install.packages(cran_pkgs, dependencies = TRUE)

# ---- Bioconductor packages ----
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Ensure BiocManager doesn't prompt during Binder build
BiocManager::install(
  pkgs = c("DESeq2"),
  ask = FALSE,
  update = FALSE
)

# ---- Quick sanity check (fails the build if something didn't install) ----
pkgs_all <- c(cran_pkgs, "DESeq2")
missing <- pkgs_all[!vapply(pkgs_all, requireNamespace, logical(1), quietly = TRUE)]

if (length(missing) > 0) {
  stop("Failed to install packages: ", paste(missing, collapse = ", "))
}
