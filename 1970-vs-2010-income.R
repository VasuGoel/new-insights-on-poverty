library(tidyverse)

# load data from gapminder_group object stored in .rda file
load('rdas/gapminder_group.rda')

# faceted histograms for 'west vs rest'
past_year <- 1970
present_year <- 2010
gapminder %>% 
  filter(year %in% c(past_year, present_year) & !is.na(gdp)) %>%
  mutate(west = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") + 
  facet_grid(year ~ west)
ggsave('figs/faceted-histograms-west-vs-rest.png')

# redraw above plot using only countries with data available for both years  
country_list_1 <- gapminder %>% 
  filter(year == past_year & !is.na(dollars_per_day)) %>% 
  pull(country)

country_list_2 <- gapminder %>% 
  filter(year == present_year & !is.na(dollars_per_day)) %>% 
  pull(country)

country_list <- intersect(country_list_1, country_list_2)

gapminder %>% 
  filter(year %in% c(past_year, present_year) & !is.na(gdp) & country %in% country_list) %>%
  mutate(west = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") + 
  facet_grid(year ~ west)
ggsave('figs/faceted-histograms-west-vs-rest-refined.png')

# specific regions that improved the most
gapminder %>% 
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(year = factor(year)) %>%
  ggplot(aes(group, dollars_per_day, fill = year)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") +
  xlab("") 
ggsave('figs/compare-specific-regions-1970-vs-2010.png')