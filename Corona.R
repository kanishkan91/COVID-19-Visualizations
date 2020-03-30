#Number of cases from corona virus

library(ggplot2)
library(gganimate)
library (dplyr)
library(tweenr)
library(tidyverse)
library(readxl)
library(tibble)
library(ggstance)
library(gapminder)
library(shiny)
library(gifski)
library(profvis)

Cases <- read.csv("Coronavirus_Cases.csv") %>% filter(Day<49)
Cases$Day <-as.numeric(Cases$Day)
#Cases %>% select(Day,US_cumulative) %>% distinct() %>% mutate(state=paste0("USA_total")) %>% rename(Cumulative_cases=US_cumulative)->USA_Cases

Cases_final<- Cases

theme_set(theme_bw())

g= ggplot(Cases_final %>% filter(state != "USA_total"),aes(Day,Cumulative_cases,group=state,color=state))+
  geom_line()+
  geom_point(size=2)+
  geom_text(data=Cases_final%>% filter(state != "USA_total") %>% filter(Cumulative_cases>100),aes(x= 55,label=state))+
  geom_segment(data=Cases_final%>% filter(state != "USA_total"),aes(xend=55,yend =Cumulative_cases),linetype=2)+
  geom_text(data=Cases_final %>% filter(state== "USA_total"),aes(x=10,y=119000,label=paste0("Total cases in the USA- ",as.character(Cumulative_cases))),size=6)+
  geom_text(data=Cases_final %>% filter(state== "USA_total"),aes(x=10,y=125000,label=paste0("Day of spread- ",as.character(Day))),size=8)+
  geom_text(data=Cases_final %>% filter(state== "New York"),aes(x=10,y=113000,label=paste0("Total cases in New York- ",as.character(Cumulative_cases))),size=6)+
  geom_text(data=Cases_final %>% filter(state== "California"),aes(x=10,y=107000,label=paste0("Total cases in California- ",as.character(Cumulative_cases))),size=6)+
  geom_text(data=Cases_final %>% filter(state== "Washington"),aes(x=10,y=101000,label=paste0("Total cases in Washington State- ",as.character(Cumulative_cases))),size=6)+
  transition_reveal(Day)+
  #transition_states(Day,transition_length = 2,state_length = 1)+
  coord_cartesian(clip = 'off') +
  theme_minimal()+
  theme(legend.position = "none")+
  #xlim(0,45)+
  ylim(0,125000)+
  labs(title='Spread of the novel coronavirus in a 50 day time-line',x='Day of spread (Day1= Feb 1 2020)',y='Number of cumulative cases')

animate(g,nframes = 300,fps=8, width = 1000, height =1000,res=100)



anim2 <- ggplot(airquality, aes(Day, Temp, group = Month)) +
  geom_line() +
  geom_point(aes(group = seq_along(Day))) +
  geom_point(colour = 'red', size = 3) +
  transition_reveal(Day)


