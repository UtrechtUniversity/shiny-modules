library(shiny)
source("MODULES/csvExample.r")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      csvFileInput("datafile", "User data (.csv format)")
    ),
    mainPanel(
      dataTableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  datafile <- callModule(csvFile, "datafile",
                         stringsAsFactors = FALSE)
  
  output$table <- renderDataTable({
    datafile()
  })
}

shinyApp(ui, server)
