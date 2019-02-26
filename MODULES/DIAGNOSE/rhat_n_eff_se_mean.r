rhat_n_eff_se_meanUI <- function(id){
  # for internal namespace structure
  ns <- NS(id)
  
  tagList(
   
    fluidRow(
      column(width = 3,
             sliderInput(
               ns("rhat_threshold"),
               withMathJax("\\(\\hat{R} \\text{ warning threshold}\\) "),
               ticks = FALSE,
               value = 1.1,
               min = 1,
               max = 1.2,
               step = 0.01
             )),
      column(width = 3,
             sliderInput(
               ns("n_eff_threshold"),
               withMathJax("\\(n_{eff} \\text{ / } \\textit{N} \\text{ warning threshold}\\) "),
               ticks = FALSE,
               value = 10,
               min = 0,
               max = 100,
               step = 5,
               post = "%"
             )),
      column(width = 3,
             sliderInput(
               ns("mcse_threshold"),
               "\\(\\text{se}_{mean} \\text{ / } \\textit{sd} \\text{ warning threshold}\\) ",
               ticks = FALSE,
               value = 10,
               min = 0,
               max = 100,
               step = 5,
               post = "%"
             ))
    ),
    fluidRow(
      column(width = 3, h4(withMathJax("\\(\\hat{R}\\)"), align = "center")),
      column(width = 3, h4(withMathJax("\\(n_{eff} / N\\)"), align = "center")),
      column(width = 3, h4(withMathJax("\\(mcse / sd\\)"), align = "center"))
      ),
    fluidRow(
      column(width = 3, plotOutput(ns("rhatPlot"))),
      column(width = 3, plotOutput(ns("n_effPlot"))),
      column(width = 3, plotOutput(ns("se_meanPlot")))
    )
  )  

}


rhat_n_eff_se_mean <- function(input, output, session){
  
  output$rhatPlot <- renderPlot({
    plot(1:10)
  })
  
  output$n_effPlot <- renderPlot({
    plot(1:10)
  })
  
  output$se_meanPlot <- renderPlot({
    plot(1:10)
  })
}
