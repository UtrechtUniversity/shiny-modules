plotAreaUI <- function(id){
  ns <- NS(id)
  
  fluidRow(
    column(6, plotOutput(ns("plot1")))
  )
}

plotArea <- function(input, output, session){
  posterior <- as.matrix(fit)
  
  output$plot1 <- renderPlot({
    mcmc_areas(posterior)
  })
  
}