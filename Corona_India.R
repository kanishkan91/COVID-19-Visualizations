library(tidyverse)
library(ggplot2)
library(gganimate)

raw_data <-
  read.csv(
    "https://raw.githubusercontent.com/imdevskp/covid-19-india-data/master/patients_data.csv"
  )

write.csv(raw_data, paste0(
  paste0("./data/india_data/india_raw_data_", Sys.Date()), ".csv"), 
  row.names = F)

#View(raw_data)

##### Initial wangling of a data #####
req_data <- raw_data %>%
  select(patient_number, date_announced, detected_state) %>%
  arrange(patient_number)

req_data$date_announced = as.Date(req_data$date_announced, format = "%d/%m/%Y")
req_data$Day = round(difftime(req_data$date_announced, req_data$date_announced[1], units = "days"), 0)

test_grand <- req_data %>%
  group_by(Day, detected_state)%>%
  add_tally(name = "Daily.Count") %>%
  distinct(Day, detected_state, Daily.Count) %>%
  group_by(detected_state) %>%
  mutate(Cumm = cumsum(Daily.Count))

total_country_count <- req_data %>%
  group_by(Day, )%>%
  tally(name = "Daily.Count") %>%
  mutate(Cumm = cumsum(Daily.Count)) 

country_name_column = data.frame(detected_state = c(rep("India_total", nrow(total_country_count))))

total_country_count <- bind_cols(total_country_count, country_name_column)

total_country_count <- total_country_count %>%
  select(detected_state, Day, Daily.Count, Cumm)%>%
  group_by(detected_state)
total_country_count$detected_state = as.character(total_country_count$detected_state)

india_wrangled_data <- test_grand %>%
  select(detected_state, Day, Daily.Count, Cumm) 
india_wrangled_data$detected_state = as.character(india_wrangled_data$detected_state)

india_wrangled_data_final = full_join(india_wrangled_data, total_country_count)

Date_df = req_data %>%
  select(date_announced, Day) %>%
  distinct(date_announced, Day)

india_wrangled_data_final = left_join(india_wrangled_data_final, Date_df)
india_wrangled_data_final <- india_wrangled_data_final %>%  
  drop_na() %>%
  arrange(detected_state)

india_wrangled_data_final = india_wrangled_data_final %>%
  rename(
    state = detected_state,
    date = date_announced,
    Cases = Daily.Count,
    Cumulative_cases = Cumm
  )

write.csv(india_wrangled_data_final, paste0(
  paste0("./data/india_data/india_wrangled_data_", Sys.Date()), ".csv"), 
  row.names = F)








