#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age", 50),
      selectInput("race",
                "Race:",
                c("Black/African American" = 1, "European/Caucasian" = 2, "Hispanic/Lation" = 3, "Asian" = 4, "Native American" = 5, "Other" = 6)),
      sliderInput("imp_race",
                  "Importance that person you date is the same race:",
                  min = 1,
                  max = 10,
                  value = 1),
      sliderInput("imp_relig",
                  "Importance that person you date is the same religion:",
                  min = 1,
                  max = 10,
                  value = 1)
    ),
    mainPanel(
       #plotOutput("distPlot")
    )
  )
))
