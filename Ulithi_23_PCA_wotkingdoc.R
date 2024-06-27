name: "Ulithi_23_PCA_workingdoc"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#change the wd to my local computer
setwd("/R projects")
getwd()

#set project directory: session -> set working directory -> To Project Directory

#this R file will establish a PCA for the Ulithi '23 datasets

#github basics (for terminal)
#git add -A means to stage everything to be committed
#git commit -m "message here" means to commit the changes and includes the message
#git push means to push the commit to the main branch

#-------------------basic PCA---------------------------------------------------


#--------------------------------raw data---------------------------------------
name: "Ulithi_23_PCA_pos_norm"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"


rm(list=ls())   #clear the environment

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(ggfortify)


#read the csv files
pos_norm_ft <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_ft_6_24.csv", header = TRUE)
pos_norm_md <- read.csv("ulithi_23_PCA_csv/Ulithi23_pos_norm_md_6_24.csv", header = TRUE)

#generate the PCA
PCA <- princomp(cor        #make the PCA of the dataset
                (as.matrix     #make it numeric
                    (pos_norm_ft[, -1])     #eliminate the metabolite ID column
                )
)

PCA$loadings
PC <- PCA$scores

#make the plot

p <- ggplot(PC, aes(x = Comp.1, y = Comp.2)) +
    geom_point() +    #makes the scatterplot
    ggtitle("Gabby's First PCA"); p   #adds a title


#----------------------------testing space for colors---------------------------
#------------------neg raw & norm PCA--------------------------------------------------


