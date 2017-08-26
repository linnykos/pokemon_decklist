tile <- png::readPNG("data-raw/single.png")
.plot_image(tile, xaxt = "n", yaxt = "n", ann = F, bty = "n")
devtools::use_data(tile, overwrite = T)
