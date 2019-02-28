visualMCMCUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tabPanel(
    title = "Visual",
    id = ns("visualHMC"),
    navlistPanel(
      id = ns("MCMC_navlist"),
      "MCMC",
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
        id = ns("autocorrelationTab"),
        autoCorrelationUI(ns("autoCorrelation"))
      )
    )
  )
}




visualMCMC <- function(input, output, session){
  
  callModule(chainPlot, "chainPlot")  
  callModule(rhat_n_eff_se_mean, "rhat_n_eff_se_mean")
  callModule(autoCorrelation, "autoCorrelation")
}
