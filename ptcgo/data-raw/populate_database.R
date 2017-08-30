dat <- read.csv("data-raw/database/card_db.csv")

#list all files
vec <- list.files("../images/cards/")
vec <- sapply(vec, function(x){
  strsplit(x, ".png")[[1]][1]
})
names(vec) <- NULL

#create new csv file
dat2 <- data.frame(Card_ID = vec, Type = NA, X_right = NA, Y_center = NA)

#find rows already in original csv
dat <- dat[order(dat$Card_ID),]
idx <- which(dat$Card_ID %in% dat2$Card_ID)
idx2 <- which(dat2$Card_ID %in% dat$Card_ID)
dat2[idx2,] <- dat[idx,]

dat <- dat2
write.csv(dat, file = "data-raw/database/card_db.csv", row.names = F)
