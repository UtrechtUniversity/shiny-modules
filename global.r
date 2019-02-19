# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)

# load relevant modules

# home tab
source("MODULES/HOME/homepage.r")

# diagnoses tab
source("MODULES/DIAGNOSE/diagnoseHomepage.r")

# source("MODULES/plotAreas.r")
# source("MODULES/plotChains.r")
# source("MODULES/plotScatter.r")
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




# Example data and fit in global environment
# Assume you have a SSO object in global environment
sso <- shinystan::eight_schools