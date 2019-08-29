library(tidyverse)
library(dslabs)
data(gapminder)

# print gapminder data as tibble
gapminder %>% as_tibble()

# save gapminder data to .csv file
write.csv(gapminder, 'data/gapminder.csv')

# save gapminder object to rdas/gapminder.rda
save(gapminder, file = 'rdas/gapminder.rda')