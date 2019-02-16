ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      actionButton("add", "Add 'Dynamic' tab"),
      actionButton("remove", "Remove 'Foo' tab"),
      checkboxInput("switch", "switch for hello tab")
    ),
    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Hello", plotAreaUI("areaPlot", stanFit = fit)),
                  tabPanel("Foo", "This is the foo tab"),
                  tabPanel("Bar", "This is the bar tab")
      )
    )
  )
)
server <- function(input, output, session) {
  observeEvent(input$switch,{
    if(input$switch == TRUE){
      insertTab(inputId = "tabs",
                tabPanel("Hello", plotAreaUI("areaPlot", stanFit = fit)),
                target = "Foo")
      callModule(plotArea, "areaPlot", stanFit = fit)
    } else {
      removeTab(inputId = "tabs", target = "Hello")
    }
  })
  
  observeEvent(input$add, {
    insertTab(inputId = "tabs",
              tabPanel("Dynamic", "This a dynamically-added tab"),
              target = "Bar"
    )
  })
  observeEvent(input$remove, {
    removeTab(inputId = "tabs", target = "Foo")
  })
}

shinyApp(ui, server)
