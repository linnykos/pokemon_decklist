.ordering <- function(txt_mat){
  n <- nrow(txt_mat)
  idx1 <- which(txt_mat$Type %in% c("Item", "Stadium", "Supporter"))
  idx2 <- which(txt_mat$Type == "Energy")
  idx3 <- c(1:n)[-c(idx1, idx2)]

  txt_mat[idx1,] <- .ordering_trainer(txt_mat[idx1,])
  txt_mat[idx2,] <- .ordering_trainer(txt_mat[idx2,])

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

}
