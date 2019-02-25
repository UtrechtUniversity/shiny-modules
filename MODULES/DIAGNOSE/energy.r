energyUI <- function(id){
  ns <- NS(id)
  
  plotOutput(ns("plot1"))
}


energy <- function(input, output, session, pars, chains){
  
  output$plot1 <- renderPlot({
    
    chain <- chains()
    color_scheme_set("blue")
    mcmc_nuts_energy(
      if(chain != 0) {
        nuts_params(list(sso@sampler_params[[chain]]) %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix))
      } else {
        nuts_params(sso@sampler_params %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix)) 
        
      }
    )
  })
}