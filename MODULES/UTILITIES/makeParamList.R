makeParamListUI <- function(id){
  ns <- NS(id)
  
        selectizeInput(
          inputId = ns("diagnostic_param"),
          label = NULL,
          multiple = FALSE,
          choices = ns(.param_list),
          selected = ns(.param_list)[1]
        )
  
}

makeParamList <- function(input, output, session, sso){
  
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

return(.param_list)
  
}

