warningsUI <- function (id) {
  ns <- NS(id)
  
  # div(
  #   style = "background-color:lightblue",
  #   align = "center",
  #   textOutput(ns("warningMessage"))
  # )
  fluidRow(
  uiOutput(ns("divergence")),
  uiOutput(ns("treedepth"))
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
  
  
}



# runApp(
#   list(ui = fluidPage(
#     uiOutput("tab")
#   ),
#   server = function(input, output, session){
#     url <- a("Google Homepage", href="https://www.google.com/")
#     output$tab <- renderUI({
#       tagList("URL link:", url)
#     })
#   })
# )
