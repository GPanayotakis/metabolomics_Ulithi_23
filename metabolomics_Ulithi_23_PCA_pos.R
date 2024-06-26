name: "metabolomics_Ulithi_23_PCA_pos"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"

#set project directory: session -> set working directory -> To Project Directory

#this R file will establish a PCA for the Ulithi '23 datasets

#github basics (for terminal)
#git add -A means to stage everything to be committed
#git commit -m "message here" means to commit the changes and includes the message
#git push means to push the commit to the main branch
rm(list=ls())   #clear the environment

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(ggfortify)

#prepare the csv files
#read the csv files
posnorm_ft <- read.csv("ulithi_23_PCA_csv/Ulithi23_posnorm_ft_6_24.csv", header = TRUE)
posnorm_md <- read.csv("ulithi_23_PCA_csv/Ulithi23_posnorm_md_6_24.csv", header = TRUE)

#returned as dataframes

#generate the PCA
PCA <- princomp(cor        #make the PCA of the dataset
                (as.matrix     #make it numeric
                    (posnorm_ft[, -1])     #eliminate the metabolite ID column
                )
)

PCA$loadings
PC <- PCA$scores

#make the plot

p <- ggplot(PC, aes(x = Comp.1, y = Comp.2)) +
    geom_point() +    #makes the scatterplot
    ggtitle("Gabby's First PCA"); p   #adds a title


#----------------------------testing space for colors---------------------------
rm(list=ls())   #clear the environment

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(plotly)
library(ggfortify)


#read the csv files
posnorm_ft <- read.csv("ulithi_23_PCA_csv/Ulithi23_posnorm_ft_6_24.csv", header = TRUE)
posnorm_md <- read.csv("ulithi_23_PCA_csv/Ulithi23_posnorm_md_6_24.csv", header = TRUE)


#make the PCA

PCA_colors <- princomp(cor        #make the PCA of the dataset
                (as.matrix     #make it numeric
                    (posnorm_ft[, -1])     #eliminate the metabolite ID column
                )
)

PCA_colors$loadings
PC_colors <- PCA_colors$scores

#make the plot

df_PC_colors <- data.frame(PC_colors)

final_df <- cbind(df_PC_colors, posnorm_md) #combine the PC values with the metadata

ggplot(final_df, aes(Comp.1, Comp.2, colour = genotype)) +
    geom_point()  +
    ggtitle("color pretty please")


