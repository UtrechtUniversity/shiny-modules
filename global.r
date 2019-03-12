# call relevant packages
library(shiny)
library(shinydashboard)
library(rstan)
library(bayesplot)
library(dplyr)

# load relevant modules



# Example data and fit in global environment
# Assume you have a SSO object in global environment
sso <- shinystan::eight_schools
# sso <- shinystan::as.shinystan(readRDS("DATA/fit_full_model_cp.rds"))
# sso <- readRDS("TEST MODELS/eight_schools_meanfield.rds")
# test different models
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_fullrank.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_fullrank.rds")