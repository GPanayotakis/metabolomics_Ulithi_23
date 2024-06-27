name: "Ulithi_23_PCA"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#------------------------------------------------------------------------------

rm(list=ls())   #clear the environment

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(plotly)
library(ggfortify)

#------------------------------------------------------------------------------

#read the csv files
pos_norm_ft2 <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_ft_6_24.csv", header = TRUE)
pos_norm_md2 <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_md_6_24.csv", header = TRUE)

#------------------------------------------------------------------------------
#make the PCA

PCA_2 <- prcomp(as.matrix(t(pos_norm_ft2[, -1])),scale = FALSE, center = FALSE )

loadings2 <- PCA_2$loadings #not working
loadings2
?loadings


PC_2 <- PCA_2$scores #this is the issue, its null

#make the plot

df_PC_2 <- data.frame(PC_2)   #needs to be a dataframe so it can be manipulated

final_df <- cbind(df_PC_2, pos_norm_md) #combine the PC values with the metadata

stupid_plot_2 <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot 2"); stupid_plot_2

ggsave(plot = stupid_plot_2, filename = "stupid_plot_2.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches