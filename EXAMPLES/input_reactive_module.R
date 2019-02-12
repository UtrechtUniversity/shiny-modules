library(shiny)
library(leaflet)
library(RColorBrewer)

# The module containing the observer. Input is the reactive handle of legend input and the proxy
mod <- function(input, output, session, legend, prox){
  
  observe({
    prox %>% clearControls()
    if (legend()) {
      prox %>% addLegend(position = "bottomright",
                         pal = colorNumeric("Blues", quakes$mag), values = ~mag
      )
    }
  })
  
}

ui <- bootstrapPage(
  checkboxInput("legend", "Show legend", TRUE),
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%")
)

server <- function(input, output, session) {
  
  output$map <- renderLeaflet({
    pal <- colorNumeric("Blues", quakes$mag)
    leaflet(quakes) %>% addTiles() %>%      
      addCircles(radius = ~10^mag/10, weight = 1, color = "#777777",
                 fillColor = ~pal(mag), fillOpacity = 0.7, popup = ~paste(mag)) %>% 
      fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
  })
  
  # This is the handle for map
  proxy <- leafletProxy("map", data = quakes)
  callModule(mod, "mod", reactive(input$legend), proxy)
  
  
}

shinyApp(ui, server)