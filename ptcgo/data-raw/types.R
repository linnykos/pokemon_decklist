card_types <- c("Water", "Electric", "Grass", "Metal", "Dark",
                "Fire", "Ground", "Fairy", "Psychic", "Dragon",
                "Item", "Supporter", "Stadium", "Energy",
                "Normal")
card_types <- sort(card_types)
devtools::use_data(card_types, overwrite = T)
