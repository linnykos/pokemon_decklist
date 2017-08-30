library(sqldf)

file.remove("data-raw/db.sqlite")
db <- DBI::dbConnect(RSQLite::SQLite(), dbname="data-raw/db.sqlite")

dat <- read.csv("data-raw/database/card_db.csv")

#remove rows with NA
idx <- which(apply(dat, 1, function(x){
  ifelse(any(is.na(x)), FALSE, TRUE)
}))
dat <- dat[idx,]

#check the contents
vec <- dat$Type
card_types <- ptcgo::card_types
if(!all(vec %in% card_types)){
  stop(paste0("Found the following invalid symbols in the csv: ",
              paste0(unique(vec[!(vec %in% card_types)]))))
}

DBI::dbWriteTable(conn = db, name = "card", value = dat, row.names = FALSE)

#DBI::dbListTables(db)
#DBI::dbListFields(db, "card")
#DBI::dbReadTable(db, "card")

DBI::dbDisconnect(db)
