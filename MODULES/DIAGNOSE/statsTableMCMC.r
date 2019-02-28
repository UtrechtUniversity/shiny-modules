statsTableMCMCUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  tagList(
    wellPanel(
      fluidRow(
        column(
          width = 3,
          numericInput(
            ns("sampler_digits"),
            label = h5("Decimals"),
            value = 4,
            min = 0,
            max = 10,
            step = 1
          )
        ),
        column(width = 4),
        column(width = 4)
      )
    ),
    DT::dataTableOutput(ns("sampler_summary"))
  )
  
}




statsTableMCMC <- function(input, output, session){
  
  MCMCtable <- reactive({
    out <- sso@summary[, c("Rhat", "n_eff", "se_mean", "sd")]
    out <- formatC(round(out, input$sampler_digits), 
                   format = 'f', digits = input$sampler_digits)
    out
  })
  
  
  output$sampler_summary <- DT::renderDataTable({
    DT::datatable({
      MCMCtable()
    }, options = list(
      # rownames = FALSE,
      processing = TRUE,
      deferRender = TRUE,
      scrollX = TRUE,
      scrollY = "200px",
      scrollCollapse = TRUE,
      paging = FALSE,
      searching = FALSE,
      info = FALSE
    ))
  })
  
  
}
