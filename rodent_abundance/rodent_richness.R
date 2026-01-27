# Load packages & data
# install.packages("tidyverse")
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


#### Richness by site and season
richness_by_site_season <- sp_richness %>% 
  group_by(yr, season, site) %>% 
  mutate(yr = as.integer(yr)) %>% 
  distinct(species) %>% 
  count() 

# try to switch seasons to chronological (spring -> fall)
richness_by_site_season$season <- as_factor(richness_by_site_season$season)

ggplot(richness_by_site_season, aes(x = site, y = n)) +
  geom_col() +
  facet_grid(yr ~ season)

## abundance by site & season
sp_abund <- sp_richness %>% filter(is.na(recap)) #remove recaps
sp_abund$period <- paste(sp_abund$season, sp_abund$yr, sep = " ")
abund_by_site_period <- sp_abund %>% group_by(period, site, species) %>% distinct(species) 


abund_by_site_period <- abund_by_site_period %>% mutate(total = sum(abund_by_site_period$n_species))

ggplot(abund_by_site_period, aes(x=period, y=n_species))+
  geom_col(aes(fill = ))