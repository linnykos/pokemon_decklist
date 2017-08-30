# Example of ggvis scatterplot
# on over - display MGI gene symbol
# on click - open browser with Ensembl page

library(ggvis)

# load dataset
dataset <- read.csv("http://dl.dropboxusercontent.com/u/232839/DO_liver_variability_sex.csv", as.is=TRUE)
head(dataset)

# what to do on hover
on_hover <- function(x) {
  if(is.null(x)) return(NULL)
  mgi_symbol <- dataset$Associated.Gene.Name[x$id]
  mgi_symbol
}

# what to do on click
on_click <- function(x) {
  if(is.null(x)) return(NULL)
  ensid <- dataset$Ensembl.Gene.ID[x$id]
  ensembl_url <- paste0("http://useast.ensembl.org/Mus_musculus/Gene/Summary?db=core;g=", ensid)
  browseURL(ensembl_url)
  NULL
}

# start ggvis
point_size = 100 # if dots are too big/small, adjust this parameter
dataset %>%
  ggvis(~protein.Sex, ~mrna.Sex, key := ~id) %>%
  layer_points(size := point_size) %>%
  add_tooltip(on_hover, "hover") %>%
  add_tooltip(on_click, "click") %>% set_options(width=600, height=600)
