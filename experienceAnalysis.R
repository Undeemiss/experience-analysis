library(ggplot2)
library(scales)

options(device = "x11")

# Prepare the data
data <- read.table("data.csv", header = TRUE, sep = ",")
data$delta <- diff(c(0, data$exp))

# Fit models against the data
model_exp <- lm(exp ~ level + I(level^2), data = data)


# Plot exp against level linearly
plot_exp <- ggplot(data, aes(x = level)) +
  geom_line() + # Line plot
  geom_point(aes(y = exp)) + # Add points
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Experience Points by Level",
    x = "Level",
    y = "Experience Points"
  )

# Save the plot
ggsave("plot_exp.png",
  plot = plot_exp, width = 15, height = 5, dpi = 300
)


# Plot delta against level linearly
plot_delta <- ggplot(data, aes(x = as.numeric(row.names(data)), y = delta)) +
  geom_line() + # Line plot
  geom_point() + # Add points
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Experience Point Delta by Level",
    x = "Level",
    y = "Delta"
  )

# Save the plot
ggsave("plot_delta.png",
  plot = plot_delta, width = 15, height = 5, dpi = 300
)

print(data)
