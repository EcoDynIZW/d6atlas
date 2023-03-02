library(dplyr)

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

starling_2547 <- readr::read_csv("data-raw/starling_2547")

lu_ras <-
  terra::rast("./inst/extdata/landuse_atlas_2009_1m_03035.tif") %>% terra::aggregate(fact = 5, fun = "modal")
dist_hs_ras <-
  terra::rast("./inst/extdata/distance-to-human-settlements_atlas_2009_1m_03035.tif") %>% round(digits = 0) %>% terra::aggregate(fact = 5, fun = "mean")
dist_kh_ras <-
  terra::rast("./inst/extdata/distance-to-kettleholes_atlas_2022_1m_03035.tif") %>% terra::aggregate(fact = 5, fun = "mean")
dist_r_ras <-
  terra::rast("./inst/extdata/distance-to-rivers_atlas_2009_1m_03035.tif") %>% terra::aggregate(fact = 5, fun = "mean")
dist_s_ras <-
  terra::rast("./inst/extdata/distance-to-streets_atlas_2022_1m_03035.tif") %>% terra::aggregate(fact = 5, fun = "mean")
dist_w_ras <-
  terra::rast("./inst/extdata/distance-to-waterbodies_atlas_2009_1m_03035.tif") %>% terra::aggregate(fact = 5, fun = "mean")



ras_list <- list(crs = "+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +units=m +no_defs",
                 extent = c(4565438, 4579781, 3362903, 3376728))

landuse <-
  terra::values(lu_ras)[, 1]
dist_human_settlements <-
  terra::values(dist_hs_ras)[, 1] %>% round(digits = 0)
dist_kettleholes <-
  terra::values(dist_kh_ras)[, 1] %>% round(digits = 0)
dist_rivers <-
  terra::values(dist_r_ras)[, 1] %>% round(digits = 0)
dist_streets <-
  terra::values(dist_s_ras)[, 1] %>% round(digits = 0)
dist_water <-
  terra::values(dist_w_ras)[, 1] %>% round(digits = 0)

#saveRDS(ras_list, "./data-raw/ras_list.rds")
#saveRDS(landuse, "./data-raw/landuse.rds")
#saveRDS(dist_human_settlements, "./data-raw/dist_human_settlements.rds")
#saveRDS(dist_kettleholes, "./data-raw/dist_kettleholes.rds")
#saveRDS(dist_rivers, "./data-raw/dist_rivers.rds")
#saveRDS(dist_streets, "./data-raw/dist_streets.rds")

# usethis::use_data(
#   water_01,
#   water_02,
#   ruderal_03,
#   swamp_04,
#   grassland_05,
#   bushland_07,
#   forest_08,
#   agriculture_09,
#   garden_graveyard_10,
#   built_up_12,
#   ras_list,
#   landuse,
#   dist_human_settlements,
#   dist_kettleholes,
#   dist_rivers,
#   dist_streets,
#   dist_water,
#   starling_2547,
#   overwrite = TRUE
# )

