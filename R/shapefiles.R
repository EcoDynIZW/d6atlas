

water_01 <- sf::read_sf("data-raw/01_water_line.shp")
water_01 <- water_01[,c(1,7,8,21,22)]

water_02 <- sf::read_sf("data-raw/02_water_still.shp")
water_02 <- water_02[,c(1,7,8,21,22)]

ruderal_03 <- sf::read_sf("data-raw/03_ruderal.shp")
ruderal_03 <- ruderal_03[,c(1,7,8,21,22)]

swamp_04 <- sf::read_sf("data-raw/04_swamp.shp")
swamp_04 <- swamp_04[,c(1,7,8,21,22)]

grassland_05 <- sf::read_sf("data-raw/05_grassland.shp")
grassland_05 <- grassland_05[,c(1,7,8,21,22)]

# category 06 (= small bush land) not existing in study area

bushland_07 <- sf::read_sf("data-raw/07_bushland.shp")
bushland_07 <- bushland_07[,c(1,7,8,21,22)]

forest_08 <- sf::read_sf("data-raw/08_forest.shp")
forest_08 <- forest_08[,c(1,7,8,21,22)]

agriculture_09 <- sf::read_sf("data-raw/09_agriculture.shp")
agriculture_09 <- agriculture_09[,c(1,7,8,21,22)]

garden_graveyard_10 <- sf::read_sf("data-raw/10_garden_graveyard.shp")
garden_graveyard_10 <- garden_graveyard_10[,c(1,7,8,21,22)]

# category 11 (= special biotope) not existing in study area

built_up_12 <- sf::read_sf("data-raw/12_built.shp")
built_up_12 <- built_up_12[,c(1,7,8,21,22)]



usethis::use_data(water_01,
                  water_02,
                  ruderal_03,
                  swamp_04,
                  grassland_05,
                  bushland_07,
                  forest_08,
                  agriculture_09,
                  garden_graveyard_10,
                  built_up_12,
                  overwrite = T)

