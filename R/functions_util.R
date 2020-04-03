# Utility Functions

#' Generate_COVID_animation
#'
#' Generate a gif of COVID 19 visualizations.
#'
#' @param Imput_data Dataset with Day, cumulative cases, states
#' @param Total_ID This is the entry which will track the total cases
#' @param states_selected A vector of special states to track cases in    
#' @return An object that can be used within gganimate to generate the gif.
#' @author Kanishka Narayan
#' @export
generate_COVID_animation <- function(Input_data=Cases_final,Total_ID="USA_total", 
                                     states_selected=c("New York","California",
                                                       "Washington")){
    
     max_cases <- max(Cases_final$Cumulative_cases) 
     min_day <- min(Cases_final$Day)
     max_day<- max(Cases_final$Day)
     
    g <-ggplot(Cases_final %>% filter(state != Total_ID),aes(Day,Cumulative_cases,group=state,color=state))+
    geom_line()+
    geom_point(size=2)+
    geom_text(data=Cases_final%>% filter(state != Total_ID) %>% filter(Cumulative_cases>100),aes(x= max_day+5,label=state))+
    geom_segment(data=Cases_final%>% filter(state != Total_ID),aes(xend=max_day+5,yend =Cumulative_cases),linetype=2)+
    geom_text(data=Cases_final %>% filter(state== Total_ID),aes(x=10,y=max_cases*0.95,label=paste0("Total cases in the USA- ",as.character(Cumulative_cases))),size=6)+
    geom_text(data=Cases_final %>% filter(state== Total_ID),aes(x=10,y=max_cases,label=paste0("Day of spread- ",as.character(Day))),size=8)+
    transition_reveal(Day)+
    coord_cartesian(clip = 'off') +
    theme_minimal()+
    theme(legend.position = "none")+
    ylim(0,max_cases)+
    labs(title='Spread of the novel coronavirus in a 50 day time-line',x='Day of spread (Day1= Feb 1 2020)',y='Number of cumulative cases')
    max <- 0.9
    lab_reduction <- 0.05
    
    
    for(i in states_selected){
      data_temp<-Cases_final %>% filter(state== i)
      g<- g +geom_text(data=data_temp,aes_(x=min_day+10,y=max_cases*(max-lab_reduction),label=paste0("Total cases in ",toString(i)," ",as.character(data_temp$Cumulative_cases))),size=6)   
      max<- max - lab_reduction
      }
    
    
     return(g)
}
  
  
  
  
  
 