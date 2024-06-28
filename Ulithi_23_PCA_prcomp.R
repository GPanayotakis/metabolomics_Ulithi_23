name: "Ulithi_23_PCA_prcomp"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#how to use:
#load the correct csv file
#change PCA plot name
#-------------------------------------------------------------------------------

#clear the environment

rm(list=ls()) 

#load the libraries

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(plotly)
library(ggfortify)

#load your CSV files

ft_df <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_raw_ft_6_24.csv", header = TRUE)
md_df <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_raw_md_6_24.csv", header = TRUE)

    #to have the shortened file path, need to set working directory to project directory
    #session -> set working directory -> to project directory


#do the principal component analysis

ft_df <- ft_df[, -1]
ft_df <- t(ft_df)

PCA <- prcomp(log(ft_df)); PCA 
pc.data <- summary(PCA); pc.data
plot(PCA)
x_vals <- PCA[["x"]]

<<<<<<< HEAD
ggplot(x_vals, aes(PC1, PC2))  +
=======
final_df <- cbind(df_PC_2, pos_norm_md) #combine the PC values with the metadata

stupid_plot_2 <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot 2"); stupid_plot_2

ggsave(plot = stupid_plot_2, filename = "stupid_plot_2.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

#make the plot


final_df <- cbind(PC_3, pos_norm_md) #combine the PC values with the metadata

stupid_plot_2 <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot 2"); stupid_plot_2

ggsave(plot = stupid_plot_2, filename = "stupid_plot_2.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

#-------------------------------------------------------------------------------
#try a diff way = BUTTS PLOT

pos_norm_ft2 <- pos_norm_ft2[, -1]
pos_norm_ft2 <- t(pos_norm_ft2)

PCA <- prcomp(pos_norm_ft2)

hm <- PCA[["x"]]

ggplot(hm, aes(PC1, PC2))  +
>>>>>>> f8790aad1df69066c46325a21c81452c3cc52b73
    geom_point()

#make the PCA plot

x_vals <- as.data.frame(x_vals)

df_combo <- cbind(x_vals, md_df) #combine the PC values with the metadata

    #change plot name after here

pos_raw_log <- ggplot(df_combo, aes(PC1, PC2, colour = genus)) +  #pull genus from df_combo
    geom_point()  +
    ggtitle("pos_raw_log"); pos_raw_log

ggsave(plot = pos_raw_log, filename = "pos_raw_log.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

#add scaling
