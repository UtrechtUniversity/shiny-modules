visualHMCUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tabPanel(
    title = "Plots",
    id = ns("visualHMC"),
    navlistPanel(
      id = ns("HMC_navlist"),
      "NUTS/HMC",
      tabPanel(
        title = "Divergent Transitions",
        id = ns("divergentTransitionsTab"),
        divergentTransitionsUI(ns("divergentTransitions"))
      ),
      tabPanel(
        title = "Parallel Coordinates",
        id = ns("parallelCoordinatesTab"),
        parallelCoordinatesUI(ns("parallelCoordinates"))
      ),
      tabPanel(
        title = "Energy Information",
        id = ns("energyTab"),
        energyUI(ns("energy"))
      ),
      tabPanel(
        title = "Treedepth Information",
        id = ns("treedepthTab"),
        treedepthUI(ns("treedepth"))
      ),
      tabPanel(
        title = "Step Size Information",
        id = ns("stepSizeTab"),
        stepSizeUI(ns("stepSize"))
      ),
      "MCMC",
      tabPanel(
        title = "Trace Plots",
        id = ns("chainTab"),
        chainPlotUI(ns("chainPlot"))
      ),
      tabPanel(
        title = withMathJax("\\(\\hat{R}, \\text{ } n_{eff}, \\text{ se}_{mean}\\)"),
        id = ns("rhat_n_eff_se_meanTab"),
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




visualHMC <- function(input, output, session){
  
  callModule(parallelCoordinates, "parallelCoordinates")
  callModule(divergentTransitions, "divergentTransitions")
  callModule(energy, "energy")
  callModule(treedepth, "treedepth")
  callModule(stepSize, "stepSize")
  
  callModule(chainPlot, "chainPlot")  
  callModule(rhat_n_eff_se_mean, "rhat_n_eff_se_mean")
  callModule(autoCorrelation, "autoCorrelation")
}
