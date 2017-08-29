library(sqldf)

file.remove("data-raw/db.sqlite")
db <- DBI::dbConnect(RSQLite::SQLite(), dbname="data-raw/db.sqlite")

dat <- read.csv("data-raw/database/card_db.csv")
DBI::dbWriteTable(conn = db, name = "card", value = dat, row.names = FALSE)

#DBI::dbListTables(db)
#DBI::dbListFields(db, "card")
#DBI::dbReadTable(db, "card")

DBI::dbDisconnect(db)
