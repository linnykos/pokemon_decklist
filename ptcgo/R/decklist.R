decklist <- function(deck_file, filename){
  txt <- file_reader(deck_file)
  txt <- txt[grep("^\\* ", txt)]

  txt_mat <- t(sapply(txt, line_parser)); n <- nrow(txt_mat)
  txt_mat <- .format_information(txt_mat)

  tile <- ptcgo::tile; th <- dim(tile)[1]; tw <- dim(tile)[2]
  nh <- th*nrow(txt_mat)

  #set up plotting
  grDevices::png(filename, 400, nh*400/tw, units = "px")
  graphics::par(mar = rep(0,4))
  graphics::plot(NA, xlim = c(0, tw), ylim = c(0, nh), asp = T,
                 xaxt = "n", yaxt = "n", ann = F, bty = "n")

  res <- .color_setup(17, 114, 49); col <- res$col; col_grad <- res$col_grad

  #set up fonts
  font_id <- font_setup()
  showtext::showtext.begin()

  #enter all the pkmn cards
  for(i in 1:n){
    #add tile
    graphics::rasterImage(tile, 0, (n-i)*th, tw, (n-i+1)*th)

    #add pkmn image; check the number of copies
    .plot_pokemon(txt_mat[i,], n-i, th)

    #add gradient and edge
    .plot_details(txt_mat[i,], col, col_grad, n-i, th)

    #add name and num
    .plot_name_number(txt_mat[i,], n-i, th, font_id)
  }
  showtext::showtext.end()

  grDevices::graphics.off()
}


.plot_pokemon <- function(vec, ni, th){
  func <- .file_parser()
  img <- .image_row_extraction(func(vec$id), vec$X_right+15, vec$Y_center)
  img_cropped <- .extract_base(img)
  h <- dim(img_cropped)[1]; w <- dim(img_cropped)[2]

  if(vec$num != 1){
    graphics::rasterImage(img_cropped, 800-w, ni*th+35-6, 800, ni*th+35+h)
  } else {
    graphics::rasterImage(img_cropped, 885-w, ni*th+35-6, 885, ni*th+35+h)
  }

  invisible()
}

.plot_details <- function(vec, col, col_grad, ni, th, w = 633, h = 85){
  graphics::rect(153, ni*th+35-10, 153+.35*w, ni*th+35+h+2, col = col,
                 border = NA)
  gradient_rectangle(153+.35*w, ni*th+35-10, 153+.5*w, ni*th+35+h+2, col_grad)

  tile_edge <- ptcgo::tile_edge; teh <- dim(tile_edge)[1]; tew <- dim(tile_edge)[2]
  tile_edge2 <- ptcgo::tile_edge2; teh2 <- dim(tile_edge2)[1]; tew2 <- dim(tile_edge2)[2]

  if(vec$num != 1){
    graphics::rasterImage(tile_edge, 771, ni*th+24+.5, 771+tew+3, ni*th+24+teh-1)
  } else {
    graphics::rasterImage(tile_edge2, 849, ni*th+24, 849+tew2, ni*th+24+teh2)
  }

  invisible()
}

.plot_name_number <- function(vec, ni, th, font_id, h = 85){
  cex <- .string_shortner(vec$name, base = 170)*1.75
  shadowtext(155, ni*th+30+h/2, vec$name, pos = 4, cex = cex, r = 0.5,
             family = font_id)

  if(vec$num != 1){
    cex <- .string_shortner(vec$num, base = 16.29, min_ratio = 0.55)*3
    shadowtext(885, ni*th+25+h/2, vec$num, col = "gold",
               pos = 2, cex = cex, r = 0.5, family = font_id)
  }

  invisible()
}

.color_setup <- function(r, g, b, len = 100){
  col <- grDevices::rgb(r, g, b, max = 255)
  col_grad <- grDevices::colorRampPalette(c(col,
                                            grDevices::rgb(r, g, b, 0, max = 255)),
                                          alpha = T)(len)
  list(col = col, col_grad = col_grad)
}

.file_parser <- function(prefix = "../cards/", suffix = ".png"){
  function(id){
    paste0(prefix, id, suffix)
  }
}
