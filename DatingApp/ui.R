#Michael Vander Lugt

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("BIG DEAL Consulting Data Explorer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("range", "Age Range:",
                  min = 18, max = 55, value = c(18,30)),
      selectInput("race",
                "Race:",
                c("Black/African American" = 1, "European/Caucasian" = 2, "Hispanic/Latina" = 3, "Asian" = 4, "Other" = 6))
    ),
    mainPanel(
      plotlyOutput("plot"),
      br(),br(),br(),br(),
      plotlyOutput("plot2")
    )
  )
))
