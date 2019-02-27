diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  tagList(
    uiOutput(ns("diagnoseHomepage"))
  )
  
}

diagnose <- function(input, output, session){
  

  if(sso@misc$stan_algorithm == "NUTS") callModule(visualHMC, "HMC")
  if(sso@misc$stan_algorithm != "NUTS") callModule(MCMCUI, "MCMC")
  
  
  if(sso@misc$stan_algorithm == "NUTS") {
    output$diagnoseHomepage <- renderUI({
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          visualHMCUI(session$ns("HMC"))
        )
      )
    })
  } else {
    output$diagnoseHomepage <- renderUI({
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          visualMCMCUI(session$ns("MCMC"))
        )
      )
    })
  }
  
}
