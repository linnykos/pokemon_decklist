.grab_icon <- function(type, basic = F){
  eval(parse(text = paste0("ptcgo::", type)))
}

.grab_set <- function(set, dampener = 1){
  img <- png::readPNG(paste0("../images/sets/", set, ".png"))
  dim_vec <- dim(img)

  idx <- which(img[,,dim_vec[3]] == 0)
  for(i in 1:(dim_vec[3]-1)){
    img[,,i][idx] <- 1
  }

  img[,,1] <- 1-img[,,1] #flip for convience
  max_val <- max(img[,,1])
  img[,,1] <- img[,,1]/max_val
  img[,,1] <- 1-img[,,1]

  #handle if img is only black-and-white
  if(dim(img)[3] == 2){
    img2 <- array(NA, c(dim(img)[1], dim(img)[2], 4))
    for(i in 1:3){
      img2[,,i] <- img[,,1]
    }
    img <- img2
  } else {
    for(i in 2:(dim_vec[3]-1)){
      img[,,i] <- img[,,1]
    }
  }

  #adjust the transparency
  img[,,4] <- (1-img[,,1])*dampener

  img
}
