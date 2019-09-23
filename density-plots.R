library(tidyverse)

# load data from gapminder_group object stored in .rda file
load('rdas/gapminder_group.rda')

# overlay densities
p <- gapminder %>% 
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(group = ifelse(group == "West", "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300))
p + geom_density(alpha = 0.2, bw = 0.75) + facet_grid(year ~ .)
ggsave('figs/overlay-densities.png')

# see what groups are driving the differences using stacked ridge plots
gapminder %>% 
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population)*2) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group, weight= weight)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300)) + 
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)
ggsave('figs/stacked-ridged-plots-by-weight.png')
