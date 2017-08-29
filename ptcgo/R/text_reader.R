.file_reader <- function(deck_file){
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

.line_parser <- function(line){
  str <- unlist(strsplit(line, " "))
  len <- length(str)
  num <- str[2]

  if((nchar(str[len-1]) == 3 | nchar(str[len-1] == 2)) &
     grepl("[[:alpha:]]", str[len-1]) & toupper(str[len-1]) == str[len-1]){
    set <- str[len-1]
    name <- paste0(str[3:(len-2)], collapse = " ")
    id <- paste0(str[3:len], collapse = "")
  } else {
    set <- NA
    name <- paste0(str[3:(len-1)], collapse = " ")
    id <- paste0(str[3:(len-1)], collapse = "")
  }

  id <- gsub("[[:punct:]]","",id)

  list(num = as.numeric(num), name = name, id = id, set = set)
}

#determines the appropriate cex for string
.string_shortner <- function(str, base = 170, min_ratio = 0.75){
  len <- graphics::strwidth(str)
  ifelse(len <= base, 1, max(base/len, min_ratio))
}
