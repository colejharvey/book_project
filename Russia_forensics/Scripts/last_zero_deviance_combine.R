# Set the directory path where your CSV files are located
directory_path <- here("Russia_forensics", "Data", "Last-digit-zero deviance scores") #Replace with your actual path

# List all CSV files in the directory
csv_files <- list.files(path = directory_path, 
                        pattern = "\\.csv$",  # Only files ending with .csv
                        full.names = TRUE)    # Get full file paths

# Check if any CSV files were found
if (length(csv_files) == 0) {
  stop("No CSV files found in the specified directory.")
}

# Initialize an empty data frame to store the combined data
combined_data <- data.frame()

# Loop through each CSV file, read it, and bind it to the combined data frame
for (i in 1:length(csv_files)) {
  # Read the current CSV file
  current_data <- read.csv(csv_files[i], stringsAsFactors = FALSE)
  
 
  # Bind the current data to the combined data frame
  if (nrow(combined_data) == 0) {
    combined_data <- current_data
  } else {
    combined_data <- rbind(combined_data, current_data)
  }
  
  # Print progress (optional)
  cat("Processed:", basename(csv_files[i]), "\n")
}

# Print summary information
cat("\nCombined", length(csv_files), "CSV files.\n")
cat("Total rows in combined data:", nrow(combined_data), "\n")
cat("Columns in combined data:", paste(colnames(combined_data), collapse = ", "), "\n")

# If you want to save the combined data to a new CSV file
 write.csv(combined_data, here::here("Russia_forensics", "Data", "combined_zero_digit_deviance.csv"), row.names = FALSE)

