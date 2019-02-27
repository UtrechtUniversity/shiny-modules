energyUI <- function(id){
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
          choices = sso@param_names[-which(sso@param_names == "log-posterior")],
          selected = sso@param_names[1]
        )
      )
    )
  ),
  plotOutput(ns("plot1"))
  )
}


energy <- function(input, output, session){
  
  output$plot1 <- renderPlot({
    
    chain <- reactive(input$diagnostic_chain)
    color_scheme_set("blue")
    mcmc_nuts_energy(
      if(chain() != 0) {
        nuts_params(list(sso@sampler_params[[chain()]]) %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix))
      } else {
        nuts_params(sso@sampler_params %>%
                      lapply(., as.data.frame) %>%
                      lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                      lapply(., as.matrix)) 
        
      }
    )
  })
}