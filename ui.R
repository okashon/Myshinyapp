#Resources

library(shiny)
library(sp)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("COVID-19 in the World"),
  
  
  sidebarLayout(
    sidebarPanel(
       selectInput("Continent","Continent:",c("North America"="North America","Africa"="Africa","South America"="South America","Asia"="Asia","Europe"="Europe","Oceania"="Oceania")),
    submitButton("Done")
    ),
    
    # Show a plot
    mainPanel(
        h2(textOutput("caption")),
       plotOutput("Map"),
       h2("Numbre of cases in the region:"),
       textOutput("sum")
  )
)
))
