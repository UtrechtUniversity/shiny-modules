# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)

# load relevant modules

# internal functions that can be used
source("MODULES/UTILITIES/makeParamList.r")
source("MODULES/UTILITIES/makeParamListWithGroups.r")
source("MODULES/UTILITIES/transformationSelectInput.r")

# home tab
source("MODULES/HOME/homepage.r")

# diagnoses tab
source("MODULES/DIAGNOSE/diagnoseHomepage.r")
source("MODULES/DIAGNOSE/divergentTransitions.r")

# source("MODULES/plotAreas.r")
# source("MODULES/plotChains.r")
# source("MODULES/plotScatter.r")
# source("MODULES/")
# source("MODULES/")
# source("MODULES/")





# Example data and fit in global environment
# Assume you have a SSO object in global environment
sso <- shinystan::eight_schools