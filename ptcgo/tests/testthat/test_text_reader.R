context("Test text_reader")

## .line_parser is correct

test_that(".line_parser works", {
  str <- "* 4 Froakie BKP 38"
  res <- .line_parser(str)

  expect_true(length(res) == 4)
  expect_true(all(sort(names(res)) == sort(c("num", "name", "id", "set"))))
  expect_true(res$num == 4)
  expect_true(res$name == "Froakie")
  expect_true(res$id == "FroakieBKP38")
  expect_true(res$set == "BKP")
})

test_that(".line_parser handles special characters and non-3 letter set", {
  str <- "* 2 Professor's Letter XY 123"
  res <- .line_parser(str)

  expect_true(res$name == "Professor's Letter")
  expect_true(res$set == "XY")
  expect_true(res$id == "ProfessorsLetterXY123")
})

test_that(".line_parser can handle unlabeled energys", {
  str <- "* 10 Water Energy  3"
  res <- .line_parser(str)

  expect_true(res$name == "Water Energy")
})
