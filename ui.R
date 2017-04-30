library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("You Add Positions I Draw Them"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("lon", "Longitude:", value = 121, min = -180, max = 180, step = 0.1),
      numericInput("lat", "Latitude:", value = 23.5, min = -90, max = 90, step = 0.1),
      actionButton("submit", "Submit")
    ),
    mainPanel(
      plotOutput("geoplot")
    )
  )
))