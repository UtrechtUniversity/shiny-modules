diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  tagList(
    if(sso@misc$stan_method == "sampling" & sso@misc$stan_algorithm == "NUTS") uiOutput(ns("visualHMC")),
    if(sso@misc$stan_method == "sampling" & sso@misc$stan_algorithm != "NUTS") uiOutput(ns("visualMCMC")),
    if(sso@misc$stan_method != "sampling") uiOutput(ns("visualVI"))
  )
  
}

diagnose <- function(input, output, session){
  
  if(sso@misc$stan_method == "sampling" & sso@misc$stan_algorithm == "NUTS"){
    callModule(parallelCoordinates, "parallelCoordinates")
    callModule(divergentTransitions, "divergentTransitions")
    callModule(energy, "energy")
    callModule(treedepth, "treedepth")
    callModule(stepSize, "stepSize")
    callModule(acceptance, "acceptance")
  }
  
  if(sso@misc$stan_method == "sampling"){
    callModule(chainPlot, "chainPlot")  
    callModule(rhat_n_eff_se_mean, "rhat_n_eff_se_mean")
    callModule(autoCorrelation, "autoCorrelation")
  }
  

  output$visualHMC <- renderUI({
    validate(
      need(sso@misc$stan_method == "sampling", ""),
      need(sso@misc$stan_algorithm == "NUTS", ""))
    tagList(
      tags$head(
        tags$script("src"="func.js")),
    tabPanel(
      title = "Plots",
      id = session$ns("visualHMC"),
      navlistPanel(
        id = session$ns("HMC_navlist"),
        "NUTS/HMC",
        tabPanel(
          title = "Divergent Transitions",
          id = session$ns("divergentTransitionsTab"),
          divergentTransitionsUI(session$ns("divergentTransitions"))
        ),
        tabPanel(
          title = "Parallel Coordinates",
          id = session$ns("parallelCoordinatesTab"),
          parallelCoordinatesUI(session$ns("parallelCoordinates"))
        ),
        tabPanel(
          title = "Energy Information",
          id = session$ns("energyTab"),
          energyUI(session$ns("energy"))
        ),
        tabPanel(
          title = "Treedepth Information",
          id = session$ns("treedepthTab"),
          treedepthUI(session$ns("treedepth"))
        ),
        tabPanel(
          title = "Step Size Information",
          id = session$ns("stepSizeTab"),
          stepSizeUI(session$ns("stepSize"))
        ),
        tabPanel(
          title = "Acceptance",
          id = session$ns("acceptanceTab"),
          acceptanceUI(session$ns("acceptance"))
        ),
        "MCMC",
        tabPanel(
          title = "Trace Plots",
          id = session$ns("chainTab"),
          chainPlotUI(session$ns("chainPlot"))
        ),
        tabPanel(
          title = withMathJax("\\(\\hat{R}, \\text{ } n_{eff}, \\text{ se}_{mean}\\)"),
          id = session$ns("rhat_n_eff_se_meanTab"),
          rhat_n_eff_se_meanUI(session$ns("rhat_n_eff_se_mean"))
        ),
        tabPanel(
          title = "Autocorrelation",
          id = session$ns("autocorrelationTab"),
          autoCorrelationUI(session$ns("autoCorrelation"))
        )
      )
    )
    )
  })
  
  output$visualMCMC <- renderUI({
    validate(
      need(sso@misc$stan_method == "sampling", ""), 
      need(sso@misc$stan_algorithm != "NUTS", ""))
    
    tabPanel(
      title = "Plots",
      id = session$ns("visualHMC"),
      navlistPanel(
        id = session$ns("HMC_navlist"),
        tabPanel(
          title = "Trace Plots",
          id = session$ns("chainTab"),
          chainPlotUI(session$ns("chainPlot"))
        ),
        tabPanel(
          title = withMathJax("\\(\\hat{R}, \\text{ } n_{eff}, \\text{ se}_{mean}\\)"),
          id = session$ns("rhat_n_eff_se_meanTab"),
          rhat_n_eff_se_meanUI(session$ns("rhat_n_eff_se_mean"))
        ),
        tabPanel(
          title = "Autocorrelation",
          id = session$ns("autocorrelationTab"),
          autoCorrelationUI(session$ns("autoCorrelation"))
        )
      )
    )
    
  })
  
  output$visualVI <- renderUI({
    validate(need(sso@misc$stan_method == "variational", ""))
    h4("Currently no diagnostics available for Variational Inference")
  })
  
  
  
}
