.grab_icon <- function(type, basic = F){
  if(!basic){
    eval(parse(text = paste0("ptcgo::", type)))
  } else {
    ptcgo::Basicenergy
  }
}

.grab_set <- function(set, dampener = 4/5){
  img <- png::readPNG(paste0("../images/sets/", set, ".png"))
  dim_vec <- dim(img)

  idx <- which(img[,,dim_vec[3]] == 0)
  for(i in 1:(dim_vec[3]-1)){
    img[,,i][idx] <- 1
  }

  #handle if img is only black-and-white
  if(dim(img)[3] == 2){
    img2 <- array(NA, c(dim(img)[1], dim(img)[2], 4))
    for(i in 1:3){
      img2[,,i] <- img[,,1]
    }
    img <- img2
  }

  #adjust the transparency
  img[,,4] <- (1-img[,,1])*dampener

  img
}
