library(shiny)
library(ggplot2)
source("MODULES/linkedScatter.r")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      # checkboxInput("scatterSwitch", "Turn on Scatterplot module", FALSE)
    ),
    mainPanel(
      linkedScatterUI("scatter"),
      textOutput("summary")
    )
  )
)

server <- function(input, output, session) {
  datafile <- callModule(linkedScatter, "scatter",
                         reactive(mpg),
                         left = reactive(c("cty", "hwy")),
                         right = reactive(c("drv", "hwy")))

  output$summary <- renderText({
    sprintf("%d observation(s) selected", nrow(dplyr::filter(datafile(), selected_)))
  })
}

shinyApp(ui, server)
