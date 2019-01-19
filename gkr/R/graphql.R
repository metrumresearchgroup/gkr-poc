#' read schema
#' @param schema name
#' @export
read_schema <- function(schema) {
  file <- system.file(sprintf("graphql/%s.graphql", schema), package = "gkr")
  query <- readChar(file, file.info(file)$size)
  return(query)
}

#' make a graphql query to github
#' @param .q query
#' @param ... variables to pass to the query
#' @importFrom purrr compact
#' @export
ghql_query <- function(.q, ..., .token = Sys.getenv("GITHUB_PAT")) {
  gh::gh("POST /graphql", query = .q, variables = purrr::compact(list(...)), .token = .token)
}
