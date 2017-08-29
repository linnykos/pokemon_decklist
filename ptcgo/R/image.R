.image_row_extraction <- function(file, x = NA, y = NA){
  mat <- png::readPNG(file)
  .extract_base(mat, x, y) ## MODIFY
}

.extract_base <- function(mat, hc = 85){
  h <- dim(mat)[1]; w <- dim(mat)[2]
  cen <- h/2; top <- cen-hc/2; bot <- cen+hc/2
  mat[top:bot,1:w,]
}

.plot_tester <- function(mat, ...){
  h <- dim(mat)[1]; w <- dim(mat)[2]
  graphics::plot(NA, xlim = c(0, w), ylim = c(0, h), asp = T, ...)
  graphics::rasterImage(mat, 0, 0, w, h)
}



