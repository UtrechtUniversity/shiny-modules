diagnoseUI <- function(id){
  ns <- NS(id)
  
  tagList(
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
            choices = sso@param_names,
            selected = sso@param_names[1]
          )
        )
      )
    ),
    tabsetPanel(
      id = ns("diagnose_tabset"),
      tabPanel(
        title = "HMC diagnostics",
        id = ns("HMC"),
        navlistPanel(
          id = ns("HMC_navlist"),
          tabPanel(
            title = "Divergent Transitions",
            id = ns("divergentTransitionsTab"),
            divergentTransitionsUI(ns("divergentTransitions"))
          )
        )
      )
    )
  )
  # 
  # tabPanel(
  #   title = "NUTS (plots)",
  #   source_ui("diagnostics_customize.R"),
  #   navlistPanel(
  #     id = "diagnostics_navlist",
  #     tabPanel(
  #       "By model parameter", 
  #       source_ui("diagnostics_by_parameter.R")
  #     ),
  
  
}

diagnose <- function(input, output, session){
  
  # call module for divergent transitions, pass selection of variable
  callModule(divergentTransitions, "divergentTransitions", pars = reactive(input$diagnostic_param))
  
}
