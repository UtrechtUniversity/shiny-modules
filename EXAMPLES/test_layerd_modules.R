outerUI <- function(id) {
  ns <- NS(id)
  sidebarLayout(
    sidebarPanel(
      checkboxInput("switchChains", "Chains Plot")
    ),
    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Area", plotAreaUI(ns("areaPlot"), stanFit = fit)),
                  tabPanel("Chains", plotChainsUI(ns("chainsPlot"), stanFit = fit)),
                  tabPanel("Scatter", plotScatterUI("scatterPlot", stanFit = fit)))
      )
  )
}


outer <- function(input, output, session) {
  
  eval_chainsPlot <- reactive(input$switchChains)
  observe(print(eval_chainsPlot()))
  callModule(plotArea, "areaPlot", stanFit = fit)
  callModule(plotChains, "chainsPlot", stanFit = fit, eval = eval_chainsPlot)
  callModule(plotScatter, "scatterPlot", stanFit = fit, eval = eval_scatterPlot)
  
}




library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
    ),
    mainPanel(
      outerUI("outer")
    )
  )
)

server <- function(input, output, session) {
  callModule(outer, "outer")
}

shinyApp(ui, server)
