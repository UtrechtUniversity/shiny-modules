plotAreaUI <- function(id, stanFit){
  ns <- NS(id) # required namespacefunction
  
  fluidRow(
    column(6, 
           selectInput(ns("selectVariable"), "selectVariable", choices = names(fit$coefficients)),
           plotOutput(ns("plot1")))
    # plot output with the name 'id-plot1' as namespace due to ns()
  )
}

plotArea <- function(input, output, session, stanFit){
  posterior <- as.matrix(fit)
  
  output$plot1 <- renderPlot({
    mcmc_areas(posterior, pars = input$selectVariable)
  })
  
}