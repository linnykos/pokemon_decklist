decklist <- function(deck_file, filename){
  txt <- file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]

  txt_mat <- t(sapply(txt, line_parser)); n <- nrow(txt_mat)
  txt_mat[,1] <- as.numeric(txt_mat[,1])
  txt_mat[,2] <- sapply(txt_mat[,2], .string_shortner)

  tile <- ptcgo::tile; th <- dim(tile)[1]; tw <- dim(tile)[2]
  nh <- th*nrow(txt_mat)
  res <- .calculate_image_size(txt_mat); h <- res$h; w <- res$w

  #set up plotting
  grDevices::png(filename, 400, nh*400/tw, units = "px")
  graphics::par(mar = rep(0,4))
  graphics::plot(NA, xlim = c(0, tw), ylim = c(0, nh), asp = T,
                 xaxt = "n", yaxt = "n", ann = F, bty = "n")

  pkmn_gray <- rgb(62, 70, 83, max = 255)
  pkmn_gradient <- grDevices::colorRampPalette(c(rgb(62, 70, 83, 255, max = 255),
                                                 rgb(62, 70, 83, 0, max = 255)),
                                               alpha = T)(100)

  #enter all the pkmn cards
  for(i in 1:n){
    #add tile
    graphics::rasterImage(tile, 0, (n-i)*th, tw, (n-i+1)*th)

    #add pkmn image
    func <- .file_parser()
    img <- image_row_extraction(func(txt_mat[i,3]))
    img_cropped <- .extract_base(img)
    graphics::rasterImage(img_cropped, 155, (n-i)*th+35, 155+w, (n-i)*th+35+h)

    #add gradient
    graphics::rect(153, (n-i)*th+35-2, 153+.35*w, (n-i)*th+35+h+2, col = pkmn_gray,
                   border = NA)
    gradient_rectangle(153+.35*w, (n-i)*th+35-2, 153+.5*w, (n-i)*th+35+h+2, pkmn_gradient)

    #add name
    TeachingDemos::shadowtext(155, (n-i)*th+35+h/2, txt_mat[i,2],
                              pos = 4, cex = 2, r = 0.3)

    #add num
    if(txt_mat[i,1] != 1){
      TeachingDemos::shadowtext(880, (n-i)*th+20+h/2, txt_mat[i,1], col = "gold",
                                pos = 2, cex = 3, r = 0.3)
    }
  }

  grDevices::graphics.off()
}


.calculate_image_size <- function(txt_mat){
  func <- .file_parser()
  img <- image_row_extraction(func(txt_mat[1,3]))
  img_cropped <- .extract_base(img)

  h <- dim(img_cropped)[1]; w <- dim(img_cropped)[2]
  list(h = h, w = w)
}

.file_parser <- function(prefix = "../cards/", suffix = ".png"){
  function(id){
    paste0(prefix, id, suffix)
  }
}
