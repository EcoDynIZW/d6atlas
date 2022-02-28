#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param color_intensity PARAM_DESCRIPTION, Default: 1
#' @param legend PARAM_DESCRIPTION, Default: 'bottom'
#' @param legend_x PARAM_DESCRIPTION, Default: NULL
#' @param legend_y PARAM_DESCRIPTION, Default: NULL
#' @param print PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{between}}
#'  \code{\link[scales]{alpha}}
#'  \code{\link[grDevices]{colorRamp}}
#'  \code{\link[colorspace]{desaturate}},\code{\link[colorspace]{lighten}}
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{CoordSf}}
#' @rdname atlasplot
#' @export
#' @importFrom dplyr between
#' @importFrom scales alpha
#' @importFrom grDevices colorRampPalette
#' @importFrom colorspace desaturate lighten
#' @importFrom ggplot2 ggplot geom_sf theme_void

atlasplot <- function(color_intensity = 1,
                      legend = "bottom",
                      legend_x = NULL,
                      legend_y = NULL,
                      print = FALSE) {

  if(!dplyr::between(color_intensity, 0, 1)) stop("color_intensity must be a value between 0 and 1.")
  if(!is.logical(print)) stop("print must be a boolean value (TRUE or FALSE).")
  if(!legend %in% c("none", "bottom", "top") | !exists("legend_x") | !exists("legend_y")) stop('Please provide as legend position: either "bottom", "top", or "none" or specify a custom legend position via legend_x and legend_y.')
  if(!is.null(legend_x)) { if (!is.numeric(legend_x) | legend_x > 1 | legend_y < 0) stop("legend_x must be a numeric value between 0 and 1.") }
  if(!is.null(legend_y)) { if (!is.numeric(legend_y) | legend_x > 1 | legend_y < 0) stop("legend_y must be a numeric value between 0 and 1.") }
  if (is.null(legend_x) & legend == "bottom") { legend_x <- .5; legend_y <- .075 }
  if (is.null(legend_x) & legend == "top") { legend_x <- .82; legend_y <- .85 }
  if (legend %in% c("none", "None")) leg <- "none" else leg <- "colourbar"

  ## COLOR PALETTE -------------------------------------------------------------
  pal <- scales::alpha(
    grDevices::colorRampPalette(c("grey95", "grey5"))(100), color_intensity
  )

  col_water <-
    colorspace::desaturate(
      colorspace::lighten("#a9c3df", (1 - color_intensity) / 1.5),
      (1 - color_intensity) / 1.5
    )
  col_ruderal <-
    colorspace::desaturate(
      colorspace::lighten("#a5bf8b", (1 - color_intensity) / 1.3),
      (1 - color_intensity) / 1.3
    )
  col_grassland <-
    colorspace::desaturate(
      colorspace::lighten("#b6e892", (1 - color_intensity) / 1.3),
      (1 - color_intensity) / 1.3
    )
  col_forest <-
    colorspace::desaturate(
      colorspace::lighten("#5c9126", (1 - color_intensity) / 1.1),
      (1 - color_intensity) / 1.1
    )

  col_agriculture <-
    colorspace::desaturate(
      colorspace::lighten("#e8ebc5", (1 - color_intensity) / 1.3),
      (1 - color_intensity) / 1.3
    )

  ## CAPTION TEXT --------------------------------------------------------------
  caption <- "Data  Map: Landesamt fuer Umwelt Brandenburg (LfU)"

  ## ATLAS MAP ----------------------------------------------------------------
  message("Plotting map.")


  g <- ggplot2::ggplot() +
    ## agriculture_09 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::agriculture_09,
                     fill = col_agriculture,
                     color = col_agriculture,
                     lwd = 0.05,
                     alpha=1)+
    ## water_01 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::water_01,
                     fill = col_water,
                     color = col_water,
                     lwd = 0.05)+
    ## water_02 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::water_02,
                     fill = col_water,
                     color = col_water,
                     lwd = 0.05)+
    ## ruderal_03 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::ruderal_03,
                     fill = col_ruderal,
                     color = col_ruderal,
                     lwd = 0.05)+
    ## swamp_04 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::swamp_04,
                     fill = col_ruderal,
                     color = col_ruderal,
                     lwd = 0.05)+
    ## grassland_05 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::grassland_05,
                     fill = col_grassland,
                     color = col_grassland,
                     lwd = 0.05)+
    ## bushland_07 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::bushland_07,
                     fill = col_forest,
                     color = col_forest,
                     lwd = 0.05)+
    ## forest_08 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::forest_08,
                     fill = col_forest,
                     color = col_forest,
                     lwd = 0.05)+
    ## garden_graveyard_10 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::garden_graveyard_10,
                     fill = col_grassland,
                     color = col_grassland,
                     lwd = 0.05)+
    ## built_up_12 .............................................................
    ggplot2::geom_sf(data = d6atlasplot::built_up_12,
                     fill = "#948f8d",
                     color = "#948f8d",
                     lwd = 0.05)+
    ggplot2::theme_void()
 print(g)
}
