internalFunctionsUI <- function(id){
  
}

internalFunctions <- function(input, output, session){

  
  # internal functions that are required for general use.
  
  
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
  
  # make_param_list ------------------------------------------------------
  # generate list of parameter names (formatted for shiny::selectInput)
  .make_param_list <- function(object) {
    param_names <- slot(object, "param_names")
    param_dims <- slot(object, "param_dims")
    param_groups <- names(param_dims)
    choices <- list()
    ll <- length(param_dims)
    choices[seq_len(ll)] <- ""
    names(choices) <- param_groups
    for(i in seq_len(ll)) {
      if (length(param_dims[[i]]) == 0) {
        choices[[i]] <- list(param_groups[i])
      }
      else {
        temp <- paste0(param_groups[i],"\\[")
        choices[[i]] <- param_names[grep(temp, param_names)]
      }
    }
    choices
  }
  # use function to get paramters list
  .param_list <- .make_param_list(sso)
  
  # make_param_list_with_groups ------------------------------------------------------
  # generate list of parameter names and include parameter groups (formatted for
  # shiny::selectInput)
  .make_param_list_with_groups <- function(object, sort_j = FALSE) {
    param_names <- slot(object, "param_names")
    param_dims <- slot(object, "param_dims")
    param_groups <- names(param_dims)
    ll <- length(param_dims)
    LL <- sapply(seq_len(ll), function(i) length(param_dims[[i]]))
    choices <- list()
    choices[seq_len(ll)] <- ""
    names(choices) <- param_groups
    for(i in seq_len(ll)) {
      if (LL[i] == 0) {
        choices[[i]] <- list(param_groups[i])
      } else {
        group <- param_groups[i]
        temp <- paste0("^",group,"\\[")
        ch <- param_names[grep(temp, param_names)]
        
        #       toggle row/column major sorting so e.g. "beta[1,1], beta[1,2],
        #       beta[2,1], beta[2,2]" instead of "beta[1,1], beta[2,1], beta[1,2],
        #       beta[2,2]"
        if (sort_j == TRUE & LL[i] > 1)
          ch <- gtools::mixedsort(ch)
        
        ch_out <- c(paste0(group,"_as_shinystan_group"), ch)
        names(ch_out) <- c(paste("ALL", group), ch)
        choices[[i]] <- ch_out
      }
    }
    
    choices
  }
  # use function to get parameters list with groups
  .param_list_with_groups <- .make_param_list_with_groups(sso)
  
  # update parameter selection for multi-parameter plots --------------------
  # update with regex
  .test_valid_regex <- function(pattern) {
    trygrep <- try(grep(pattern, ""), silent = TRUE)
    if (inherits(trygrep, "try-error"))
      FALSE
    else
      TRUE
  }
  .update_params_with_regex <- function(params, all_param_names, regex_pattern) {
    sel <- which(all_param_names %in% params)
    to_search <- if (length(sel)) 
      all_param_names[-sel] else all_param_names
    if (!length(regex_pattern)) 
      return(params)
    
    to_add <- grep(regex_pattern, to_search, value = TRUE)
    if (!length(to_add)) 
      params 
    else 
      c(params, to_add)
  }
  
  # update with groups
  .update_params_with_groups <- function(params, all_param_names) {
    as_group <- grep("_as_shinystan_group", params)
    if (!length(as_group)) 
      return(params)
    make_group <- function(group_name) {
      all_param_names[grep(paste0("^",group_name,"\\["), all_param_names)]
    }
    single_params <- params[-as_group]
    grouped_params <- params[as_group]
    groups <- gsub("_as_shinystan_group", "", grouped_params)
    groups <- sapply(groups, make_group)
    c(single_params, unlist(groups))
  }
  
  output_list <- list(
    .param_list = .param_list,
    .param_list_with_groups = .param_list_with_groups,
    toc_entries = toc_entries,
    .update_params_with_groups = .update_params_with_groups
  )
  return(output_list)
}