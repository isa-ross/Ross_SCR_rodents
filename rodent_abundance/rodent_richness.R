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

# Calculate species richness by site & date
# create one date column
sp_by_date <- sp_richness %>%
  mutate(date = make_date(yr, mo, dy), .before = season)

# list of species per date, include site
date_sp_list <- sp_by_date %>% 
  group_by(date) %>% 
  distinct(species, .keep_all = T) %>% 
  select(date, species, site)

# separate DRX site
drx_sp_date <- date_sp_list %>% filter(site == "DRX")

# count species per day
drx_date_count <- drx_sp_date %>% 
  group_by(date) %>% 
  summarise(n_species = n())

# plot richness per day
ggplot(drx_date_count, aes(x = date, y = n_species, fill = date))+
  geom_point()+
  ylab("Species Richness at DRX")+
  theme_bw()

# stratify by year
yr_sp_list <- sp_richness %>% 
  group_by(yr) %>% 
  distinct(species, .keep_all = T) # distinct species negates species new to site but already found in other site?

# separate DRX site
drx_sp_yr <- yr_sp_list %>% filter(site == "DRX")

# count species per year
drx_yr_count <- drx_sp_yr %>% 
  group_by(yr) %>% 
  summarise(drx_species = n())

# STR site
str_sp_yr <- yr_sp_list %>% filter(site == "STR")
str_yr_count <- str_sp_yr %>% 
  group_by(yr) %>% 
  summarise(str_species = n())

# SUN site
sun_sp_yr <- yr_sp_list %>% filter(site == "SUN")
sun_yr_count <- sun_sp_yr %>% 
  group_by(yr) %>% 
  summarise(sun_species = n())

# join site data tables
drx_str_join <- full_join(drx_yr_count, str_yr_count)
site_yr_count <- full_join(drx_str_join, sun_yr_count)

# graph richness by year by site
ggplot(site_yr_count, aes(x = ))

site_yr_count_long <- site_yr_count %>% pivot_longer(cols = ends_with("species"))

ggplot(site_yr_count_long, aes(x = name, y = value, fill = yr, group = yr))+
  geom_bar(stat = "identity", position = 'dodge')                               
