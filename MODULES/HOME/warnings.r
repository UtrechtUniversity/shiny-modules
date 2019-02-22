warningsUI <- function (id) {
  ns <- NS(id)
  
  fluidRow(
  uiOutput(ns("divergence")),
  uiOutput(ns("treedepth")),
  uiOutput(ns("energy"))
  )
  
}

warnings <- function (input, output, session) {
  
  output$warningMessageDivergence <- renderText({
    
    checkDivergences <- lapply(sso@sampler_params, "[", , "divergent__") %>%
      lapply(., as.data.frame) %>%
      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
      lapply(., function (x) x > 0 ) %>% lapply(., sum) %>% 
      unlist(.) %>% sum(.) %>%
      paste0(., " of ", (sso@n_iter-sso@n_warmup) * sso@n_chain,
             " iterations ended with a divergence (",
             round((. / ((sso@n_iter-sso@n_warmup) * sso@n_chain)) * 100, 1),
             "%).")
    
    checkDivergences
    
  })
  
  output$divergence <- renderUI({
    ns <- session$ns
    
    # linkDiagnoseDivergent <- a("Find out more.", 
    # href = 'diagnoseHomepage-divergentTransitions')
    
    if(lapply(sso@sampler_params, "[", , "divergent__") %>%
       lapply(., as.data.frame) %>%
       lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
       lapply(., function (x) x > 0 ) %>% lapply(., sum) %>% 
       unlist(.) %>% sum(.) > 0) {
      div(
        style = "background-color:red",
        align = "center",
        textOutput(ns("warningMessageDivergence"))
        # tagList(linkDiagnoseDivergent),
        # actionLink("diagnoseHomepage-divergentTransitions", "test")
      ) 
    } else {
      div(
        style = "background-color:lightblue",
        align = "center",
        textOutput(ns("warningMessageDivergence"))
      )
    }
  })
  
  
  output$warningMessageTreedepth <- renderText({
    
    check_treedepth <- lapply(sso@sampler_params, "[", , "treedepth__") %>%
      lapply(., as.data.frame) %>%
      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
      lapply(., function (x) x == sso@misc$max_td ) %>% lapply(., sum) %>% 
      unlist(.) %>% sum(.) %>%
      paste0(., " of ", (sso@n_iter-sso@n_warmup) * sso@n_chain,
             " iterations saturated the maximum tree depth of ", 
             sso@misc$max_td, " (",
             round((. / ((sso@n_iter-sso@n_warmup) * sso@n_chain)) * 100, 1),
             "%).")
    
      check_treedepth
  })
  
  output$treedepth <- renderUI({
    ns <- session$ns
    
    if(lapply(sso@sampler_params, "[", , "treedepth__") %>%
       lapply(., as.data.frame) %>%
       lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
       lapply(., function (x) x == sso@misc$max_td ) %>% 
       lapply(., sum) %>% unlist(.) %>% sum(.) > 0) {
      div(
        style = "background-color:red",
        align = "center",
        textOutput(ns("warningMessageTreedepth"))
      ) 
    } else {
      div(
        style = "background-color:lightblue",
        align = "center",
        textOutput(ns("warningMessageTreedepth"))
      )
    }
  })
  
  
  
  check_energy_sso <- function(shinystan.object){
    
    energy <- lapply(sso@sampler_params, "[", , "energy__") %>%
      lapply(., as.data.frame) %>% 
      lapply(., filter, row_number() == (1 + sso@n_warmup):sso@n_iter) 
    
    EBFMIs <- c()
    
    for(chain in 1:sso@n_chain) {
      EBFMIs[chain] <- apply(energy[[chain]], 2, function(x){
        numer <- sum(diff(x)^2)/length(x)
        denom <- var(x)
        return(numer/denom)
      })
    }
    
    bad_chains <- which(EBFMIs < 0.2)
    if (!length(bad_chains)) {
      paste0("E-BFMI indicated no pathological behavior.")
    }
    else {
      EBFMIsWarnings <- NULL
      for(bad in bad_chains){
        EBFMIsWarnings <- c(EBFMIsWarnings, 
                            paste0("Chain ", bad, ": E-BFMI = ", EBFMIs[bad], ".\n"))
      }
      cat(paste0("E-BFMI indicated possible pathological behavior:\n", 
                 paste(EBFMIsWarnings, collapse = "") ,
                 "E-BFMI below 0.2 indicates you may need to reparameterize your model."), 
          sep = "\n")
    }
    
  }
  
  
  output$warningMessageEnergy <- renderText({
    
    check_energy_sso(sso)
    
  })

  
  output$energy <- renderUI({
    ns <- session$ns
    
    if(check_energy_sso(sso) != "E-BFMI indicated no pathological behavior.") {
      div(
        style = "background-color:red",
        align = "center",
        textOutput(ns("warningMessageEnergy"))
      ) 
    } else {
      div(
        style = "background-color:lightblue",
        align = "center",
        textOutput(ns("warningMessageEnergy"))
      )
    }
  })
  
  
  
}


