# COVID-19-Visualizations

[![Travis build status](https://travis-ci.com/kanishkan91/COVID-19-Visualizations.svg?token=wDMWDC1dxD21p5ecZYyc&branch=master)](https://travis-ci.com/github/kanishkan91/COVID-19-Visualizations)


Some visualizations and visualization applications related to the COVID 19 pandemic
Contributed by

-Kanishk Narayan `kanishkan91`

-Heramb Lonkar  `skad00sh`

## Animations
### 1. USA
<img src="https://github.com/kanishkan91/COVID-19-Visualizations/raw/master/gif-outputs/Corona_USA.gif" width="400" height="400">

### 2. India
<img src="https://github.com/kanishkan91/COVID-19-Visualizations/raw/master/gif-outputs/Corona_India.gif" width="400" height="400">

## Code Example

```R
library(COVID19Viualizations)

g <- generate_COVID_animation(Input_data=Cases_final,Total_ID="USA_total", 
                                     states_selected=c("New York","California",
                                                       "Washington"))

animate(g,nframes = 300,fps=8, width = 1000, height =1000,res=100) 

```
**Structure**
```
root
├── R.proj                                #Main R project 
├── DESCRIPTION                           #All metadata required for project
├── NAMESPACE                             #Documentation functions needed (Generated automatically)  
├── R
    ├──All R scripts and functions
├── gif-outputs                             #GIF Output folder
│   ├── GIF of USA         
│   └── GIF of India               
└── data                                        #Data Folder
    ├── Coronavirus_Cases_USA.csv
    └── india-data
        ├── india_raw_data_{date}.csv
        └── india_wrangled_data_{date}.csv

```
  

*Based on data provided by -*
**a. USA**
1) NY times- https://github.com/nytimes/covid-19-data

**b. India**
1) Covid19India.org- https://www.covid19india.org/

