
library("sf")

water_01 <- read_sf("data-raw/01_water_line.shp")
water_02 <- read_sf("data-raw/02_water_still.shp")
ruderal_03 <- read_sf("data-raw/03_ruderal.shp")
swamp_04 <- read_sf("data-raw/04_swamp.shp")
grassland_05 <- read_sf("data-raw/05_grassland.shp")
# category 06 (= small bush land) not existing in study area
bushland_07 <- read_sf("data-raw/07_bushland.shp")
forest_08 <- read_sf("data-raw/08_forest.shp")
agriculture_09 <- read_sf("data-raw/09_agriculture.shp")
garden_graveyard_10 <- read_sf("data-raw/10_garden_graveyard.shp")
# category 11 (= special biotope) not existing in study area
built_up_12 <- read_sf("data-raw/12_built.shp")


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
                  overwrite = TRUE)
