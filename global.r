# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)

# load relevant modules

# home tab
source("MODULES/HOME/homepage.r")

source("MODULES/plotAreas.r")
source("MODULES/plotChains.r")
source("MODULES/plotScatter.r")
# source("MODULES/")
# source("MODULES/")
# source("MODULES/")

# define functions that are needed
save_and_close_button <- function() {
  tags$button(
    id = 'save_and_close_button',
    type = "button",
    class = "btn action-button",
    onclick = "window.close();",
    "Save & Close"
  )
}

logo_and_name <- function() {
  div(div(
    img(
      src = "wide_ensemble.png",
      class = "wide-ensemble",
      width = "100%"
    )
  ),
  div(
    style = "margin-top: 25px",
    img(src = "stan_logo.png", class = "stan-logo"),
    div(id = "shinystan-title", "ShinyStan")
  ))
}


# Example data and fit in global environment
# Linear regression example code:
# library(rstanarm)
# mtcars$mpg10 <- mtcars$mpg / 10
# fit <- stan_glm(
#   mpg10 ~ wt + cyl + am,            
#   data = mtcars,
#   seed = 13031990
# ) 
# saveRDS(fit, "DATA/exampleStanFit.rds")
# loading data for use in app
fit <- readRDS("DATA/exampleStanFit.rds")
