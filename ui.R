
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("NHS - Prescription Analysis in England"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
   
    #
    selectInput("sha", "Select Strategic Health Autority (SHA):",aList),
    uiOutput("tbl"),
##    checkboxInput("pctdownonly", "Only download this Trust's data", FALSE),

    div("This demo provides a crude graphical view over data extracted from",
        a(href='http://transparency.dh.gov.uk/2012/10/26/winter-pressures-daily-situation-reports-2012-13/',
          "NHS Winter pressures daily situation reports") ),
    div("The data is pulled in from ",
        a(href="https://scraperwiki.com","NHS Sit Reps")),
    div(em("Commentary on the data:"),"'Monday morning.'")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tabsetPanel(
      tabPanel("SHA Stacked Barchart", plotOutput("whatPlot")),
      tabPanel("SHA Linechart", plotOutput("shaLineChart")),
      tabPanel("SHA BoxPlot", plotOutput("shaBoxPlot"))
    ),
    tabsetPanel(
      tabPanel("PCT Barchart",plotOutput("testPlot")),
      tabPanel("PCT Linechart",plotOutput("pctLineChart")),
      tabPanel("PCT Daily Boxplot",plotOutput("dayPlot")),
      tabPanel("PCT Datatable",tableOutput("view"))
    )

  )
))
