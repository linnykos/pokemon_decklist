decklist <- function(deck_file, filename){
  txt <- file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]

  txt_mat <- t(sapply(txt, line_parser)); n <- nrow(txt_mat)
  txt_mat[,1] <- as.numeric(txt_mat[,1])

  tile <- ptcgo::tile; th <- dim(tile)[1]; tw <- dim(tile)[2]
  nh <- th*nrow(txt_mat)
  res <- .calculate_image_size(txt_mat); h <- res$h; w <- res$w
  tile_edge <- ptcgo::tile_edge; teh <- dim(tile_edge)[1]; tew <- dim(tile_edge)[2]

  #set up plotting
  grDevices::png(filename, 400, nh*400/tw, units = "px")
  graphics::par(mar = rep(0,4))
  graphics::plot(NA, xlim = c(0, tw), ylim = c(0, nh), asp = T,
                 xaxt = "n", yaxt = "n", ann = F, bty = "n")

  col_vec <- c(17, 114, 49)
  pkmn_col <- rgb(col_vec[1], col_vec[2], col_vec[3], max = 255)
  pkmn_colgradient <- grDevices::colorRampPalette(c(pkmn_col,
                                                 rgb(col_vec[1], col_vec[2],
                                                     col_vec[3], 0, max = 255)),
                                               alpha = T)(100)

  #set up fonts
  font_id <- font_setup()
  showtext::showtext.begin()

  #enter all the pkmn cards
  for(i in 1:n){
    #add tile
    graphics::rasterImage(tile, 0, (n-i)*th, tw, (n-i+1)*th)

    #add pkmn image; check the number of copies
    func <- .file_parser()
    img <- image_row_extraction(func(txt_mat[i,3]))
    img_cropped <- .extract_base(img)
    if(txt_mat[i,1] != 1){
      graphics::rasterImage(img_cropped, 170, (n-i)*th+35-6, 170+w, (n-i)*th+35+h)
    } else {
      graphics::rasterImage(img_cropped, 170+85, (n-i)*th+35-6, 170+w+85, (n-i)*th+35+h)
    }

    #add gradient
    graphics::rect(153, (n-i)*th+35-10, 153+.35*w, (n-i)*th+35+h+2, col = pkmn_col,
                   border = NA)
    gradient_rectangle(153+.35*w, (n-i)*th+35-10, 153+.5*w, (n-i)*th+35+h+2, pkmn_colgradient)

    #add edge
    if(txt_mat[i,1] != 1){
      graphics::rasterImage(tile_edge, 771, (n-i)*th+24-1, 771+tew+3, (n-i)*th+24+teh-1)
    } else {

    }

    #add name
    cex <- .string_shortner(txt_mat[i,2], base = 170)*1.75
    shadowtext(155, (n-i)*th+30+h/2, txt_mat[i,2],
               pos = 4, cex = cex, r = 0.5, family = font_id)

    #add num
    if(txt_mat[i,1] != 1){
      cex <- .string_shortner(txt_mat[i,1], base = 16.29, min = 0.55)*3
      shadowtext(885, (n-i)*th+25+h/2, txt_mat[i,1], col = "gold",
                                pos = 2, cex = cex, r = 0.5, family = font_id)
    }
  }
  showtext::showtext.end()

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
