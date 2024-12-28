# R course for beginners
# Week 7 - Raw data
# assignment by Maya Pohes, id 315114744


# Packages and imports ----
library(dplyr)


# Variables ----
folder_path      <- ".//stroop_data"

# Code ----
file_list <- list.files(path = folder_path, pattern = "*.csv", 
                        full.names = TRUE)

df <- data.frame()

for (file in file_list) {
  participant_data <- read.csv(file)  
  df <- rbind(df, participant_data) 
}

df <- df |>
  mutate(
    accuracy   = ifelse(participant_response == correct_response, 1, 0),
    task       = as.factor(ifelse(grepl("ink_naming", condition), 
                                  "ink_naming", "word_reading")),
    congruency = as.factor(ifelse(grepl("incong", condition), 
                                  "congruent", "incongruent")),
    rt = rt / 1000
  ) 

df <- df |>
  select(subject, block, trial, task, congruency, 
         participant_response, correct_response, accuracy, rt)

sapply(df[, c("subject", "task", "congruency", "block")], factor)
sapply(df[, c("trial", "accuracy", "rt")], as.numeric)

save(df, file = file.path('.', "raw_data.rdata"))

