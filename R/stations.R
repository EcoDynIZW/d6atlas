#' @title get stations data frame or sf object
#' @description get the stations dataset with coordinates for each year. If argument year is set, the data will be filtered and automatically transformed to an sf object.
#' @param year numeric filter data by year (2019-2024).
#' @return a data frame or sf object
#' @export
#' @examples
#' \dontrun{
#' d6atlas::stations(year = NULL)
#'  }


stations <- function(year = NULL){

  data <- d6atlas::stations()

  if(is.null(year) == FALSE){
    data <- sf::st_as_sf(x = tidyr::drop_na(data, paste0("x_", year)),
                        coords = c(paste0("x_", year), paste0("y_", year)),
                        crs = 25833,
                        sf_column_name = "geometry",
                        remove = FALSE)
    message("data was filtered by year and transformed to sf")
  }

  return(data)

}





