server <- function(input, output, session) {
  
  
  
  

  # internal functions that are required for general use.
  # save and close button function
  observeEvent(
    input$save_and_close_button, 
    stopApp()
  )
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


  # functions to get parameter lists for input selection tools
# 
#   # update parameter selection for multi-parameter plots --------------------
#   # update with regex
#   .test_valid_regex <- function(pattern) {
#     trygrep <- try(grep(pattern, ""), silent = TRUE)
#     if (inherits(trygrep, "try-error"))
#       FALSE
#     else
#       TRUE
#   }
#   .update_params_with_regex <- function(params, all_param_names, regex_pattern) {
#     sel <- which(all_param_names %in% params)
#     to_search <- if (length(sel))
#       all_param_names[-sel] else all_param_names
#     if (!length(regex_pattern))
#       return(params)
# 
#     to_add <- grep(regex_pattern, to_search, value = TRUE)
#     if (!length(to_add))
#       params
#     else
#       c(params, to_add)
#   }
# 
#   # update with groups
#   .update_params_with_groups <- function(params, all_param_names) {
#     as_group <- grep("_as_shinystan_group", params)
#     if (!length(as_group))
#       return(params)
#     make_group <- function(group_name) {
#       all_param_names[grep(paste0("^",group_name,"\\["), all_param_names)]
#     }
#     single_params <- params[-as_group]
#     grouped_params <- params[as_group]
#     groups <- gsub("_as_shinystan_group", "", grouped_params)
#     groups <- sapply(groups, make_group)
#     c(single_params, unlist(groups))
#   }
  
  
  
  # calling modules
  
  # home tab
  callModule(homepage, "homepage")
  callModule(diagnose, "diagnoseHomepage")
  
}

