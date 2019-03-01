histogramPlotUI <- function(id){
  ns <- NS(id)
  tagList(
    wellPanel(
      fluidRow(
        column(width = 3),
        column(width = 4, h5("Parameter")),
        column(width = 4, h5("Transformation"))
      ),
      fluidRow(
        column(width = 3),
        column(
          width = 4,
          selectizeInput(
            inputId = ns("diagnostic_param"),
            label = NULL,
            multiple = TRUE,
            choices = sso@param_names,
            selected = c(sso@param_names[1])
          )
        )
      )
    ),
    plotOutput(ns("plot1"))
  )
}


histogramPlot <- function(input, output, session){
  
  param <- reactive(input$diagnostic_param)
  
  output$plot1 <- renderPlot({
    
    color_scheme_set("blue")
    validate(
      need(length(param()) > 0, "Select at least one parameter.")
    )
    mcmc_hist(
      sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ],
      pars = param()
    )
  })
}