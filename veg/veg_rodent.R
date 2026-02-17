# each row is a trap, col for each species/veg type - 2 data sets
#

library(tidyverse)
library(vegan)
library(goeveg)
library(mclogit)
library(corrplot)

capture <- read_csv("rodent_abundance/scr_clean.csv")
veg <- read_csv("data_cleaning/veg/veg_clean.csv")

trap_by_species <- capture %>% filter(yr == 2025, season == "Fall") %>% 
  select(site, trap, species) %>% 
  group_by(site, trap, species) %>% 
  count() %>% 
  mutate(n = if_else(n>0, 1, 0)) %>% 
  pivot_wider(names_from = species, values_from = n, values_fill = 0)

# nmds <- metaMDS(trap_by_species[,3:8], distance = "bray", k = 2)\
# "Warning: stress is (nearly) zero: you may have insufficient data"

#screeplot_NMDS(nmds)

# new dataframe

# only includes traps with positive captures, does not consider veg structure of empty traps

veg <- veg %>% select(site:riparian_tall)

veg_per_capture <- capture %>% filter(yr == 2025, season == "Fall") %>% 
  select(site, trap, species) %>% 
  inner_join(veg) %>% 
  distinct() %>% 
  mutate(species = as_factor(species))

cor(veg_per_capture[4:12])

mblogit(species ~ grass_short + site, random = ~1 | trap, data = veg_per_capture)

