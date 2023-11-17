library(ggplot2)
library(scales)

options(device = "x11")

# Prepare the data
data <- read.table("data/5e.csv", header = TRUE, sep = ",")
data$delta <- diff(c(0, data$exp))

# Fit models against the data
model_exp <- lm(exp ~ level + I(level^2) + 0, data = data)
print(summary(model_exp))
model_delta <- lm(delta ~ level + I(level^2) + 0, data = data)
print(summary(model_delta))


# Plot exp against level linearly
plot_exp <- ggplot(data, aes(x = level)) +
  geom_point(aes(y = exp)) + # Add exact datapoints
  geom_line(aes(y = predict(model_exp, data), color = "red")) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Experience Points by Level",
    x = "Level",
    y = "Experience Points"
  ) +
  guides(color = "none")

# Save the plot
ggsave("output/plot_exp.png",
  plot = plot_exp, width = 15, height = 5, dpi = 300
)


# Plot exp against level linearly
plot_delta <- ggplot(data, aes(x = level)) +
  geom_point(aes(y = delta)) + # Add exact datapoints
  geom_line(aes(y = predict(model_delta, data), color = "red")) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Experience Point Delta by Level",
    x = "Delta",
    y = "Experience Points"
  ) +
  guides(color = "none")

# Save the plot
ggsave("output/plot_delta.png",
  plot = plot_delta, width = 15, height = 5, dpi = 300
)


print(data)
