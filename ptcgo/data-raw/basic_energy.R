basic_energy <- c("Water", "Electric", "Grass", "Metal", "Dark",
                  "Fire", "Ground", "Fairy", "Psychic")
basic_energy <- sort(basic_energy)
devtools::use_data(basic_energy, overwrite = T)
