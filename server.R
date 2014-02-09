
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyServer(function(input, output) {
   
  output$tbl <- reactiveUI(function() {
    #cities <- getNearestCities(input$lat, input$long)
    #checkboxGroupInput("cities", "Choose Cities", cities)
    tmp <- subset(shalookup,SHA==input$sha,select=c('Code','Name'))
    tmp1 <- unique(shalookup[,"SHA"==input$sha])
    
    tmp$Code=factor(tmp$Code)
    tmp$Name=factor(tmp$Name)
    tList=tmp$Code
    #tList=tmp$Name
    names(tList)=tmp$Name
    selectInput("tbl", "Select Trust:",tList)
  })
  
  output$distPlot <- renderPlot({
     
    # generate and plot an rnorm distribution with the requested
    # number of observations
    dist <- rnorm(input$obs)
    hist(dist)
    
  })
  
})
