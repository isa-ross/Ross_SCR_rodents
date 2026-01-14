# Load packages & data
install.packages("tidyverse")
library(tidyverse)

capture <- read_csv("rodent_abundance/scr_clean.csv")

# remove extraneous species
sp_richness <- capture %>% filter(is.na(extraneous))

# create list of unique species
sp_list <- sp_richness %>% distinct(species)

# count unique species
sp_count <- count(sp_list)

# Site Specific
# list of species per site
site_sp_list <- sp_richness %>% 
  group_by(site) %>% 
  distinct(species)

# count species per site
site_sp_count <- site_sp_list %>% 
  group_by(site) %>% 
  summarise(n_species = n())

# Plot site specific richness
ggplot(site_sp_count, aes(x = site, y = n_species, fill = site))+
  geom_col()+
  ylab("Species Richness")+
  theme_bw()

ggsave("outputs/site_sp_richness.png", width=4, height=4)

