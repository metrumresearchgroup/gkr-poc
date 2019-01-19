library(gh)

#' Creates a branch via the GitHub API.
#' @param user The user under whom the branch will be created.
#' @param repository The repository the branch will be created in.
#' @param branch_name The name of the branch.
#' @param sha The SHA of the master branch for the indicated repository.
#' @details
#' This function is set up to always branch off of master. This is controlled via the "ref_arg" string that is
#' passed into the "ref" argument in "gh".
make_branch <- function(
  user,
  repository,
  branch_name,
  sha
) {
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

#' Updates the DESCRIPTION file in the indicated repository and commits the change to a desired branch.
#' @param repository_owner The GitHub username of the repository's owner (or the Orginzation name, when applicable")
#' @param repository The repository for which the DESCRIPTION file should be updated.
#' @param b64_content The updated contents of the DESCRIPTION file, encoded in base64.
#' @param file_sha The GitHub SHA of the DESCRIPTION file.
#' @param branch The name of the branch for which you want the DESCRIPTION file updated.
#' @details
#' This function hard-codes a standard commit message and pushes the change to the indicated branch.
#' This function assumes that your DESCRIPTION file is in the project's root directory.
update_description_file <- function(
  repository_owner,
  repository,
  b64_content,
  file_sha,
  branch
) {
  endpoint <- "PUT /repos/:owner/:repo/contents/:path"
  gh(
    endpoint,
    owner = repository_owner,
    repo = repository,
    path = 'DESCRIPTION',
    message = "NOMERGE: Dependency update for CRAN packages",
    content = b64_content,
    sha = file_sha,
    branch = branch
  )
}

#' Creates a pull request in the given repository for the indicated branches.
#' @param repository_owner The GitHub username of the repository's owner (or the Orginzation name, when applicable")
#' @param repository The repository for which the DESCRIPTION file should be updated.
#' @param head_branch The branch containing your updated DESCRIPTION file.
#' @param base_branch The base branch.
#' @details
#' This function has hard-coded values for the title and description of the pull request. Both of these values reflect
#' the changed dependencies, which would be reflected in an updated DESCRIPTION file.
create_pull_request <- function(
  repository_owner,
  repository,
  head_branch,
  base_branch = "master"
) {
  endpoint <- "POST /repos/:owner/:repo/pulls"
  gh(
    endpoint,
    owner = repository_owner,
    repo = repository,
    title = "NOMERGE: Dependencies updated.",
    head = head_branch,
    base = base_branch,
    body = "Dependencies for this package have been updated. Please confirm that your package still builds properly."
  )
}
