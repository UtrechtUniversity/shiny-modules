plotChainsUI <- function(id, stanFit){
  ns <- NS(id) # required namespacefunction
  
  fluidRow(
    column(6, 
           selectInput(ns("selectVariable"), "selectVariable", choices = names(fit$coefficients)),
           plotOutput(ns("plot1")))
    # plot output with the name 'id-plot1' as namespace due to ns()
  )
}

plotChains <- function(input, output, session, stanFit, eval){
  
  
  output$plot1 <- renderPlot({
    if(eval()){
      # only evaluate if eval input is TRUE, eval is a reactive value
      # determined by a checkbox input in the main app. 
      stan_trace(stanFit, pars = input$selectVariable)
    }
  })
  
}