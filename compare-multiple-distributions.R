library(tidyverse)

# load data from gapminder_transform object stored in .rda file
load('rdas/gapminder_transform.rda')

# examine data by region
p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(region, dollars_per_day)) 
p + geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave('figs/data-by-region.png')

# log base 2 scaled distribution after reorder
p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(region, dollars_per_day)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
p + scale_y_continuous(trans = "log2")
ggsave('figs/reordered-scaled-data-by-region.png')