plotAreaUI <- function(id){
  ns <- NS(id) # required namespacefunction
  
  fluidRow(
    selectInput(ns("selectVariable"), "selectVariable", choices = names(fit$coefficients)),
    column(6, plotOutput(ns("plot1")))
    # plot output with the name 'id-plot1' as namespace due to ns()
  )
}

plotArea <- function(input, output, session){
  posterior <- as.matrix(fit)
  
  output$plot1 <- renderPlot({
    mcmc_areas(posterior, pars = input$selectVariable)
  })
  
}