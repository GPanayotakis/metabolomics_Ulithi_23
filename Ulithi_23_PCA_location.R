name: "Ulithi_23_PCA_location"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#how to use:
#load the correct csv file
#change PCA plot name
#helpful website: https://statisticsglobe.com/visualization-pca-r
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
ft_df <- read.csv("ulithi_23_PCA_csv/Ulithi23_neg_norm_ft_6_27.csv", header = TRUE)
md_df <- read.csv("ulithi_23_PCA_csv/Ulithi23_neg_norm_md_6_27.csv", header = TRUE)

    #to have the shortened file path, need to set working directory to project directory
    #session -> set working directory -> to project directory

#do the principal component analysis
ft_df <- t(ft_df[, -1])
PCA <- prcomp(ft_df); PCA 
pc.data <- summary(PCA); pc.data
plot(PCA)   #manually save this
x_vals <- as.data.frame(PCA[["x"]])

#combine the PC values with the metadata
df_combo <- cbind(x_vals, md_df) 
    #change plot name after here
neg_norm23 <- ggplot(df_combo, aes(PC2, PC3, colour = genus)) +  #pull genus from df_combo
    geom_point()  +
    ggtitle("neg_norm23"); neg_norm23
    
ggsave(plot = neg_norm23, filename = "neg_norm23.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches

#get rid of outliers

#PC1

#find Q1, Q3, and interquartile range for values in PC1 column
Q1 <- quantile(df_combo$PC1, .25)
Q3 <- quantile(df_combo$PC1, .75)
IQR <- IQR(df_combo$PC1)

#subset data where PC1 value is outside 1.5*IQR of Q1 and Q3
outliers <- subset(df_combo, df_combo$PC1<(Q1 - 1.5*IQR) | df_combo$PC1>(Q3 + 1.5*IQR))

#PC2

#find Q1, Q3, and interquartile range for values in PC1 column
Q1.2 <- quantile(df_combo$PC2, .25)
Q3.2 <- quantile(df_combo$PC2, .75)
IQR.2 <- IQR(df_combo$PC2)

#subset data where PC1 value is outside 1.5*IQR of Q1 and Q3
outliers2 <- subset(df_combo, df_combo$PC2<(Q1 - 1.5*IQR) | df_combo$PC2>(Q3 + 1.5*IQR))

#new plot

df_combo2 <- subset(df_combo, !sample_ID == "A22")
df_combo2 <- subset(df_combo2, !sample_ID == "A26")

pos_norm_loc_no_out <- ggplot(df_combo2, aes(PC1, PC2, colour = location, shape = genus)) +  #pull genus from df_combo
    geom_point()  +
    ggtitle("pos_norm_loc_no_out"); pos_norm_loc_no_out

ggsave(plot = pos_norm_loc_no_out, filename = "pos_norm_loc_no_out.pdf",units = "in",width = 8.5, height = 8.5) #in indicates inches


