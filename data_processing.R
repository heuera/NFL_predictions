# Load libraries
library(tidyverse)
library(dplyr)

# Read in data sets
passing <- read.csv("~/Desktop/NFL_predictions/passing.csv")
rushing <- read.csv("~/Desktop/NFL_predictions/rushing.csv")
opp_passing <- read.csv("~/Desktop/NFL_predictions/opp_passing.csv")
opp_rushing <- read.csv("~/Desktop/NFL_predictions/opp_rushing.csv")
odds <- read.csv("~/Desktop/NFL_predictions/odds.csv")
weather <- read.csv("~/Desktop/NFL_predictions/weather.csv")
post_bye_week <- read.csv("~/Desktop/NFL_predictions/followed_bye.csv")

# Clean up data frames

# passing
        # rename columns
        passing <- passing %>% 
                rename(Attempts = Att...4, 
                       Games = G., 
                       Home_Away = ...8, 
                       Yds = Yds...15)
        
        # replace @ in Home_Away with "home" or "away"
        passing <- passing %>% 
                mutate(Home_Away = if_else(Home_Away == "@", "away", "home"))

        passing$Home_Away[is.na(passing$Home_Away)] <- "home"
        
        # Drop unused columns
        passing <- passing %>% 
                select(-X, -Rk, -Att...12, -Cmp., -TD., -Int., -Yds...22, -Sk.)
     
# rushing
        # rename columns
        rushing <-rushing %>% 
                rename(Attempts = Att...4, 
                       Games = G., 
                       Home_Away = ...8)
        
        # replace @ in Home_Away with "home" or "away"
        rushing <-rushing %>% 
                mutate(Home_Away = if_else(Home_Away == "@", "away", "home"))
        
        rushing$Home_Away[is.na(rushing$Home_Away)] <- "home"
        
        # Drop unused columns
        rushing <- rushing %>% 
                select(-Att...11)
        
        
        
        
        
        
        
        
        
# Merge passing and rushing
#merged_1 <- inner_join(passing, rushing, 
#                      by = c("Team", "Date", "Day", "Week", "Opp", "Result", 
#                            .suffix = c("_pass", "_rush")))





# Read in passing csv
pass <- read.csv("~/Desktop/NFL_predictions/passing.csv")

# Group by the specified column and calculate the cumulative average
pass <- pass %>%
        arrange(Week) %>% 
        group_by(Team) %>%
        mutate(ypg = cumsum(pass$Week)/row_number())



summary(pass$Week)
summary(pass$Yds...15)