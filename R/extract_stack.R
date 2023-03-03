#' @title get a dataframe with the extracted values from the atlas_stack
#' @description add extracted values from atlas_stack (landuse, distance to settlements, distance to kettleholes, distance to rivers, distance to streets, distance to waterbodies) to the starling_2547 dataframe or to another one
#' @param sf_point a sf point with extent of atlas_stack.
#' @return a af object with extracted values
#' @export
#' @examples
#' \dontrun{
#' d6atlas::extract_stack(sf_point = sf_point)
#'  }


extract_stack <- function(sf_point){

  stopifnot("sf_point must be an sf point object"= all(sf::st_geometry_type(sf_point) %in% c("POINT", "MULTIPOINT")))

  atlas_stack <- d6atlas::atlas_stack()
  crs_sf_point <- sf::st_crs(sf_point)

  message("crs was changed to EPSG 3035 for extracting")

  sf_point <- sf_point %>%
    sf::st_transform(sf::st_crs(atlas_stack))

  sf_point <- dplyr::bind_cols(sf_point, terra::extract(atlas_stack, sf_point, ID = FALSE))

  sf_point <- sf_point %>%
    sf::st_transform(crs_sf_point)

  sf_point <- sf_point %>%
    dplyr::left_join(y = landuse_reclass_table %>%
                       dplyr::rename("landuse" = BIOTYP8) %>%
                       mutate(landuse = as.numeric(landuse)), by = "landuse")


  message("crs was changed back to given projection")

  return(sf_point)

}





