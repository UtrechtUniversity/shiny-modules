diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  tagList(
    tabsetPanel(
      id = ns("diagnose_tabset"),
      nonHMCdiagnosticsUI(ns("non-HMC")),
      if(sso@misc$stan_method == "sampling") HMCdiagnosticsUI(ns("HMC"))
    )
  )
 
}

diagnose <- function(input, output, session){
  
  callModule(nonHMCdiagnostics, "non-HMC")
  if(sso@misc$stan_method == "sampling") callModule(HMCdiagnostics, "HMC")
  
}
