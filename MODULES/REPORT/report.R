reportUI <- function(id) {
  ns <- NS(id)
  tagList(
    tabPanel( "Plot Tab",
              navlistPanel(
                tabPanel("Get plots out",
                         downloadButton(ns('downloadPlot'), 'Download Plot'),
                         downloadButton(ns('downloadRDS'), 'Download RDS'))
              )
    )
  )
  
}

report <- function(input, output, session, ggplotsList) {
  
  output$downloadPlot <- downloadHandler(
    filename = 'test.pdf',
    content = function(file) {
      pdf(file)
      print(ggplotsList())
      print(ggplotsList())
      dev.off()
    })  
  
  output$downloadRDS <- downloadHandler(
    filename = 'test.rds',
    content = function(file) {
      saveRDS(ggplotsList(), file)
    })  
  
  
  
}