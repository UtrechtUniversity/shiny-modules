transformationSelectInputUI <- function(id){
  ns <- NS(id)
  
  
  uiOutput(ns("transform"))
  
}

transformationSelectInput <- function(input, output, session){
  
  inverse <- function(x) 1/x
  cloglog <- function(x) log(-log1p(-x))
  square  <- function(x) x^2
  
  transformation_choices <-
    c(
      "abs", "atanh",
      cauchit = "pcauchy", "cloglog",
      "exp", "expm1",
      "identity", "inverse", inv_logit = "plogis",
      "log", "log10", "log2", "log1p", logit = "qlogis",
      probit = "pnorm",
      "square", "sqrt"
    )
  
  output$transform <- renderUI({
    ns <- session$ns
    selectInput(
      id = ns("test"),
      label = NULL,
      choices = transformation_choices,
      selected = "identity"
    )
  })
  
}

