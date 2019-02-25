# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)
library(dplyr)

# load relevant modules

# home tab
source("MODULES/HOME/homepage.r")
source("MODULES/HOME/warnings.r")

# diagnoses tab
source("MODULES/DIAGNOSE/diagnoseHomepage.r")
source("MODULES/DIAGNOSE/divergentTransitions.r")
source("MODULES/DIAGNOSE/energy.r")
source("MODULES/DIAGNOSE/treedepth.r")


# Example data and fit in global environment
# Assume you have a SSO object in global environment
# sso <- shinystan::eight_schools
# test different models
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_fullrank.rds")
sso <- readRDS("TEST MODELS/stan_demo_model_99_method_fullrank.rds")