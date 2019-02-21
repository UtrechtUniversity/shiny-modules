# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)
library(dplyr)

# load relevant modules

# home tab
source("MODULES/HOME/homepage.r")

# diagnoses tab
source("MODULES/DIAGNOSE/diagnoseHomepage.r")
source("MODULES/DIAGNOSE/divergentTransitions.r")


# Example data and fit in global environment
# Assume you have a SSO object in global environment
sso <- shinystan::eight_schools