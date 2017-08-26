decklist <- function(deck_file, filename){
  txt <- file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]

  txt_mat <- sapply(txt, line_parser); n <- ncol(txt_mat)
  img_size <- .calculate_image_size(txt_mat)
  nh <- img_size$h; w <- img_size$w; h <- nh/n

  grDevices::png(filename, 400, nh*400/w, units = "px")
  graphics::par(mar = rep(0,4))
  graphics::plot(NA, xlim = c(0, w), ylim = c(0, nh), asp = T,
                 xaxt = "n", yaxt = "n", ann = F, bty = "n")

  for(i in 1:n){
    func <- .file_parser()
    img <- image_row_extraction(func(txt_mat[3,i]))
    img_cropped <- .extract_base(img)
    graphics::rasterImage(img_cropped, 0, (n-i)*h, w, (n-i+1)*h)

    TeachingDemos::shadowtext(0, (n-i+.5)*h, txt_mat[2,i], pos = 4, cex = 2.5, r = 0.1)
    TeachingDemos::shadowtext(w, (n-i+.5)*h, txt_mat[1,i], pos = 2, cex = 2.5, r = 0.1)
  }

  grDevices::graphics.off()
}

.calculate_image_size <- function(txt_mat){
  n <- ncol(txt_mat)

  func <- .file_parser()
  img <- image_row_extraction(func(txt_mat[3,1]))
  img_cropped <- .extract_base(img)

  h <- dim(img_cropped)[1]; w <- dim(img_cropped)[2]
  list(h = n*h, w = w)
}

.file_parser <- function(prefix = "../cards/", suffix = ".png"){
  function(id){
    paste0(prefix, id, suffix)
  }
}
