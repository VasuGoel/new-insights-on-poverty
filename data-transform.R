library(tidyverse)
load('rdas/gapminder.rda')

# Add new column with dollars_per_day
gapminder <- gapminder %>%  mutate(dollars_per_day = gdp/population/365)

# save gapminder object to rdas/gapminder_transform.rda
save(gapminder, file = 'rdas/gapminder_transform.rda')

# log transformation
past_year <- 1970
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "black")
ggsave('figs/log-transform.png')

# distribution of log2(dollars_per_day)
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) + 
  geom_histogram(binwidth = 1, color = "black")
ggsave('figs/log-base-2.png')

# distribution after scaling axis with logs
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2")
ggsave('figs/log-base-2-scale-axis.png')
