nonHMCdiagnosticsUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tabPanel(
    title = "non-HMC specific",
    id = ns("non-HMC"),
    navlistPanel(
      id = ns("non-HMC_navlist"),
      tabPanel(
        title = "Trace Plots",
        id = ns("chainTab"),
        chainPlotUI(ns("chainPlot"))
      )
    )
  )
  
}




nonHMCdiagnostics <- function(input, output, session){

  callModule(chainPlot, "chainPlot")  
}
