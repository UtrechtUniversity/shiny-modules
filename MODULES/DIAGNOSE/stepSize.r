stepSizeUI <- function(id){
  ns <- NS(id)
  
  plotOutput(ns("plot1"))
}


stepSize <- function(input, output, session, chains){
  
  output$plot1 <- renderPlot({
    
    chain <- chains()
    color_scheme_set("blue")
    
      if(chain != 0) {
        mcmc_nuts_stepsize(
        x = nuts_params(list(sso@sampler_params[[chain]]) %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix)),
        lp = data.frame(Iteration = rep(1:(sso@n_iter - sso@n_warmup), 1),
                        Value = c(sso@posterior_sample[(sso@n_warmup + 1):sso@n_iter, chain,"log-posterior"]),
                        Chain = rep(chain, each = (sso@n_iter - sso@n_warmup))) 
        )
      } else {
        mcmc_nuts_stepsize(
        x = nuts_params(sso@sampler_params %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix)),
        lp = data.frame(Iteration = rep(1:(sso@n_iter - sso@n_warmup), sso@n_chain),
                        Value = c(sso@posterior_sample[(sso@n_warmup + 1):sso@n_iter, ,"log-posterior"]),
                        Chain = rep(1:sso@n_chain, each = (sso@n_iter - sso@n_warmup))) 
        )
      }
  })
}