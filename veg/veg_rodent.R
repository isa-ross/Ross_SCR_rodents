# each row is a trap, col for each species/veg type - 2 data sets
#

library(tidyverse)
library(vegan)
library(goeveg)
library(mclogit)
library(corrplot)

capture <- read_csv("rodent_abundance/scr_clean.csv")
veg <- read_csv("veg/veg_clean.csv")

trap_by_species <- capture %>% filter(yr == 2025, season == "Fall") %>% 
  select(site, trap, species) %>% 
  group_by(site, trap, species) %>% 
  count() %>% 
  mutate(n = if_else(n>0, 1, 0)) %>% 
  pivot_wider(names_from = species, values_from = n, values_fill = 0) %>% 
  drop_na(trap)

# NMDS

nmds <- metaMDS(trap_by_species[,3:8], distance = "bray", k = 2, weakties = FALSE)

nmds$stress

stressplot(nmds)

plot(nmds, type = "t")

# run in order
plot(nmds, display = "sites")
plot(env_fit, p.max = 0.05)

nmds_scores <- as.data.frame(scores(nmds, display = "sites"))
nmds_scores$site <- veg_per_trap$site

ggplot(nmds_scores, aes(x=NMDS1, y=NMDS2, color=site))+
  geom_jitter()

env_fit <- envfit(nmds, veg_per_trap[, 9:17], permutations = 999)
env_fit

cor(veg_per_trap[,9:17])

# new dataframe
# only includes traps with positive captures, does not consider veg structure of empty traps

veg <- veg %>% select(site:riparian_tall)

veg_per_capture <- capture %>% filter(yr == 2025, season == "Fall") %>% 
  select(site, trap, species) %>% 
  inner_join(veg) %>% 
  distinct() %>% 
  mutate(species = as_factor(species))

# create data frame for rsf

per_trap <- inner_join(veg_per_capture, trap_by_species, by = c("site","trap"))

veg_per_trap <- left_join(trap_by_species, veg, by = c("site", "trap"))

# attempted models

cor(veg_per_capture[4:12])

mblogit(species ~ grass_short + scrub_short + bare + site, random = ~1 | trap, data = veg_per_capture)

