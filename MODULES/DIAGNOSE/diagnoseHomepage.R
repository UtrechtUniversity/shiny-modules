diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  tagList(
    uiOutput(ns("diagnoseHomepage"))
  )
  
}

diagnose <- function(input, output, session){
  

  if(sso@misc$stan_algorithm == "NUTS") {
    callModule(visualHMC, "visualHMC")
    callModule(numericalHMC, "numericalHMC")
    }
  if(sso@misc$stan_algorithm != "NUTS" & sso@misc$stan_method == "sampling") callModule(visualMCMC, "visualMCMC")
  if(sso@misc$stan_method == "variational") callModule(visualVI, "visualVI")
  
  if(sso@misc$stan_algorithm == "NUTS") {
    output$diagnoseHomepage <- renderUI({
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          visualHMCUI(session$ns("visualHMC")),
          numericalHMCUI(session$ns("numericalHMC"))
        )
      )
    })
  } else {
    
  if(sso@misc$stan_algorithm != "NUTS" & sso@misc$stan_method == "sampling") {
    output$diagnoseHomepage <- renderUI({
      tagList(
        tabsetPanel(
          id = session$ns("diagnose_tabset"),
          visualMCMCUI(session$ns("visualMCMC"))
        )
      )
    })
  } else {
    if(sso@misc$stan_method == "variational") {
      output$diagnoseHomepage <- renderUI({
        tagList(
          tabsetPanel(
            id = session$ns("diagnose_tabset"),
            visualVIUI(session$ns("visualVI"))
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
