diagnoseUI <- function(id){
  ns <- NS(id)
  
  tabsetPanel(
    id = "diagnose_tabset",
    
    #### hmc/nuts specific diagnostics ####
    tabPanel(
      title = "HMC diagnostics",
      
      # fixed input section of the HMC diagnostics page
      wellPanel(
        fluidRow(
          column(width = 3, h4(textOutput("diagnostic_chain_text"))),
          column(width = 4, h5("Parameter")),
          column(width = 4, h5("Transformation"))
        ),
        fluidRow(
          column(
            width = 3, div(style = "width: 100px;",
                           numericInput(
                             "diagnostic_chain",
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
              inputId = "diagnostic_param",
              label = NULL,
              multiple = FALSE,
              choices = .param_list,
              selected = .param_list[1]
            )
          )
          # column(
          #   width = 3,
          #   transformation_selectInput("diagnostic_param_transform")
          # ),
          # column(
          #   width = 2,
          #   actionButton("diagnostic_param_transform_go", "Transform", class = "transform-go")
          # )
        )
      ),
      
      
      # different tabs
      navlistPanel(
        id = "diagnostics_navlist",
        tabPanel(
          "MODULE_x" 
          # source_ui("diagnostics_by_parameter.R")
        ),
        tabPanel(
          "MODULE_y" 
        ),
        well = FALSE,
        widths = c(2, 10)
      )
    ),
    
    #### general diagnostics ####
    tabPanel(
      title = "Non-HMC diagnostics",
      navlistPanel(
        id = "diagnostics_navlist",
        tabPanel(
          "MODULE_x" 
        ),
        tabPanel(
          "MODULE_y" 
        ),
        well = FALSE,
        widths = c(2, 10)
      )
    )
    )
}

diagnose <- function(input, output, session){
  .param_list <- callModule(makeParamList, "makeParamList", sso = sso)
  print(.param_list)
  # this module does not do anything on the server side.
}
