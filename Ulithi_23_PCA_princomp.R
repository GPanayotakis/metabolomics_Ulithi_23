name: "metabolomics_Ulithi_23_PCA_pos"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#-------------------------------------------------------------------------------

#set project directory: session -> set working directory -> To Project Directory
#this R file will establish a PCA for the Ulithi '23 datasets

#github basics (for terminal)
#git add -A means to stage everything to be committed
#git commit -m "message here" means to commit the changes and includes the message
#git push means to push the commit to the main branch

#-------------------basic PCA---------------------------------------------------

rm(list=ls())   #clear the environment

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(plotly)
library(ggfortify)

#------------------------------------------------------------------------------

#read the csv files
pos_norm_ft <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_ft_6_24.csv", header = TRUE)
pos_norm_md <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_md_6_24.csv", header = TRUE)

#------------------------------------------------------------------------------
#generate the PCA

PCA <- princomp(cor(as.matrix(pos_norm_ft[, -1])))

loadings <- PCA$loadings
loadings
PC <- PCA$scores

#make the plot

p <- ggplot(PC, aes(x = Comp.1, y = Comp.2)) +
    geom_point() +    #makes the scatterplot
    ggtitle("Gabby's First PCA"); p   #adds a title

#add colors to the plot

df_PC_colors <- data.frame(PC)   #needs to be a dataframe so it can be manipulated

final_df <- cbind(df_PC_colors, pos_norm_md) #combine the PC values with the metadata

stupid_plot <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot"); stupid_plot

ggsave(plot = stupid_plot, filename = "stupid_plot.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

