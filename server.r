server <- function(input, output, session) {
  
  # calling modules
  
  # home tab
  callModule(homepage, "homepage")
  callModule(diagnose, "diagnoseHomepage")
  
  
  # this is used to reference the HTML links to the correct page on the homepage
  # module. Need to find a way to actually incorporate this in the module and not
  # in the main server file.
  toc_entries <- c("Estimate", "Diagnose", "Explore", "Model Code")
  observe({
    local({
      lapply(toc_entries, function(x) {
        id <- paste0("toc_", if (x == "Model Code") "more" else tolower(x))
        shinyjs::onclick(id, updateTabsetPanel(session, "nav", selected = x))
      })
    })
  })
  
}

