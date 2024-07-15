# import library
library(dplyr)
library(stringr)

# set working directory
work_dir = '~/github/2-7/my_project'
setwd(work_dir)

# ambil fungsi custom
source("functions/generate_data.R")

# Generate dataframe
df <- generate_random_data(n=50)


# ------------ Mutate
# mengubah nama dan umur
df <- df %>%
  mutate(
    name = toupper(name),
    age = age + 50
  )

# menambah kolom is_new_data
df <- df %>% mutate(is_new_data = 1)

# menambah kolom is_mariage
df <- df %>% mutate(is_married = ifelse(married_status == 'yes', 1, 0))

# ------------ Regex HP
# regex untuk nomor hp
pattern_nonhp = '\\D+'

# manipulasi nomor hp menggunakan str_replace
df$hp_replace <- str_replace(df$phone_number_waddress, pattern_nonhp, '')

# manipulasi nomor hp menggunakan str_replace_all
df$hp_replace_all <- str_replace_all(df$phone_number_waddress, pattern_nonhp, '')


# ------------Regex motto 1
# cari motto Carpe Diem

pattern = '^C'

unique_before = unique(
  (df %>%
     filter(str_detect(motto_with_typo, pattern)))$motto_with_typo
)

df <- df %>% 
  mutate(
    motto_with_typo = 
      if_else(
        str_detect(motto_with_typo, pattern), 
        "Carpe Diem", 
        motto_with_typo
      )
  )

unique_after = unique(
  (df %>%
     filter(str_detect(motto_with_typo, pattern)))$motto_with_typo
)

# ------------Regex motto 2
# cari motto dengan substring 'fo'

pattern = '\\bfo.\\s'

unique_before = unique(
  (df %>%
     filter(str_detect(motto_with_typo, pattern)))$motto_with_typo
)

# manipulasi nomor hp menggunakan str_replace_all
df$motto_with_typo <- str_replace_all(df$motto_with_typo, pattern, 'for ')

unique_after = unique(
  (df %>%
     filter(str_detect(motto_with_typo, pattern)))$motto_with_typo
)

unik_after = unique(df$motto_with_typo)
