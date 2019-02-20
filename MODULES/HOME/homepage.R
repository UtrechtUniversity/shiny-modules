homepageUI <- function(id){
  ns <- NS(id)
  
  tagList(
    # this top part used to be logo_and_name function. 
    # Only occured in hompage and about section
    # so now directly encoded in module.
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
    ,
    div(class = "home-links",
        div(id = "model-name",
            br(),
            h2("Model:"),
            h4(sso@model_name))), #note this used to be .model_name
    br(), br(), br(), br(),
    # html used to be called, now directly in module
    HTML("
<div id = 'links_nav_div'>
<nav class='cl-effect-9' id='links_nav'>
  
  <a id = 'toc_diagnose' href='#cl-effect-9'>
    <span>Diagnose</span>
    <span>MCMC diagnostics<span>with special features for NUTS</span>
    </span>
  </a>
  
  <a id = 'toc_estimate' href='#cl-effect-9'>
    <span>Estimate</span>
    <span>Multiparameter plots<span>& posterior summary statistics</span>
    </span>
  </a>
  
  <a id = 'toc_explore' href='#cl-effect-9'>
    <span>Explore</span>
    <span>Transform and compare<span> parameters in 2D or 3D</span>
    </span>
  </a>
  
  <a id = 'toc_more' href='#cl-effect-9'>
    <span>More</span><span>Model code, notes<span>& glossary</span>
    </span>
  </a>
  
</nav>
</div>" )
  )
}

homepage <- function(input, output, session){
  # this module does not do anything on the server side.
  
}