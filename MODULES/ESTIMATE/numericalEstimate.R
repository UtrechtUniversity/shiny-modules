numericalEstimateUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tabPanel(
    title = "Stats",
    id = ns("visualHMC"),
    navlistPanel(
      id = ns("HMC_navlist"),
      "NUTS/HMC",
      tabPanel(
        title = "Divergent Transitions",
        id = ns("divergentTransitionsTab")
      ),
      "MCMC",
      tabPanel(
        title = "Trace Plots",
        id = ns("chainTab")
      )
    )
  )
}




numericalEstimate <- function(input, output, session){
  
  
}
