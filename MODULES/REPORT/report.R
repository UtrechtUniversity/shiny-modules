reportUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(div(
      img(
        src = "wide_ensemble.png",
        class = "wide-ensemble",
        width = "100%"
      )
    ),
    div(
      style = "margin-top: 25px",
      img(src = "stan_logo.png", class = "stan-logo"),
      div(id = "shinystan-title", "ShinyStan")
    )),
    fluidRow(
      align="center",
      br(), br(),
      wellPanel(id = "selectVariableTab", 
                    radioButtons(ns("divergentScatter"), "Include Divergent Scatter Plot",
                                 choices = c(TRUE, FALSE), selected = FALSE),
                    radioButtons(ns("pairs"), "Include Pairs Plot",
                                 choices = c(TRUE, FALSE), selected = FALSE)  
      ),
      br(), br(),
      downloadButton(ns('downloadPlot'), 'Download Plots'),
      downloadButton(ns('downloadRDS'), 'Download RDS'))
  )
  
}

report <- function(input, output, session, ggplotsList) {
  
  
  output$downloadPlot <- downloadHandler(
    filename = 'test.pdf',
    content = function(file) {
      pdf(file)
      if(input$divergentScatter == TRUE) print(ggplotsList()["divergentScatterPlot"])
      if(input$pairs == TRUE) print(ggplotsList()["pairsPlot"])
      # print(ggplotsList())
      dev.off()
    })  
  
  output$downloadRDS <- downloadHandler(
    filename = 'test.rds',
    content = function(file) {
      saveRDS(ggplotsList(), file)
    })  
  
  
  
}