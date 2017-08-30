vec <- list.files("data-raw/images", full.names = TRUE)
idx <- grep(".*Type.*.png", vec)
vec <- vec[idx]

for(i in vec){
  str <- strsplit(i, "(Type_)|(.png)")[[1]][2]
  eval(parse(text = paste0(str, " <-  png::readPNG(i)")))
  eval(parse(text = paste0("devtools::use_data(", str, ", overwrite = T)")))
}
