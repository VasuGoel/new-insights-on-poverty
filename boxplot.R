library(tidyverse)

# load data from gapminder_transform object stored in .rda file
load('rdas/gapminder_transform.rda')

# define following 5 groups
gapminder <- gapminder %>% 
  mutate(group = case_when(
    region %in% c("Western Europe", "Northern Europe","Southern Europe", 
                  "Northern America", "Australia and New Zealand") ~ "West",
    region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
    continent == "Africa" & region != "Northern Africa" ~ "Sub-Saharan Africa",
    TRUE ~ "Others"))

# turn group variable into factor
gapminder <- gapminder %>% 
  mutate(group = factor(group, 
                        levels = c("Others", "Latin America", "East Asia", "Sub-Saharan Africa", "West")))

# save gapminder object to rdas/gapminder_group.rda
save(gapminder, file = 'rdas/gapminder_group.rda')

# stack boxplots against each other with alpha = 0.5
p <- gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(group, dollars_per_day)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_y_continuous(trans = "log2") +
  xlab("")
p + geom_point(alpha = 0.5)
ggsave('figs/boxplot.png')
