name: "Ulithi_23_PCA"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#------------------------------------------------------------------------------

rm(list=ls())   #clear the environment

#------------------------------------------------------------------------------
#load packages

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

#make the plot


final_df <- cbind(PC_3, pos_norm_md) #combine the PC values with the metadata

stupid_plot_2 <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot 2"); stupid_plot_2

ggsave(plot = stupid_plot_2, filename = "stupid_plot_2.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

#-------------------------------------------------------------------------------
#try a diff way

pos_norm_ft2 <- pos_norm_ft2[, -1]
pos_norm_ft2 <- t(pos_norm_ft2)

PCA <- prcomp(pos_norm_ft2)

hm <- PCA[["x"]]

ggplot(hm, aes(PC1, PC2))  +
    geom_point()

#a better plot

hm2 <- as.data.frame(hm)

final_df <- cbind(hm, pos_norm_md2) #combine the PC values with the metadata

butts_plot <- ggplot(final_df, aes(PC1, PC2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("butts_plot"); butts_plot

ggsave(plot = butts_plot, filename = "butts_plot.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches


#----------------------------
#garbage

pos_norm_ft2 <- t(pos_norm_ft2)
pos_norm_ft2<- as.data.frame(pos_norm_ft2)
colnames(pos_norm_ft2) <- pos_norm_ft2[1,]
pos_norm_ft2 <- pos_norm_ft2[-1, ]
pos_norm_ft2 <- as.numeric(pos_norm_ft2)
is.numeric(pos_norm_ft2)

rownames(pos_norm_ft2) <- pos_norm_ft2[,1 ]

pos_norm_ft2_flipped <- t(pos_norm_ft2)
colnames(pos_norm_ft2_flipped) <- pos_norm_ft2_flipped[1, ]
pos_norm_ft2_flipped <- pos_norm_ft2_flipped[-1, ]


numeric <- pos_norm_ft2_flipped[-1, ]


PCA <- prcomp(numeric, scale=TRUE)
?prcomp

hm <- PCA[["x"]]

hm2 <- hm[, 1:2]

ggplot(hm2, aes(PC1, PC2))  +
    geom_point()







# Only keep rows where 'pts' is less than 10 and 'rebs' is less than 6
new_df <- subset(df, pts < 10 & rebs < 6)

new_hm <- subset(hm2, PC1 < 2 )
?subset


    PC <- as.data.frame(wine_pca$x)
    head(PC)
    
PC <- as.data.frame(PCA$x)
is.data.frame(PC)

head(PC)

#plot that works

ggplot(PC, aes(PC1, PC2))   +
    geom_point()



#plot

final_df <- cbind(PC, pos_norm_md) #combine the PC values with the metadata

stupid_plot_2 <- ggplot(final_df, aes(Comp.1, Comp.2, colour = genus)) +  #pull genus from the metadata
    geom_point()  +
    ggtitle("stupid plot 2"); stupid_plot_2

ggsave(plot = stupid_plot_2, filename = "stupid_plot_2.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches



