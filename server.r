server <- function(input, output, session) {
  
  # calling modules
  
  # home tab
  callModule(homepage, "homepage")
  
  
  
  
  
  
  
  
  observeEvent(input$switchArea,{
    if(input$switchArea == TRUE){
      appendTab(inputId = "tabs",
                tabPanel("Area", plotAreaUI("areaPlot", stanFit = fit)))
      callModule(plotArea, "areaPlot", stanFit = fit)
    } else {
      removeTab(inputId = "tabs", target = "Area")
    }
  })

  
  # reactive may not be needed, if input$switchChains is FALSE the module will
  # not be called and therefore not be evalueated. So maybe the optional 
  # evaluation within the module is not needed. 
  eval_chainsPlot <- reactive(input$switchChains)
  
  observeEvent(input$switchChains,{
    if(input$switchChains == TRUE){
      appendTab(inputId = "tabs",
                tabPanel("Chains", plotChainsUI("chainsPlot", stanFit = fit)))
      callModule(plotChains, "chainsPlot", stanFit = fit, eval = eval_chainsPlot)
    } else {
      removeTab(inputId = "tabs", target = "Chains")
    }
  })
  
  
  eval_scatterPlot <- reactive(input$switchScatter)
  
  observeEvent(input$switchScatter,{
    if(input$switchScatter == TRUE){
      appendTab(inputId = "tabs",
                tabPanel("Scatter", plotScatterUI("scatterPlot", stanFit = fit)))
      callModule(plotScatter, "scatterPlot", stanFit = fit, eval = eval_scatterPlot)
    } else {
      removeTab(inputId = "tabs", target = "Scatter")
    }
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

