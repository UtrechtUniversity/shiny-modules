transformUI <- function(id){
  ns <- NS(id)
  tagList(uiOutput(ns("transform")))
}

transform <- function(input, output, session){
  
  output$transform <- renderUI({
    
    inverse <- function(x) 1/x
    cloglog <- function(x) log(-log1p(-x))
    square <- function(x) x^2
    
    transformation_choices <- c(
      "abs", "atanh",
      cauchit = "pcauchy", "cloglog",
      "exp", "expm1",
      "identity", "inverse", inv_logit = "plogis",
      "log", "log10", "log2", "log1p", logit = "qlogis",
      probit = "pnorm", "square", "sqrt"
    )
    
    selectInput(
      inputId = session$ns("transformation"),
      label = NULL,
      choices = transformation_choices,
      selected = "identity"
    )
    
  })
  
  transform <- reactive(input$transformation)
  return(transform())
}
  