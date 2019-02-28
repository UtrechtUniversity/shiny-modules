divergentTransitionsUI <- function(id){
  ns <- NS(id)
  tagList(
    wellPanel(
      fluidRow(
        column(width = 3, h5(textOutput(ns("diagnostic_chain_text")))),
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
            multiple = TRUE,
            choices = sso@param_names,
            selected = c(sso@param_names[1],sso@param_names[which(sso@param_names == "log-posterior")]),
            options = list(maxItems = 2)
          )
        )
      )
    ),
    plotOutput(ns("plot1"))
  )
}


divergentTransitions <- function(input, output, session){
  
  chain <- reactive(input$diagnostic_chain)
  param <- reactive(input$diagnostic_param)
  

  
  
  output$diagnostic_chain_text <- renderText({
    if (chain() == 0)
      return("All chains")
    paste("Chain", chain())
  })
  
  output$plot1 <- renderPlot({
    
    color_scheme_set("darkgray")
    validate(
      need(length(param()) == 2, "Select two parameters.")
      )
    mcmc_scatter(
      if(chain() != 0) {
        sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, chain(), ]
      } else {
        sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ]
      },
      pars = param(),
      np = if(chain() != 0) {
        nuts_params(list(sso@sampler_params[[chain()]]) %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix))
      } else {
        nuts_params(sso@sampler_params %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix)) 
        
      },
      np_style = scatter_style_np(div_color = "green", div_alpha = 0.8)
    )
  })
}