plotScatterUI <- function(id, stanFit){
  ns <- NS(id) # required namespacefunction
  
  fluidRow(
    column(6, 
           selectInput(ns("selectVariable"), "Select X Variable", choices = names(fit$coefficients)),
           selectInput(ns("selectVariable2"), "Select Y Variable", choices = names(fit$coefficients)),
           plotOutput(ns("plot1")))
    # plot output with the name 'id-plot1' as namespace due to ns()
  )
}

plotScatter <- function(input, output, session, stanFit, eval){
  
  output$plot1 <- renderPlot({
    if(eval()){
      color_scheme_set("darkgray")
      mcmc_scatter(
        as.matrix(fit),
        pars = c(input$selectVariable, input$selectVariable2), 
        np = nuts_params(fit), 
        np_style = scatter_style_np(div_color = "green", div_alpha = 0.8)
      )
    }
  })
  
}