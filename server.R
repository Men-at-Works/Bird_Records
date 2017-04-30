library(shiny)
library(ggmap)
library(mapproj)

fields <- c("lon", "lat")
saveData <- function(my_data) {
  write.table(x = t(my_data),
              file = "data/lonlat.csv",
              append = TRUE,
              sep = ",",
              col.names = FALSE,
              row.names = FALSE
              )
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  formData <- reactive({
    sapply(fields, function(x) input[[x]])
  })
  
  observeEvent(input$submit, {saveData(formData())})
  
  output$geoplot <- renderPlot({
    input$submit
    # Re-execute following lines once the "Submit" button is clicked
    # This is NOT "Execute the following lines only after the "Submit is clicked."
    # Compare with the observeEvent(input$submit, {saveData(formData())}) line above
    lonlat <- read.csv("data/lonlat.csv")
    map <- get_map(location = "Taiwan", zoom = 5,
                   maptype = "satellite")
    ggmap(map) +
      geom_point(aes(x = lon, y = lat), data = lonlat, color = "yellow") +
      theme_void()
  })
   
#   output$distPlot <- renderPlot({
#     # generate bins based on input$bins from ui.R
#     input$submit
#     x    <- faithful[, 2] 
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#   })
})