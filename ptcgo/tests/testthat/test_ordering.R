context("Test ordering")

## .ordering_trainer is correct

test_that(".ordering_trainer works", {
  deck_file = "../assets/greninja.txt"
  txt <- .file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]
  txt_mat <- t(sapply(txt, .line_parser)); n <- nrow(txt_mat)
  txt_mat <- .format_information(txt_mat, db_path = "../../data-raw/db.sqlite")

  idx <- which(txt_mat$Type %in% c("Item", "Stadium", "Supporter"))
  txt_mat <- txt_mat[idx,]
  res <- .ordering_trainer(txt_mat)

  expect_true(all(dim(res) == dim(txt_mat)))

  idx1 <- which(res$Type == "Supporter")
  idx2 <- which(res$Type == "Item")
  idx3 <- which(res$Type == "Stadium")
  expect_true(max(idx1) <= min(idx2))
  expect_true(max(idx2) <= min(idx3))

  expect_true(all(res$name[idx1] == sort(res$name[idx1])))
  expect_true(all(res$name[idx2] == sort(res$name[idx2])))
  expect_true(all(res$name[idx3] == sort(res$name[idx3])))
})
