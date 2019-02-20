divergentTransitionsUI <- function(id){
  ns <- NS(id)
 

  plotOutput(ns("plot1"))
   
}


divergentTransitions <- function(input, output, session, pars){

  output$plot1 <- renderPlot({
    color_scheme_set("darkgray")
    mcmc_scatter(
      sso@posterior_sample,
      # note the use of pars(), a reactive value is passed to this module
      # so use the reactive nature here.
      pars = c(pars(), "log-posterior"),
      np = nuts_params(sso@sampler_params), 
      np_style = scatter_style_np(div_color = "green", div_alpha = 0.8)
    )
    
  })
  
}
