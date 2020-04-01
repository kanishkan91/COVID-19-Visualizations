# Working Directory of Heramb aka skad00sh
setwd("C:/Users/Heramb/Desktop/projects/COVID-19-Visualizations/")


library(tidyverse)
library(ggplot2)
library(gganimate)


raw_data <- read.csv("https://raw.githubusercontent.com/covid19india/CovidCrowd/master/data/raw_data.csv")

write.csv(raw_data, paste0(
  paste0("./data/india_data/india_raw_data_", Sys.Date()), ".csv"), 
  row.names = F)

#View(raw_data)

##### Initial wangling of a data #####
req_data <- raw_data %>%
  select(
    Patient.Number,
    Date.Announced,
    Age.Bracket,
    Detected.City,
    Detected.State,
    Current.Status
  )
req_data$Date.Announced = as.Date(req_data$Date.Announced, format = "%d/%m/%Y")
req_data$Day = round(difftime(req_data$Date.Announced, "2020-01-30", units = "days"), 0)

test_grand <- req_data %>%
  group_by(Day, Detected.State)%>%
  add_tally(name = "Daily.Count") %>%
  distinct(Day, Detected.State, Daily.Count) %>%
  group_by(Detected.State) %>%
  mutate(Cumm = cumsum(Daily.Count))

# ind_cumsum <- req_data %>%
#   group_by(Day, Date.Announced) %>%
#   tally(name = "India.Daily") %>%
#   arrange(Day) %>%
#   mutate(India.cumm = cumsum("India.Daily"))

wrang_data <- left_join(req_data, test_grand, by=c("Day", "Detected.State"))

india_wrangled_data <- wrang_data %>%
  distinct(Detected.State, Date.Announced, Day, Daily.Count, Cumm) %>%
  drop_na()

write.csv(india_wrangled_data, paste0(
  paste0("./data/india_data/india_wrangled_data_", Sys.Date()), ".csv"), 
  row.names = F)


theme_set(theme_bw())
g = ggplot(india_wrangled_data,aes(x = Day,y = Cumm,group=Detected.State,color=Detected.State))+
  geom_line()+
  geom_point(size=2)+
  transition_reveal(Day)+
  #transition_states(Day,transition_length = 2,state_length = 1)+
  coord_cartesian(clip = 'off') +
  theme_minimal()+
  theme(legend.position = "none")+
  #xlim(0,45)+
  ylim(0,max(india_wrangled_data$Cumm))

animate(g,nframes = 100,fps=10, width = 1000, height =1000,res=100)
anim_save("./gif-outputs/Corona_India.gif")






