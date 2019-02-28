numericalHMCUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
    tabPanel(
      title = "Stats",
      id = ns("numericalHMC"),
      navlistPanel(
        id = ns("HMC_navlist"),
        "NUTS/HMC",
        tabPanel(
          title = "All NUTS/HMC stats",
          id = ns("HMCstatTab"),
          statsTableHMCUI(ns("statsTableHMC"))
        ),
        "MCMC",
        tabPanel(
          title = withMathJax("\\(\\hat{R}, \\text{ } n_{eff}, \\text{ se}_{mean}\\)"),
          id = ns("rhat_n_eff_se_meanTab"),
          rhat_n_eff_se_mean_statsUI(ns("rhat_n_eff_se_mean_stats"))
        ),
        tabPanel(
          title = "Autocorrelation",
          id = ns("autocorrelationTab"),
          autoCorrelationStatsUI(ns("autoCorrelationStats"))
        )
      )
    )
}




numericalHMC <- function(input, output, session){
  
  callModule(statsTableHMC, "statsTableHMC")
  callModule(rhat_n_eff_se_mean_stats, "rhat_n_eff_se_mean_stats")
  callModule(autoCorrelationStats, "autoCorrelationStats")
}
