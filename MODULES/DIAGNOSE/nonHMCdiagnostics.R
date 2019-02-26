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
      ),
      tabPanel(
        title = withMathJax("\\(\\hat{R}, \\text{ } n_{eff}, \\text{ se}_{mean}\\)"),
        id = ns("rhat_n_eff_se_mean"),
        rhat_n_eff_se_meanUI(ns("rhat_n_eff_se_mean"))
      ),
      tabPanel(
        title = "Autocorrelation",
        id = ns("autocorrelationTab")
      )
    )
  )
  
}




nonHMCdiagnostics <- function(input, output, session){

  callModule(chainPlot, "chainPlot")  
  callModule(rhat_n_eff_se_mean, "rhat_n_eff_se_mean")
}
