# Load packages & data

# Install devtools for MuMIn package
# install.packages("devtools")

# Install MuMIn package from GitHub
# devtools::install_github("cran/MuMIn") error message

# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("reshape2")
# install.packages("lme4")
# install.packages("MuMIn")

library(lme4)
library(MuMIn) # install.packages worked, but not from Github
library(ggplot2)
library(GGally)
library(reshape2)
library(tidyverse)

veg_per_trap <- read_csv("veg_per_trap.csv")

# try using rsf package in R

# install.packages("ResourceSelection")
library(ResourceSelection)

# model DM

dm1 <- rspf(DM ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall + 
             scrub_tall + riparian_tall, m = 0, data = veg_per_trap, B=99)
summary(dm1)

dm2<-rspf(DM ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall + 
            scrub_tall, m = 0, data = veg_per_trap, B=99)
summary(dm2)

dm3<-rspf(DM ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall, 
         m = 0, data = veg_per_trap, B=99)
summary(dm3)

dm4<-rspf(DM ~ grass_short + scrub_short + riparian_short + bare + water + trash, 
         m = 0, data = veg_per_trap, B=99)
summary(dm4)

dm5<-rspf(DM ~ grass_short + scrub_short + riparian_short + bare + water, 
          m = 0, data = veg_per_trap, B=99)
summary(dm5)

dm6<-rspf(DM ~ grass_short + scrub_short + riparian_short + bare, 
          m = 0, data = veg_per_trap, B=99)
summary(dm6)

dm7<-rspf(DM ~ grass_short + scrub_short + riparian_short, 
          m = 0, data = veg_per_trap, B=99)
summary(dm7)

dm8<-rspf(DM ~ grass_short + scrub_short, 
          m = 0, data = veg_per_trap, B=99)
summary(dm8)

dm9<-rspf(DM ~ grass_short, 
          m = 0, data = veg_per_trap, B=99)
summary(dm9)

#model selection based on AIC

CAIC(dm1, dm2, dm3, dm4, dm5, dm6, dm7, dm8, dm9) # dm7 lowest
AIC(dm1, dm2, dm3, dm4, dm5, dm6, dm7, dm8, dm9) # dm7 lowest

#average models within 2 deltaAIC of lowest:
dm_sum <- summary(model.avg(dm6, dm7))

# model CP

cp1 <- rspf(CP ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall + 
              scrub_tall + riparian_tall, m = 0, data = veg_per_trap, B=99)
summary(cp1)

cp2<-rspf(CP ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall + 
            scrub_tall, m = 0, data = veg_per_trap, B=99)
summary(cp2)

cp3<-rspf(CP ~ grass_short + scrub_short + riparian_short + bare + water + trash + grass_tall, 
          m = 0, data = veg_per_trap, B=99)
summary(cp3)

cp4<-rspf(CP ~ grass_short + scrub_short + riparian_short + bare + water + trash, 
          m = 0, data = veg_per_trap, B=99)
summary(cp4)

cp5<-rspf(CP ~ grass_short + scrub_short + riparian_short + bare + water, 
          m = 0, data = veg_per_trap, B=99)
summary(cp5)

cp6<-rspf(CP ~ grass_short + scrub_short + riparian_short + bare, 
          m = 0, data = veg_per_trap, B=99)
summary(cp6)

cp7<-rspf(CP ~ grass_short + scrub_short + riparian_short, 
          m = 0, data = veg_per_trap, B=99)
summary(cp7)

cp8<-rspf(CP ~ grass_short + scrub_short, 
          m = 0, data = veg_per_trap, B=99)
summary(cp8)

cp9<-rspf(CP ~ grass_short, 
          m = 0, data = veg_per_trap, B=99)
summary(cp9)

#model selection based on AIC

CAIC(cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8, cp9) # cp3 lowest
AIC(cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8, cp9) # cp7 lowest

#average models within 2 deltaAIC of lowest:
cp_sum <- summary(model.avg(cp3, cp7))
