read_test_file <- function(.f) {
  file <- file.path("testfiles", .f)
  output <- readChar(file, file.info(file)$size)
  return(output)
}
