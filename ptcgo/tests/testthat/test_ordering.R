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

#######

## .order_number_name is correct

test_that(".order_number_name", {
  txt_mat <- data.frame(num = c(2,8,10,8),
                        name = c("Water Energy", "Grass Energy",
                      "Dark Energy", "Electric Energy"))
  res <- .order_number_name(txt_mat)

  expect_true(all(res[,1] == c(10, 8, 8, 2)))
  expect_true(all(res[,2] == c("Dark Energy", "Electric Energy", "Grass Energy",
                               "Water Energy")))
})

#######

## .ordering_energy is correct

test_that(".ordering_energy works", {
  deck_file = "../assets/greninja.txt"
  txt <- .file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]
  txt_mat <- t(sapply(txt, .line_parser)); n <- nrow(txt_mat)
  txt_mat <- .format_information(txt_mat, db_path = "../../data-raw/db.sqlite")

  idx <- which(txt_mat$Type == "Energy")
  txt_mat <- txt_mat[idx,]
  res <- .ordering_energy(txt_mat)

  expect_true(all(dim(res) == dim(txt_mat)))
  expect_true(all(res$num == c(3,10)))
  expect_true(all(res$name == c("Splash Energy", "Water Energy")))
})
