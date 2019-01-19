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

# PUT /repos/:owner/:repo/contents/:path
update_description_file <- function(
  repository_owner,
  repository,
  path = './DESCRIPTION',
  commit_message,
  b64_content,
  file_sha,
  branch
  ) {
  endpoint = "PUT /repos/:owner/:repo/contents/:path"
  gh(
    endpoint,
    owner = repository_owner,
    repo = repository,
    path = path,
    message = commit_message,
    content = b64_content,
    sha = file_sha,
    branch = branch
  )
}
