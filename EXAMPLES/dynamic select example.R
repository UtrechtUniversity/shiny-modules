library(shiny)

dynamicSelectInput <- function(id, label, multiple = FALSE){
  
  ns <- shiny::NS(id)
  
  shiny::selectInput(ns("dynamic_select"), label,
                     choices = NULL, multiple = multiple, width = "100%")
  
}

#' Dynamical Update of a selectInput
#' @param the_data data.frame containing column of choices
#' @param column The column to select from
#' @param default_select The choices to select on load
dynamicSelect <- function(input, output, session, the_data, column, default_select = NULL){
  
  ## update input$dynamic_select
  observe({
    shiny::validate(
      shiny::need(the_data(),"Fetching data")
    )
    dt <- the_data()
    
    testthat::expect_is(dt, "data.frame")
    testthat::expect_is(column, "character")
    
    choice <- unique(dt[[column]])
    
    updateSelectInput(session, "dynamic_select",
                      choices = choice,
                      selected = default_select)
    
  })
  
  return(reactive(input$dynamic_select))
  
}

#' Using Dynamic Input
#' @param id Shiny Id
#' @param aggs The Aggregation names
outerTableUI <- function(id, aggs){
  
  ns <- shiny::NS(id)
  
  tagList(
    fluidRow(
      lapply(seq_along(aggs), function(x) {
        column(width = 4,
               dynamicSelectInput(ns(aggs[[x]]), aggs[[x]], multiple = TRUE)
        )
        
      })
    ),
    fluidRow(
      ## if this works should be able to filter this table
      ## by the selected filters above
      tableOutput(ns("table"))
    )
    
  )
}

#' server side
#' @export
outerTable <- function(input, output, session, the_data, aggs){
  
  selectResults <- lapply(setNames(aggs, aggs), function(agg) {
    callModule(module = dynamicSelect,
               id = agg,
               the_data = the_data,
               column = agg)
  })
  
  
  new_data <- reactive({
    old_data <- the_data()
    for(i in seq_along(aggs)){
      
      agg <- aggs[i]
      
      inputA <- selectResults[[agg]]()
      if(is.null(inputA)){
        next
      } else {
        old_col <- old_data[[agg]]
        
        new_data <- old_data[old_col %in% inputA,]
        
        old_data <- new_data
        
      }
    }
    
    new_data
    
  })
  
  output$table <- renderTable({
    new_data()
  })
  
  
}


### Call via:

the_data <- mtcars
the_filters = c("carb", "gear")

shinyApp(
  ui = fluidPage(
    outerTableUI("debug_dynamic",
                 aggs = the_filters)
  ),
  server = function(input, output, session){
    callModule(outerTable,
               "debug_dynamic",
               the_data = reactive(the_data),
               aggs = the_filters)
  }
)