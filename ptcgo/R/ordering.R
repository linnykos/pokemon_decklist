.ordering <- function(txt_mat){
  n <- nrow(txt_mat)
  idx1 <- which(txt_mat$Type %in% c("Item", "Stadium", "Supporter"))
  idx2 <- which(txt_mat$Type == "Energy")
  idx3 <- c(1:n)[-c(idx1, idx2)]

  txt_mat[idx1,] <- .ordering_trainer(txt_mat[idx1,])
  txt_mat[idx2,] <- .ordering_energy(txt_mat[idx2,])

  txt_mat
}

.ordering_trainer <- function(txt_mat){
  n <- nrow(txt_mat)
  idx1 <- which(txt_mat$Type == "Item")
  idx2 <- which(txt_mat$Type == "Supporter")
  idx3 <- c(1:n)[-c(idx1, idx2)]

  txt_mat[idx1,] <- txt_mat[idx1[order(txt_mat$name[idx1])],]
  txt_mat[idx2,] <- txt_mat[idx2[order(txt_mat$name[idx2])],]
  txt_mat[idx3,] <- txt_mat[idx3[order(txt_mat$name[idx3])],]

  txt_mat[c(sort(idx2), sort(idx1), sort(idx3)),]
}

.ordering_energy <- function(txt_mat){
  n <- nrow(txt_mat)
  basic_energy <- ptcgo::basic_energy

  idx1 <- unlist(sapply(basic_energy, function(x){grep(x, txt_mat$name)}))
  idx2 <- c(1:n)[-idx1]

  if(length(idx1) > 0) txt_mat[idx1,] <- .order_number_name(txt_mat[idx1,])
  if(length(idx2) > 0) txt_mat[idx2,] <- .order_number_name(txt_mat[idx2,])

  txt_mat[c(sort(idx2), sort(idx1)),]
}

.order_number_name <- function(txt_mat){
  txt_mat <- txt_mat[order(txt_mat$num, decreasing = T),]

  val <- sort(unique(txt_mat$num))
  for(i in val){
    idx <- which(txt_mat$num == i)
    if(length(idx) == 1) next()
    txt_mat[idx,] <- txt_mat[idx[order(txt_mat$name[idx])],]
  }

  txt_mat
}
