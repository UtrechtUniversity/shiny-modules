scatterPlotUI <- function(id){
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
            selected = c(sso@param_names[1],sso@param_names[which(sso@param_names == "log-posterior")]),
            options = list(maxItems = 2)
          )
        )
      )
    ),
    plotOutput(ns("plot1"))
  )
}


scatterPlot <- function(input, output, session){
  
  param <- reactive(input$diagnostic_param)
  
  
  output$plot1 <- renderPlot({
    
    color_scheme_set("darkgray")
    validate(
      need(length(param()) == 2, "Select two parameters.")
    )
    mcmc_scatter(
      sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ],
      pars = param()
    )
  })
}