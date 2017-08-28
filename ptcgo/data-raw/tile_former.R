tile <- png::readPNG("data-raw/single.png")
.plot_image(tile, xaxt = "n", yaxt = "n", ann = F, bty = "n")
devtools::use_data(tile, overwrite = T)

tile_edge <- png::readPNG("data-raw/single_edge.png")
.plot_image(tile_edge, xaxt = "n", yaxt = "n", ann = F, bty = "n")
devtools::use_data(tile_edge, overwrite = T)

tile_edge2 <- png::readPNG("data-raw/single_edge2.png")
.plot_image(tile_edge2, xaxt = "n", yaxt = "n", ann = F, bty = "n")
devtools::use_data(tile_edge2, overwrite = T)
