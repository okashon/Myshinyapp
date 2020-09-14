#Resources

library(shiny)
library(utils)
library(ggplot2)
library(sf)
library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(dplyr)

#read the Dataset sheet into "R". The dataset will be called "data".

# Define server logic required to draw the map
shinyServer(function(input, output) {
        
        formulaText <- reactive({
                paste("Cases of Covid-19 in", input$Continent)
        })
        output$caption <- renderText({
                formulaText()
        })
   
  output$Map <- renderPlot({
          data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")
          
          world = ne_countries(scale = "medium",returnclass = "sf")
          
          russ = gsub("Russian Federation","Russia",world$name_long)
          usa = gsub("United States","United States of America",russ)
          
          world_2 = mutate(world,name_long=usa)
          
          #cleaning data
          name_long = gsub("_"," ",data$countriesAndTerritories)
          
          virus = mutate(data, name_long= name_long)
          
          virus_clean <- virus %>% select("dateRep","cases","deaths","name_long","day","month")
          
          virus_clean_2 <- virus_clean[virus_clean$month<9&virus_clean$month>7,]
          
          Mapa_virus <- world_2 %>% 
                  left_join(virus_clean_2)
          
         ggplot(data=Mapa_virus%>% filter(continent == input$Continent)) + geom_sf(aes(fill = cases))
          })
          
          output$sum <- renderText({
                sum(Mapa_virus$cases[Mapa_virus$continent==input$Continent],na.rm = TRUE)
        })
})


