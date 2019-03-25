# add tidyr and dplyr with library(tidyr) and library(dplyr)
# add original file

library(readxl)
refine_original <- read_excel("~/Desktop/Springboard Intro to Data Science/refine_original.xlsx")
View(refine_original)                                                                                                                 

# set original dataset to new dataframe for clean set

refine_clean <- refine_original

# select/order company column

refine_clean <- refine_clean[order(refine_clean$company), ]
View(refine_clean)

# clean data with correct company name spellings

refine_clean$company[1:7] <- "akzo"
refine_clean$company[8:16] <- "philips"
refine_clean$company[17:20] <- "unilever"
refine_clean$company[21:25] <- "van houten"

View(refine_clean)

#separate 'Product code / number' column into new columns

refine_clean <- refine_clean %>% separate(`Product code / number`, c("product_code", "product_number"))

# duplicate product code column to use to set product categories

refine_clean$product_category = refine_clean$product_code

# set product categories according to Tablet, Smartphone, TV, Laptop

refine_clean$product_category <- sub("q", "Tablet", refine_clean$product_category)
refine_clean$product_category <- sub("p", "Smartphone", refine_clean$product_category)
refine_clean$product_category <- sub("v", "TV", refine_clean$product_category)
refine_clean$product_category <- sub("x", "Laptop", refine_clean$product_category)


# clean address data by uniting into one column

refine_clean <- unite(refine_clean, full_address, 4:6, sep = ",", remove = TRUE)

# create binary company columns

refine_clean$company_philips <- as.numeric(refine_clean$company == "philips")
refine_clean$company_akzo <- as.numeric(refine_clean$company == "akzo")
refine_clean$company_van_houten <- as.numeric(refine_clean$company == "van houten")
refine_clean$company_unilever <- as.numeric(refine_clean$company == "unilever")


# create binary product columns

refine_clean$product_smartphone <- as.numeric(refine_clean$product_category == "Smartphone")
refine_clean$product_tv <- as.numeric(refine_clean$product_category == "TV")
refine_clean$product_laptop <- as.numeric(refine_clean$product_category == "Laptop")
refine_clean$product_tablet <- as.numeric(refine_clean$product_category == "Tablet")



