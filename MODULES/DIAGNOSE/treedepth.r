treedepthUI <- function(id){
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


treedepth <- function(input, output, session){
  
  output$plot1 <- renderPlot({
    
    chain <- reactive(input$diagnostic_chain)
    
    output$diagnostic_chain_text <- renderText({
      if (chain() == 0)
        return("All chains")
      paste("Chain", chain())
    })
    
    color_scheme_set("blue")
    
      if(chain() != 0) {
        mcmc_nuts_treedepth(
        x = nuts_params(list(sso@sampler_params[[chain()]]) %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix)),
        lp = data.frame(Iteration = rep(1:(sso@n_iter - sso@n_warmup), 1),
                        Value = c(sso@posterior_sample[(sso@n_warmup + 1):sso@n_iter, chain(),"log-posterior"]),
                        Chain = rep(chain(), each = (sso@n_iter - sso@n_warmup))) 
        )
      } else {
        mcmc_nuts_treedepth(
        x = nuts_params(sso@sampler_params %>%
                          lapply(., as.data.frame) %>%
                          lapply(., filter, row_number() == (1 + sso@n_warmup) : sso@n_iter) %>%
                          lapply(., as.matrix)),
        lp = data.frame(Iteration = rep(1:(sso@n_iter - sso@n_warmup), sso@n_chain),
                        Value = c(sso@posterior_sample[(sso@n_warmup + 1):sso@n_iter, ,"log-posterior"]),
                        Chain = rep(1:sso@n_chain, each = (sso@n_iter - sso@n_warmup))) 
        )
      }
  })
}