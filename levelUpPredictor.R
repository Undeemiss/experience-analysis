# Prepare the data
data <- read.table("data/5e.csv", header = TRUE, sep = ",")
args <- commandArgs(trailingOnly = TRUE)

# Initialize variables
base_exp <- 2700
daily_exp <- 400
current_exp <- as.integer(args[[1]])
earned_exp <- current_exp - 2700
target_level <- as.integer(args[[2]])
target_exp <- data$exp[target_level]
earnings_target <- target_exp - 2700
stopifnot(earnings_target > 0)

# Calculate portion of earnings target
target_portion <- earned_exp / earnings_target

# Calculate days to target level
days_to_target <- ceiling((target_exp - current_exp) / daily_exp)

print(paste("You are ", target_portion, "x of the way to level ", target_level, ".", sep = ""))
print(paste("It will be ", days_to_target, " days until you reach the exp threshold.", sep = ""))
