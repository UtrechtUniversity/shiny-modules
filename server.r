server <- function(input, output, session) {
  
  observeEvent(input$switchArea,{
    if(input$switchArea == TRUE){
      insertTab(inputId = "tabs",
                tabPanel("Area", plotAreaUI("areaPlot", stanFit = fit)),
                target = "Foo")
      callModule(plotArea, "areaPlot", stanFit = fit)
    } else {
      removeTab(inputId = "tabs", target = "Area")
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
  
  # # call the module plotArea. 
  # # This has been given the name areaPlot in the UI file. 
  # # Use top notation to store output from the server part of the module
  # # Use bottom notation to just call the module
  # # areaPlot <- callModule(plotArea, "areaPlot", stanFit = fit)
  # callModule(plotArea, "areaPlot", stanFit = fit)
  # 
  # # Only evaluate the plot within the moduel if the checkbox is TRUE
  # eval_chainsPlot <- reactive(input$chainsPlot_eval)
  # callModule(plotChains, "chainsPlot", stanFit = fit, eval = eval_chainsPlot)
  # 
  # # Only call moduel if checkbox is TRUE
  # eval_scatterPlot <- reactive(input$scatterPlot_eval)
  # callModule(plotScatter, "scatterPlot", stanFit = fit, eval = eval_scatterPlot)
  
}

