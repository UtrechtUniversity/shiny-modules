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

source("MODULES/DIAGNOSE/visualHMC.r")
source("MODULES/DIAGNOSE/visualMCMC.r")
source("MODULES/DIAGNOSE/visualVI.r")

source("MODULES/DIAGNOSE/divergentTransitions.r")
source("MODULES/DIAGNOSE/energy.r")
source("MODULES/DIAGNOSE/treedepth.r")
source("MODULES/DIAGNOSE/stepSize.r")
source("MODULES/DIAGNOSE/parallelCoordinates.r")

source("MODULES/DIAGNOSE/chainPlot.r")
source("MODULES/DIAGNOSE/rhat_n_eff_se_mean.r")
source("MODULES/DIAGNOSE/autoCorrelation.r")

source("MODULES/DIAGNOSE/numericalHMC.r")
source("MODULES/DIAGNOSE/statsTableHMC.r")
source("MODULES/DIAGNOSE/statsTableMCMC.r")

# Example data and fit in global environment
# Assume you have a SSO object in global environment
sso <- shinystan::eight_schools
# sso <- readRDS("TEST MODELS/eight_schools_meanfield.rds")
# test different models
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_sampling.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_meanfield.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_473_method_fullrank.rds")
# sso <- readRDS("TEST MODELS/stan_demo_model_99_method_fullrank.rds")