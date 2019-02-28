numericalHMCUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
    tabPanel(
      title = "Stats",
      id = ns("numericalHMC"),
      navlistPanel(
        id = ns("HMC_navlist"),
        "Numerical",
        tabPanel(
          title = "Get me some numbers",
          id = ns("numericalTab")
        ) 
      )
    )
}




numericalHMC <- function(input, output, session){
  
  
}
