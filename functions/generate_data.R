library(dplyr)
library(stringi)
library(lubridate)

set.seed(420) # agar hasil random selalu sama

# Generate random data
generate_random_data <- function(n) {
  cities <- c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix")
  names <- c("Alice", "Bob", "Charlie", "David", "Eve")
  mottos <- c("Live and Learn", "To be or not to be", 
              "Keep moving foward", "Hakuna Matata", "Carpe Diem",
              "Horay for today", "Just do it")
  married_statuses <- c("yes", "no", NA)
  
  # Fungsi untuk generate typo data
  introduce_typo <- function(x) {
    typo_pos <- sample(1:nchar(x), 1)
    typo_char <- sample(c(letters, LETTERS), 1)
    stri_sub(x, typo_pos, typo_pos) <- typo_char
    return(x)
  }
  
  # Generate data frame
  data_frame(
    city = sample(cities, n, replace = TRUE),
    name = sample(names, n, replace = TRUE),
    age = sample(18:80, n, replace = TRUE),
    phone_number_waddress = paste0(
      stri_rand_strings(n, 3, '[0-9]'), " ",
      stri_rand_strings(n, 3, '[0-9]'), " ",
      stri_rand_strings(n, 4, '[0-9]'), " ",
      stri_rand_strings(n, 10, '[A-Za-z0-9 ]')
    ),
    motto_with_typo = sapply(sample(mottos, n, replace = TRUE), introduce_typo),
    birth_date = as.Date('1970-01-01') + days(sample(0:20000, n, replace = TRUE)),
    married_status = sample(married_statuses, n, replace = TRUE)
  )
}