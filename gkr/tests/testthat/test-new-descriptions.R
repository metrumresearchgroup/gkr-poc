context("test-new-descriptions")

describe("new description can be created", {
  desc_text <- read_test_file("DESCRIPTION_logrrr")
  it("can replace a single package", {
    dep_desc <- pkg_deps(desc_text)
    expected <- structure(list(type = c("Imports", "Imports", "Imports", "Imports",
                                        "Suggests", "Suggests", "Suggests", "Suggests"), package = c("R6",
                                                                                                     "crayon", "glue", "rlang", "testthat", "jsonlite", "covr", "sessioninfo"
                                        ), version = c("*", "*", ">= 1.3.0", ">= 0.2.1", "*", "*", "*",
                                                       "*")), row.names = c(NA, -8L), class = "data.frame")
    expect_equal(dep_desc$deps, expected)
  })
})
