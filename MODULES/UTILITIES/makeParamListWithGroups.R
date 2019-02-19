makeParamListWithGroupsUI <- function(id){
  ns <- NS(id)
  
}

makeParamListWithGroups <- function(input, output, session, sso){
  
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

return(.param_list_with_groups)
  
}

