library(gh)

make_branch <- function(user, repository, branch_name, sha) {
  endpoint <- "POST /repos/:user/:repo/git/refs"
  ref_arg <- paste("refs", "heads", branch_name, sep = "/")
  sha <-
  gh(
    endpoint,
    user = user,
    repo = repository,
    ref = ref_arg,
    sha = sha
  )
}
