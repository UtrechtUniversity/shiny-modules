diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  # tagList(
  #   tabsetPanel(
  #     id = ns("diagnose_tabset"),
  #     nonHMCdiagnosticsUI(ns("non-HMC")),
  #     if(sso@misc$stan_method == "sampling") HMCdiagnosticsUI(ns("HMC"))
  #   )
  # )
  uiOutput(ns("diagnoseHomepage"))
  
}

diagnose <- function(input, output, session){
  
  callModule(nonHMCdiagnostics, "non-HMC")
  callModule(HMCdiagnostics, "HMC")
  
  
  if(sso@misc$stan_method == "sampling") {
    output$diagnoseHomepage <- renderUI({
      
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          HMCdiagnosticsUI(session$ns("HMC")),
          nonHMCdiagnosticsUI(session$ns("non-HMC"))
        )
      )
    })
  } else {
    output$diagnoseHomepage <- renderUI({
      
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          nonHMCdiagnosticsUI(session$ns("non-HMC"))
        )
      )
    })
  }
  
}
