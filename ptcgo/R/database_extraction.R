.format_information <- function(txt_mat){
  txt_mat[,1] <- as.numeric(txt_mat[,1])

  db <- DBI::dbConnect(RSQLite::SQLite(), dbname="data-raw/db.sqlite")

  addition_mat <- sapply(1:nrow(txt_mat), function(x){
    id <- txt_mat[x, "id"]
    DBI::dbGetQuery(db, paste0("SELECT Type, X_right, Y_center FROM card",
                               " WHERE Card_ID == '", id, "'"))
  })

  cbind(txt_mat, t(addition_mat))
}
