library(shiny)

plotModuleUI <- function(id){
  ns <- NS(id)
  tagList(
    actionButton(inputId = ns("Button"), label = "generate"),
    sliderInput(ns("slider"), "draw N", min= 2,max = 10, value = 5),
    plotOutput(ns("plot1"))
  )
}

plotModule <- function(input, output, session){
  
 n <- reactive({input$slider})
  
    observeEvent(input$Button, {
  output$plot1 <- renderPlot({
    plotOut(n = n())
    })
  })
    
    
  plotOut <- function(n){
    
    mcmc_acf(sso@posterior_sample, "mu",lags = n)
  }
  
 
  
   return(reactive({plotOut(n = n())}))

}


ui <- function(id) {
  tagList(
  tabPanel( "Plot Tab",
    navlistPanel(
      tabPanel("plotting",
               plotModuleUI("plotModule"),
      downloadButton('downloadPlot', 'Download Plot'))
    )
  )
  )
}

server <- function(input, output, session){
  
  
  getPlot <-  callModule(plotModule, "plotModule")
    
  
  
  output$downloadPlot <- downloadHandler(
    filename = 'test.pdf',
    content = function(file) {
      # device <- function(..., width, height) {
        # grDevices::pdf(..., width = width, height = height)
      # }
      # ggsave(file, plot = getPlot(), device = device)
      # cowplot::save_plot(file, cowplot::plot_grid(getPlot(), getPlot()))
      pdf(file)
      print(getPlot())
      print(getPlot())
      dev.off()
    })  
  
}

shinyApp(ui, server)
