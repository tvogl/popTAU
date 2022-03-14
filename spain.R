# Load packages
library(tidyverse)
library(HMDHFDplus)
library(viridis)

# Clear environment
rm(list=ls())

# Read in annual, single year of age life tables for Spain
# Need to register your e-mail address on http://mortality.org before running.
lifetables <- readHMDweb(CNTRY = "ESP", item = "bltper_1x1", username = "user@tauex.tau.ac.il", password = "yourpasswordhere", fixup = TRUE)

# Plot death rates against age
lifetables <- mutate(lifetables, deathrate = mx*100000, Year = factor(Year))
ggplot(subset(lifetables,Year==2019|Year==2020), aes(x=Age, y=deathrate, group=Year, color=Year)) +
  geom_line() +
  ggtitle("Age-specific mortality rates in Spain") +
  scale_y_continuous(trans = 'log10', labels = scales::comma) +
  ylab("Death rate per 100,000") 

# Plot survival function against age
ggplot(subset(lifetables,Year==2019|Year==2020), aes(x=Age, y=lx, group=Year, color=Year)) +
  geom_line() +
  ggtitle("Survival curves in Spain") +
  scale_y_continuous(labels = scales::comma) +
  ylab("Survivors per 100,000") 

# Plot life expectancy against age
ggplot(subset(lifetables,Year==2019|Year==2020), aes(x=Age, y=ex, group=Year, color=Year)) +
  geom_line() +
  ggtitle("Life expectancy by age in Spain") +
  scale_y_continuous(labels = scales::comma) +
  ylab("Remaining years of life") 

# Plot e_0 by year
lifetables <- mutate(lifetables, Year = as.numeric(as.character(Year)))
lifetables %>% filter(Age == 0) %>% select(Year, ex)
ggplot(subset(lifetables, Age==0), aes(x=Year, y=ex)) +
  geom_line() +
  ggtitle("Life expectancy at birth in Spain") +
  scale_y_continuous(labels = scales::comma) +
  ylab("Life expectancy") 