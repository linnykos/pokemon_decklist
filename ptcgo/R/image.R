image_row_extraction <- function(file, extraction_method = .extract_base){
  mat <- png::readPNG(file)
  extraction_method(mat)
}

.extract_base <- function(mat, ratio = 245/33){
  h <- dim(mat)[1]; w <- dim(mat)[2]
  hc <- w/ratio
  cen <- h/2; top <- cen-hc/2; bot <- cen+hc/2
  mat[top:bot,1:w,]
}

.plot_image <- function(mat){
  h <- dim(mat)[1]; w <- dim(mat)[2]
  graphics::plot(NA, xlim = c(0, w), ylim = c(0, h), asp = T)
  graphics::rasterImage(mat, 0, 0, w, h)
}
