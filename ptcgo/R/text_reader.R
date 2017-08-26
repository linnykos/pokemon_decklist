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
  num <- str[2]

  if(nchar(str[len-1]) == 3){
    set <- str[len-1]
    name <- paste0(str[3:(len-2)], collapse = " ")
    id <- paste0(str[3:len], collapse = "")
  } else {
    set <- NA
    name <- paste0(str[3:(len-1)], collapse = " ")
    id <- paste0(str[3:(len-1)], collapse = "")
  }


  list(num = num, name = name, id = id, set = set)
}

.string_shortner <- function(str, lim = 15){
  len <- nchar(str)
  if(len > lim){
    str <- paste0(substring(str, 1, 15), "...")
  }
  str
}
