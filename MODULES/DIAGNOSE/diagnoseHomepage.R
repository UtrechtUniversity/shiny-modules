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
  if(sso@misc$stan_algorithm != "NUTS" & sso@misc$stan_method == "sampling") callModule(visualMCMC, "MCMC")
  if(sso@misc$stan_method == "variational") callModule(visualVI, "VI")
  
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
    
  if(sso@misc$stan_algorithm != "NUTS" & sso@misc$stan_method == "sampling") {
    output$diagnoseHomepage <- renderUI({
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          visualMCMCUI(session$ns("MCMC"))
        )
      )
    })
  } else {
    if(sso@misc$stan_method == "variational") {
      output$diagnoseHomepage <- renderUI({
        tagList(
          tabsetPanel(
            id = session$ns("diagnose_tabset"),
            visualVIUI(session$ns("VI"))
          )
        )
      })
    } else {
      output$diagnoseHomepage <- renderUI({
        tagList(
          tabsetPanel(
            id = session$ns("diagnose_tabset")
          )
        )
      })
    }
  }
    
  }
}
