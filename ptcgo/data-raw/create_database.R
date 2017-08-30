library(sqldf)

file.remove("data-raw/db.sqlite")
db <- DBI::dbConnect(RSQLite::SQLite(), dbname="data-raw/db.sqlite")

dat <- read.csv("data-raw/database/card_db.csv")

#remove rows with NA
idx <- which(apply(dat, 1, function(x){
  ifelse(any(is.na(x)), FALSE, TRUE)
}))
dat <- dat[idx,]

DBI::dbWriteTable(conn = db, name = "card", value = dat, row.names = FALSE)

#DBI::dbListTables(db)
#DBI::dbListFields(db, "card")
#DBI::dbReadTable(db, "card")

DBI::dbDisconnect(db)
