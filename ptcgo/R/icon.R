.grab_icon <- function(type, basic = F){
  if(!basic){
    eval(parse(text = paste0("ptcgo::", type)))
  } else {
    ptcgo::Basicenergy
  }
}

.grab_set <- function(set){

}
