#code taken from TeachingDemos::shadowtext
shadowtext <- function(x, y=NULL, labels, col='white', bg='black',
         theta= seq(pi/4, 2*pi, length.out=8), r=0.1, ... ) {

  xy <- grDevices::xy.coords(x,y)
  xo <- r*graphics::strwidth('A')
  yo <- r*graphics::strheight('A')

  for (i in theta) {
    graphics::text(xy$x + cos(i)*xo, xy$y + sin(i)*yo, labels, col=bg, ... )
  }

  graphics::text(xy$x, xy$y, labels, col=col, ... )
}
