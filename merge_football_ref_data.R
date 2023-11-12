#Load libraries
library(tidyverse)
library(readxl)

# Read in data
d1 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (2).xlsx", skip = 1)
d2 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (3).xlsx", skip = 1)
d3 <- read_xlsx("~/Desktop/NFL_predictions/sportsref_download (4).xlsx", skip = 1)

# Add data frames to list
data_frames <- list(d1, d2, d3)

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
        assign(paste("d", i, sep = ""), data_frames[[i]])
}

# Bind data frames into one data frame
rushing <- do.call(rbind, data_frames)

# Write the combined data frame to a CSV file
write.csv(rushing, "rushing.csv", row.names = TRUE)

