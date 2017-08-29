.gradient_rectangle <- function(xleft, ybottom, xright, ytop, color_seq){
  n <- length(color_seq)
  seq_vec <- seq(xleft, xright, length.out = n+1)
  sapply(1:(length(seq_vec)-1), function(x){
    graphics::rect(seq_vec[x], ybottom, seq_vec[x+1], ytop, col = color_seq[x],
                   border = NA)
  })

  invisible()
}
