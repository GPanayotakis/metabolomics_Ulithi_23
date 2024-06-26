name: "metabolomics_Ulithi_23_PCA_pos"
project: "metabolomics_Ulithi_23_PCA"
repository: "metabolomics_Ulithi_23"


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
posnorm_ft <- read.csv("ulithi_23_csv_files/Ulithi23_posnorm_ft_6_24.csv", header = TRUE)
posnorm_md <- read.csv("ulithi_23_csv_files/Ulithi23_posnorm_md_6_24.csv", header = TRUE)

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


#-------------------------------------------------------------------------------

library(dplyr)
library(ggplot2)
library(tidyverse, quietly = TRUE) #tidyverse-v1.3.1
library(plotly)
library(ggfortify)



posnorm_ft <- read.csv("/Users/gabri/OneDrive/Desktop/metabolomics/metabolomics/ulithi_23_csv_files/Ulithi23_posnorm_ft_6_24.csv", header = TRUE)
posnorm_md <- read.csv("/Users/gabri/OneDrive/Desktop/metabolomics/metabolomics/ulithi_23_csv_files/Ulithi23_posnorm_md_6_24.csv", header = TRUE)

#for iris
iris
df <- iris[1:4]
pca_res <- prcomp(df, scale. = TRUE)

p <- autoplot(pca_res, data = iris, colour = 'Species')

ggplotly(p)

#for my data

posnorm_combo <- read.csv("/Users/gabri/OneDrive/Desktop/metabolomics/metabolomics/ulithi_23_csv_files/Ulithi23_posnorm_ft_6_24_copy.csv", header = TRUE)


df2 <- posnorm_combo[-c(1:6),-1 ] #remove the non numeric rows
df3<- as.matrix(df2)
is.numeric(df3)
pca_res2 <-df2pca_res2 <- prcomp(df2, scale. = TRUE)

p2 <- autoplot(pca_res2, data = , colour = 'genotype')

ggplotly(p2)










#making the color by genotype

#prepare the csv files
#read the csv files
posnorm_combo <- read.csv("/Users/gabri/OneDrive/Desktop/metabolomics/metabolomics/ulithi_23_csv_files/Ulithi23_posnorm_ft_6_24_copy.csv", header = TRUE)





#generate the PCA
PCA2 <- princomp(cor        #make the PCA of the dataset
                 (as.matrix     #make it numeric
                     (posnorm_ft[-6, -1])     #eliminate the metabolite ID column
                 )
)

PCA2$loadings
PC2 <- PCA2$scores

#make the plot

p2 <- ggplot(PC2, aes(x = Comp.1, y = Comp.2)) +
    geom_point() +    #makes the scatterplot
    ggtitle("Gabby's Second PCA"); p2   #adds a title

p3<- autoplot(p2, data = posnorm_combo, colour = 'genotype', label = TRUE, label.size = 3)


posnorm_ft_num <- posnorm_ft[, -1]
posnorm_md_t <- t(posnorm_md)

combined_df <- merge(posnorm_ft_num, posnorm_md_t, by = 'sample_full_name')
combined_df <- rbind(posnorm_ft_num, posnorm_md_t)

?merge


p <- ggplot(PC, aes(x = Comp.1, y = Comp.2)) +
    geom_point(aes(color=)) +    #makes the scatterplot
    ggtitle("Gabby's Second PCA"); p   #adds a title

posnorm_md["genotype"]
