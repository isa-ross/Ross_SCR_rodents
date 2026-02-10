### Clean SCR Rodent Data
### EKB; January 2026

# Bring in the data cleaning functions from Portal
source("data_cleaning_functions.R")

# File path for Excel file to compare
excel_file <- "data_cleaning/scr_double.xlsx"

# Compare double-entered data
compare_worksheets(excel_file)
  # see commented-out code below if you want to walk through step by step
  # I had to run the function line-by-line to pinpoint the initial error

veg <- "data_cleaning/veg_double.xlsx"

compare_worksheets(veg)

# ## Bring in code from Portal data cleaning functions
# 
# # load data from excel workbook
# ws1 <- openxlsx::read.xlsx(excel_file, sheet = 1, colNames = TRUE, na.strings = c('', 'NA', ' '))
# ws2 <- openxlsx::read.xlsx(excel_file, sheet = 2, colNames = TRUE, na.strings = c('', 'NA', ' '))
# 
# # if the two worksheets are identical, exit function
# if (identical(ws1, ws2)) {                                   
#   print('Worksheets identical')
# 
#   # otherwise, loop through rows one at a time
#   } else {
#     
#   unmatched <- data.frame(row = c(), column = c())         # empty data frame for storing output
#   num_rows <- length(ws1$mo)
#   curr_row <- 1
#   
#   while (curr_row <= num_rows) {
#     
#     v1 <- as.character(as.vector(ws1[curr_row,]))          # extract row from worksheet 1
#     v2 <- as.character(as.vector(ws2[curr_row,]))          # extract row from worksheet 2
#     
#     # if the two versions of the row are not identical
#     if (!identical(v1, v2)) {
#       
#       # loop through each element in the row
#       col_error <- vector()
#       for (n in seq(length(v1))) { 
#         
#         if (!identical(v1[n], v2[n])) {
#           # add the column name to output vector
#           col_error <- append(col_error, colnames(ws1)[n])
#         }
#       }
#       
#       # append row and column info to output data frame (curr_row+1 to skip header in excel file)
#       unmatched <- rbind(unmatched, data.frame(row = curr_row + 1, column = col_error))
#     }
#     curr_row <- curr_row + 1             # increment index and continue loop
#   }
# }
# 
# unmatched
