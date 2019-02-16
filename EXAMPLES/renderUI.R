if (interactive()) {
  
  ui <- fluidPage(
    uiOutput("moreControls"),
    textOutput("lab")
  )
  
  server <- function(input, output) {
    output$moreControls <- renderUI({
      tagList(
        sliderInput("n", "N", 1, 1000, 500),
        textInput("label", "Label")
      )
    })
  rv <-   reactive(input$label)  
  output$lab <- renderText(rv())
  }
  shinyApp(ui, server)
}