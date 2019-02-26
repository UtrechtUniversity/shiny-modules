HMCdiagnosticsUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tabPanel(
    title = "HMC specific",
    id = ns("HMC"),
    # The well panel is the top panel with selection 
    # for chains, parameters and transformation
    wellPanel(
      fluidRow(
        column(width = 3),
        column(width = 4, h5("Parameter")),
        column(width = 4, h5("Transformation"))
      ),
      fluidRow(
        column(
          width = 3, div(style = "width: 100px;",
                         numericInput(
                           ns("diagnostic_chain"),
                           label = NULL,
                           value = 0,
                           min = 0,
                           # don't allow changing chains if only 1 chain
                           max = ifelse(sso@n_chain == 1, 0, sso@n_chain)
                         )
          )),
        column(
          width = 4,
          selectizeInput(
            inputId = ns("diagnostic_param"),
            label = NULL,
            multiple = FALSE,
            choices = sso@param_names[-which(sso@param_names == "log-posterior")],
            selected = sso@param_names[1]
          )
        )
      )
    ),
    # The panel on the side for the HMC tab on top.
    navlistPanel(
      id = ns("HMC_navlist"),
      "Visual Diagnostics",
      tabPanel(
        title = "Divergent Transitions",
        id = ns("divergentTransitionsTab"),
        divergentTransitionsUI(ns("divergentTransitions"))
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
        id = ns("stepSizeTab")
      ),
      "Numerical Diagnostics",
      tabPanel(
        title = "Summary of Sampler Parameters",
        id = ns("numericalDiagnostics")
      )
    )
  )
  
}




HMCdiagnostics <- function(input, output, session){
  
  # call module for divergent transitions, pass selection of variable
  callModule(divergentTransitions, "divergentTransitions", 
             pars = reactive(input$diagnostic_param),
             chains = reactive(input$diagnostic_chain))
  callModule(energy, "energy", 
             pars = reactive(input$diagnostic_param),
             chains = reactive(input$diagnostic_chain))
  callModule(treedepth, "treedepth", 
             pars = reactive(input$diagnostic_param),
             chains = reactive(input$diagnostic_chain))
  
}
