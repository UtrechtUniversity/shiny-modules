diagnoseUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  # encapsulate everything in taglist, see https://shiny.rstudio.com/articles/modules.html
  tagList(
    tabsetPanel(
      id = ns("diagnose_tabset"),
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
                choices = sso@param_names,
                selected = sso@param_names[1]
              )
            )
          )
        ),
        # The panel on the side for the HMC tab on top.
        navlistPanel(
          id = ns("HMC_navlist"),
          tabPanel(
            title = "Divergent Transitions",
            id = ns("divergentTransitionsTab"),
            divergentTransitionsUI(ns("divergentTransitions"))
          ),
          tabPanel(
            title = "Energy",
            id = ns("EnergyTab")
          )
        )
      ), # end of HMC tabpanel
      tabPanel(
        title = "non-HMC specific",
        id = ns("non-HMC")
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
  callModule(divergentTransitions, "divergentTransitions", 
             pars = reactive(input$diagnostic_param),
             chains = reactive(input$diagnostic_chain))
  
}
