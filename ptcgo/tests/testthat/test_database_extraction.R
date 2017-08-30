context("Test database extraction")

## .list_to_dataframe is correct

test_that(".list_to_dataframe works", {
  deck_file = "../assets/greninja.txt"
  txt <- .file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]
  txt_mat <- t(sapply(txt, .line_parser)); n <- nrow(txt_mat)

  res <- .list_to_dataframe(txt_mat)

  expect_true(all(dim(txt_mat) == dim(res)))
  for(i in 1:ncol(res)){
    expect_true(is.vector(res[,i]))
    expect_true(is.list(txt_mat[,i]))
  }
})
