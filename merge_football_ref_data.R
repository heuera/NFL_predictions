#Load libraries
library(tidyverse)
library(readxl)

# Read in data
p1 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (2).xlsx", skip = 1)
p2 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (3).xlsx", skip = 1)
p3 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (4).xlsx", skip = 1)

# Add data frames to list
data_frames <- list(p1, p2, p3)

# Function to check if first row is NA and remove if true
remove_empty_first_row <- function(df) {
        # Exclude columns that are of type Date or POSIXct/POSIXlt
        non_date_columns <- sapply(df, function(x) !inherits(x, c("Date", "POSIXct", "POSIXlt")))
        
        # Check if the first row in the non-date columns is completely empty (all NA or blank)
        if (all(sapply(df[1, non_date_columns], function(x) is.na(x) || x == ""))) {
                return(df[-1, ])
        } else {
                return(df)
        }
}

# Apply the function to each data frame in the list
data_frames <- lapply(data_frames, remove_empty_first_row)

# Loop through each data frame and assign it to the original data frame
for (i in seq_along(data_frames)) {
        assign(paste("p", i, sep = ""), data_frames[[i]])
}

# Write the combined data frame to a CSV file
write.csv(passing, "passing.csv", row.names = TRUE)

