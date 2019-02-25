chainPlotUI <- function(id){
  # for internal namespace structure
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
    plotOutput(ns("plot1"))
  )
  
}




chainPlot <- function(input, output, session){
  
  output$plot1 <- renderPlot({
    
    chain <- reactive(input$diagnostic_chain)
    param <- reactive(input$diagnostic_param)
    color_scheme_set("mix-blue-pink")
    mcmc_trace( if(chain() != 0) {
      sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, chain(), ]
    } else {
      sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ]
    }, pars = param())
    #   mcmc_scatter(
    
    #     pars = c(pars(), "log-posterior"),
    #     np = if(chain != 0) {
    #       nuts_params(list(sso@sampler_params[[chain]]) %>%
    #                     lapply(., as.data.frame) %>%
    #                     lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
    #                     lapply(., as.matrix))
    #     } else {
    #       nuts_params(sso@sampler_params %>%
    #                     lapply(., as.data.frame) %>%
    #                     lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
    #                     lapply(., as.matrix)) 
    #       
    #     },
    #     np_style = scatter_style_np(div_color = "green", div_alpha = 0.8)
    #   )
    # plot(1:10)
  })
  
}
