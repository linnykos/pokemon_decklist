identifyPch <- function(x, y, n = 1){
  xy <- xy.coords(x, y); x <- xy$x; y <- xy$y

  ans <- identify(x, y, n = 1, plot = FALSE)
  graphics::points(x[ans], y[ans], pch = 21, col = "red", cex = 2)

  Sys.sleep(0.5)
  c(x[ans], y[ans])
}

dat <- read.csv("data-raw/database/card_db.csv")

#find all the images without coordinates
idx <- which(is.na(dat$X_right))
func <- .file_parser()

for(i in 1:length(idx)){
  id <- dat$Card_ID[idx[i]]
  mat <- png::readPNG(func(id))
  .plot_tester(mat)
  h <- dim(mat)[1]; w <- dim(mat)[2]
  x <- rep(1:w, each = h); y <- rep(1:h, times = w)
  ans <- identifyPch(x,y)

  #flip y-axis
  ans[2] <- h-ans[2]

  dat[i,c("X_right", "Y_center")] <- ans
  print(paste0(i, " of ", length(idx), ": ", ans[1], ", ", ans[2]))
}

write.csv(dat, file = "data-raw/database/card_db.csv", row.names = F)
