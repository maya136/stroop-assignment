# R course for beginners
# Week 7 - Additional assignment
# Print plots & run a model
# assignment by Maya Pohes, id 315114744
# 28.12.24


# Packages and imports ----
library(dplyr)
library(ggplot2)
library(lme4)


# Variables ----
folder_path      <- "."
data_file_path <- file.path(folder_path, "filtered_data.rdata")

load(data_file_path)

# Descriptive ----
task_summery <- df |> group_by(task) |> summarise(mean = mean(rt), sd = sd(rt))
print(task_summery)

congruency_summery <- df |> group_by(congruency) |> summarise(mean = mean(rt), sd = sd(rt))
print(congruency_summery)

# Plot task summary
ggplot(task_summery, aes(x = task, y = mean)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) +
  theme_minimal()

# Plot congruency summary
ggplot(congruency_summery, aes(x = congruency, y = mean)) +
  geom_bar(stat = "identity", fill = "lightgreen", color = "black") +
  geom_errorbar(aes(ymin = mean - sd, ymax = mean + sd), width = 0.2) +
  theme_minimal()


# Analysis ----

model <- lmer(rt ~ task * congruency + (1 | subject) , data = df)
summary(model)

