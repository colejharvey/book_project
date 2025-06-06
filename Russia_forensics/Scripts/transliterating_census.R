
# Install required packages if not already installed
if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")
if (!requireNamespace("writexl", quietly = TRUE)) install.packages("writexl")
if (!requireNamespace("stringi", quietly = TRUE)) install.packages("stringi")

# Load libraries
library(readxl)
library(writexl)
library(stringi)
library(tidyverse)


# Main function to process the Excel file
process_excel_file <- function(input_file, output_file) {
  # Get the list of sheet names
  sheet_names <- readxl::excel_sheets(input_file)
  
  # Initialize a list to store all processed sheets
  all_sheets <- list()
  
  # Process each sheet
  for (sheet_name in sheet_names) { {
    cat("Processing sheet:", sheet_name, "\n")
    
    # Transliterate the sheet name
    transliterated_sheet_name <- stri_trans_general(sheet_name, "Cyrillic-Latin")
    cat("  Transliterated sheet name:", transliterated_sheet_name, "\n")
    
    # Read the current sheet
    # Now we'll read with proper column types to preserve numeric data
    df <- readxl::read_excel(input_file, sheet = sheet_name, skip = 5, guess_max = 1000)
    
     # Only transliterate first column
    df <- df %>% rename(ethnicity = '...1')
    df <- df %>% mutate(ethnicity = stri_trans_general(ethnicity, "Cyrillic-Latin"))
      
      
    }
    
    # Add the processed dataframe to our list using the transliterated sheet name
    all_sheets[[transliterated_sheet_name]] <- df
}
  
# Write to a new Excel file
  cat("Writing to output file:", output_file, "\n")
  writexl::write_xlsx(all_sheets, path = output_file)
  
  cat("Processing complete! The transliterated file has been saved as:", output_file, "\n")
}




# Set your file paths
input_file <- "C:\\Users\\colej\\Documents\\Research projects\\book_project\\Russia_forensics\\Data\\regional_ethnicity_copy.xlsx"  # Replace with your input file path
output_file <- "C:\\Users\\colej\\Documents\\Research projects\\book_project\\Russia_forensics\\Data\\transliterated_output.xlsx"  # Replace with your desired output file path

# Run the function
process_excel_file(input_file, output_file)
