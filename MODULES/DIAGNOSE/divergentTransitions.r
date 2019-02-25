divergentTransitionsUI <- function(id){
  ns <- NS(id)
 

  plotOutput(ns("plot1"))
   
}


divergentTransitions <- function(input, output, session, pars, chains){

  
  output$plot1 <- renderPlot({
    
    chain <- chains()
    color_scheme_set("darkgray")
    mcmc_scatter(
      if(chain != 0) {
        sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, chain, ]
        } else {
          sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ]
        },
      # note the use of pars(), a reactive value is passed to this module
      # so use the reactive nature here.
      pars = c(pars(), "log-posterior"),
      np = if(chain != 0) {
        nuts_params(list(sso@sampler_params[[chain]]) %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix))
      } else {
        nuts_params(sso@sampler_params %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix)) 
          
      },
      np_style = scatter_style_np(div_color = "green", div_alpha = 0.8)
    )
    
  })
  
  
  
  
}
# (1 + sso@n_warmup) : sso@n_iter)