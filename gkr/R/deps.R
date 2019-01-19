#' get the dependencies from a description file string
#' @param desc_text text string of the description file
#' @details
#' desc_query$data$repository$object$text
#' @export
pkg_deps <- function(desc_text) {
  dsc <- withr::with_dir(tempdir(), withr::with_tempfile("DESCRIPTION", {
    cat(desc_text,file =  "DESCRIPTION")
    desc::description$new()
  }))
  return(dsc$get_deps())
}
