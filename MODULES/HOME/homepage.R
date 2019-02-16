homepageUI <- function(id){
  tagList(
    logo_and_name(),
    div(class = "home-links",
        div(id = "model-name",
            br(),
            h2("Model:"),
            h4(fit$stanfit@model_name))), #note this used to be .model_name
    br(), br(), br(), br(),
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
  
}