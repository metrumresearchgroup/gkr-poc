context("test-new-descriptions")

describe("new description can be created", {
  desc_text <- read_test_file("DESCRIPTION_logrrr")
  it("can replace a single package", {
    dep_desc <- pkg_deps(desc_text)
    expect_equal(dep_desc$deps$package, c("R6", "crayon", "glue", "rlang", "testthat", "jsonlite", "covr",
                                          "sessioninfo"))
  })
})
