#' read schema
#' @param schema name
#' @export
read_schema <- function(schema) {
  file <- system.file(sprintf("graphql/%s.graphql", schema), package = "pkgsync")
  query <- readChar(file, file.info(file)$size)
  return(query)
}

#' make a graphql query to github
#' @param .q query
#' @param ... variables to pass to the query
#' @importFrom purrr compact
#' @export
ghql_query <- function(.q, ...) {
  gh::gh("POST /graphql", query = .q, variables = compact(list(...)))
}
