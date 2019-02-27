parallelCoordinatesUI <- function(id){
  ns <- NS(id)
  
  plotOutput(ns("plot1"))
}


parallelCoordinates <- function(input, output, session, chains){
  
  output$plot1 <- renderPlot({
    
    chain <- chains()
    color_scheme_set("darkgray")
    
      if(chain != 0) {
        mcmc_parcoord(
        x = sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, chain, ],
        np = nuts_params(list(sso@sampler_params[[chain]]) %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix))
        )
      } else {
        mcmc_parcoord(
        x = sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ],
        np = nuts_params(sso@sampler_params %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix))
        )
      }
  })
}