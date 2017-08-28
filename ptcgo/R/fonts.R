font_setup <- function(font_name = "Bevan", id_name = "bevan"){
  current_vec <- sysfonts::font.families()
  if(id_name %in% current_vec){
    message("Font id_name already in sysfonts::font.families()")
    return(id_name)
  }

  tryCatch({
    sysfonts::font.add.google(font_name, id_name)
  }, error = function(e){
    warning("No internet connection, trying to download font locally into R")
    vec <- sysfonts::font.files()
    idx <- grep(font_name, vec)
    if(length(idx) == 0) stop("Font was not found locally")
    sysfonts::font.add(id_name, vec[idx[1]])
  })

  id_name
}


