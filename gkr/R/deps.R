#' get the dependencies from a description file string
#' @param desc_text text string of the description file
#' @details
#' desc_query$data$repository$object$text
#' @return list with description obj and deps dataframe
#' @export
pkg_deps <- function(desc_text) {
  dsc <- withr::with_dir(tempdir(), withr::with_tempfile("DESCRIPTION", {
    cat(desc_text,file =  "DESCRIPTION")
    desc::description$new()
  }))
  return(list(description = dsc, deps = dsc$get_deps()))
}

#' provide a new description
#' @param dep_desc description dep list
#' @param pkgs list of packages that have changed and their version
#' @details
#' dep_desc should contain two named elements deps and description
#' currently comes from pkg_deps
#'
#' pkgs should be a list that contains pkg = version elements
#' @examples \dontrun{
#' new_desc(dep_desc, list(dplyr = "0.8.0"))
#' }
#' @export
new_desc <- function(dep_desc, pkgs) {
    for (pkg in names(pkgs)) {
      if (is.null(pkg)) {
        stop("all pkgs must be named")
      }
      dep_desc$deps <- dep_desc$deps %>%
        mutate(version = ifelse(package == pkg,
                          sprintf(">= %s", pkgs[[pkg]]), version)
               )
    }
  # set_deps must be a data frame with type package version, aka
  # the same format returned from get_deps
  dep_desc$description$set_deps(dep_desc$deps)
  return(fansi::strip_ctl(dep_desc$description$str(), ctl = c("c0", "csi", "sgr")))
}
