file_reader <- function(deck_file){
  con <- file(deck_file, "r")
  txt <- vector("list", 1)
  i <- 1

  while (TRUE) {
    txt[[i]] <- suppressWarnings(readLines(con, n = 1))
    if (length(txt[[i]]) == 0 ) {break}
    i <- i+1
  }

  close(con)

  txt
}

line_parser <- function(line){
  str <- unlist(strsplit(line, " "))
  len <- length(str)
  num <- str[2]; set <- str[len-1]
  name <- paste0(str[3:(len-2)], collapse = " ")
  id <- paste0(str[3:len], collapse = "")

  list(num = num, name = name, id = id, set = set)
}
