# R course for beginners
# Week 7 - Filtered data
# assignment by Maya Pohes, id 315114744


# Packages and imports ----
library(dplyr)


# Variables ----
folder_path      <- "."
data_file_path <- file.path(folder_path, "raw_data.rdata")
     
# Code ----
load(data_file_path)

gap_df <- data.frame(subject = unique(df$subject))

gap_df$before_filter_trial_count <- df |>
  group_by(subject) |>
  summarise(before_filter_trial_count = n()) |>
  select(2)
            
# Filtering 
participants_count <- length(unique(df))
df <- na.omit(df)
df <- df |> filter(rt <= 3 & rt >= 0.3)


gap_df$after_filter_trial_count <- df |>
  group_by(subject) |>
  summarise(after_filter_trial_count = n()) |>
  select(2)

gap_df$dropped_count <- gap_df$before_filter_trial_count - 
                                   gap_df$after_filter_trial_count
gap_df$dropped_percentage <- sapply( ((gap_df$dropped_count / 
                                         gap_df$before_filter_trial_count) * 
                                        100), as.numeric)

# Descriptive 
summery <- gap_df |> summarise(mean = mean(dropped_percentage), 
                               sd = sd(dropped_percentage))
print(summery)

save(df, file = file.path('.', "filtered_data.rdata"))

