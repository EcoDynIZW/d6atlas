#' @title get atlas SpatRaster stack
#' @description get SpatRaster stack with environmental layers (landuse, distance to settlements, distance to kettleholes, distance to rivers, distance to streets)
#' @param resolution Numeric: resolution 1 = 5m, 2 = 10m, 4 = 20m
#' @return a SpatRatser stack
#' @export
#' @examples
#' \dontrun{
#' d6atlas::atlas_stack(resolution = 1)
#' d6atlas::atlas_stack(resolution = 4)
#'  }


atlas_stack <- function(resolution = 1) {
  values_list <- list(landuse = d6atlas::landuse,
                      dist_human_settlements = d6atlas::dist_human_settlements,
                      dist_kettleholes = d6atlas::dist_kettleholes,
                      dist_rivers = d6atlas::dist_rivers,
                      dist_streets  = d6atlas::dist_streets,
                      dist_water  = d6atlas::dist_water)

  if (resolution %in% c(1,2,4)) {
    if (resolution == 1) {
      do.call(c,
              lapply(1:length(values_list), function(x) {
                terra::rast(
                  crs = d6atlas::ras_list$crs,
                  extent = d6atlas::ras_list$extent,
                  resolution = 5,
                  vals = values_list[[x]],
                  names = names(values_list)[x]
                )
              }))
    } else{
      c(
        terra::rast(
          crs = d6atlas::ras_list$crs,
          extent = d6atlas::ras_list$extent,
          resolution = 5,
          vals = values_list[[1]],
          names = names(values_list)[1]
        ) %>% terra::aggregate(fact = resolution, fun = "modal"),
        do.call(c,
                lapply(2:length(values_list), function(x) {
                  terra::rast(
                    crs = d6atlas::ras_list$crs,
                    extent = d6atlas::ras_list$extent,
                    resolution = 5,
                    vals = values_list[[x]],
                    names = names(values_list)[x]
                  ) %>% terra::aggregate(fact = resolution, fun = "mean")
                }))
      )
    }
  } else
    (print("wrong resolution"))
}
