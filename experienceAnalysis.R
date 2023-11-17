library(ggplot2)
library(scales)

options(device = "x11")

# Prepare the data
data <- read.table("data/5e.csv", header = TRUE, sep = ",")
data$delta <- diff(c(0, data$exp))
data$log_level <- log(data$level)
data$log_exp <- log(data$exp)
data$log_delta <- log(data$delta)

# Fit models against the data
model_exp_quadratic <- lm(exp ~ level + I(level^2) + 0, data = data)
print(summary(model_exp_quadratic))

model_exp_exponential <- lm(log_exp ~ log_level, data = data)
print(summary(model_exp_exponential))

# Plot exp against level linearly
plot_exp <- ggplot(data, aes(x = level)) +
  geom_point(aes(y = exp)) + # Add exact datapoints
  geom_line(aes(y = predict(model_exp_quadratic, data))) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Experience Points by Level",
    x = "Level",
    y = "Experience Points"
  )

# Save the plot
ggsave("output/plot_exp.png",
  plot = plot_exp, width = 15, height = 5, dpi = 300
)

print(data)
