# call relevant packages
library(shiny)
library(bayesplot)

# load relevant modules
source("MODULES/plotAreas.r")
# source("MODULES/")
# source("MODULES/")
# source("MODULES/")


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
