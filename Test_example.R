library(COVID19Viualizations)
library(dplyr)
library(gganimate)
library(ggplot2)

#Load the data
Cases_final <- read.csv("./data/Coronavirus_Cases_USA.csv") %>% filter(Day<49)


#Generate animation
g<- generate_COVID_animation(Input_data=Cases_final,Total_ID="USA_total", 
                             states_selected=c("New York","California",
                                               "Washington"))

#Animate
gganimate::animate(g,nframes = 100,fps=8, width = 1000, height =1000,res=100)
