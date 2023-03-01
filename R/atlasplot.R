#' @title Plot template map Uckermark (ATLAS experimental area)
#' @description plots a template map for the experimental area of the ATLAS system in the Uckermark, Brandenburg
#' @param color_intensity Numeric: control the desaturation of
#'                        the color intensity, ranging from 0 (fully
#'                        desaturated) to 1 (fully saturated), Default: 1
#' @param scalebar Boolean: add a scale bar, Default: FALSE
#' @param north_arrow Boolean: add a north arrow, Default: FALSE
#' @param insert_caption Boolean: add a caption, Default: FALSE
#' @param legend string: Either "bottom", "top", or "none". Otherwise specify
#'               positions via legend_x and legend_y, Default: 'bottom'
#' @param legend_x Numeric: Horizontal position of the legend (0 – 1), Default: NULL
#' @param legend_y Numeric: Vertical position of the legend (0 – 1), Default: NULL
#' @param print Boolean: print the map in the viewer pane, Default: FALSE
#' @return A ggplot object containing a template map for the ATLAS-region
#' @examples
#' \dontrun{
#' d6atlas::atlasplot()
#' d6atlas::atlasplot(north_arrow = TRUE, scalebar = TRUE)
#'  }
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
#' @importFrom ggplot2 ggplot geom_sf theme_void element_blank element_rect annotate
#' @importFrom ggspatial annotation_scale annotation_north_arrow
#' @importFrom sf st_bbox
#'
atlasplot <- function(color_intensity = 1,
                      scalebar = FALSE,
                      north_arrow = FALSE,
                      insert_caption = FALSE,
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



  ## COLORS -------------------------------------------------------------

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
  caption <- "\nData  Map: Landesamt fuer Umwelt Brandenburg (LfU)"

  ## ATLAS MAP ----------------------------------------------------------------
  message("Plotting map.")


  g <- ggplot2::ggplot() +
    ## agriculture_09 .............................................................
    ggplot2::geom_sf(data = d6atlas::agriculture_09,
                     fill = col_agriculture,
                     color = col_agriculture,
                     lwd = 0.05,
                     alpha=1)+
    ## ruderal_03 .............................................................
    ggplot2::geom_sf(data = d6atlas::ruderal_03,
                     fill = col_ruderal,
                     color = col_ruderal,
                     lwd = 0.05)+
    ## swamp_04 .............................................................
    ggplot2::geom_sf(data = d6atlas::swamp_04,
                     fill = col_ruderal,
                     color = col_ruderal,
                     lwd = 0.05)+
    ## grassland_05 .............................................................
    ggplot2::geom_sf(data = d6atlas::grassland_05,
                     fill = col_grassland,
                     color = col_grassland,
                     lwd = 0.05)+
    ## bushland_07 .............................................................
    ggplot2::geom_sf(data = d6atlas::bushland_07,
                     fill = col_forest,
                     color = col_forest,
                     lwd = 0.05)+
    ## forest_08 .............................................................
    ggplot2::geom_sf(data = d6atlas::forest_08,
                     fill = col_forest,
                     color = col_forest,
                     lwd = 0.05)+
    ## garden_graveyard_10 .............................................................
    ggplot2::geom_sf(data = d6atlas::garden_graveyard_10,
                     fill = col_grassland,
                     color = col_grassland,
                     lwd = 0.05)+
    ## built_up_12 .............................................................
    ggplot2::geom_sf(data = d6atlas::built_up_12,
                     fill = "#948f8d",
                     color = "#948f8d",
                     lwd = 0.05)+
    ## water_01 .............................................................
    ggplot2::geom_sf(data = d6atlas::water_01,
                     fill = col_water,
                     color = col_water,
                     lwd = 0.05)+
    ## water_02 .............................................................
    ggplot2::geom_sf(data = d6atlas::water_02,
                     fill = col_water,
                     color = col_water,
                     lwd = 0.05)+
    ## theme....................................................................
                      ggplot2::theme(
                        panel.grid.major  = ggplot2::element_blank(),
                        panel.background = ggplot2::element_rect(fill="white"),
                        axis.title.y  = ggplot2::element_blank(),
                        axis.title.x = ggplot2::element_text(colour = "grey20",
                                                             hjust = 0)
                      )

    ## annotation scale.........................................................
  if (scalebar == TRUE) {
    message("Adding annotation scalebar.")

  g<-g+ggspatial::annotation_scale(
      location=c("bl"),
      height = ggplot2::unit(0.4, "cm"),
      line_width = 1.3, width_hint = .36,
      text_col = "black", text_cex = 1, #text_family = font_family,
      pad_x = ggplot2::unit(0.8, "cm"), pad_y = ggplot2::unit(0.8, "cm")
  )}
  ## north arrow................................................................
  if (north_arrow == TRUE) {
    message("Adding north scale.")

    g<-g+ggspatial::annotation_north_arrow(
      location = "br", which_north = "true",
      height = ggplot2::unit(1.5, "cm"),
      width = ggplot2::unit(1.0, "cm"),
      pad_x = ggplot2::unit(0.8, "cm"), pad_y = ggplot2::unit(0.8, "cm"))
  }
    ## annotation...............................................................
    if (insert_caption == TRUE) {
      message("Adding caption.")

    # g<-g+ggplot2::annotate("text", x = 414300 , y = 5911568, label = caption,
    #                   hjust = 0, vjust = 1, color = "grey30",
    #                   #family = font_family,
    #                   size = 3.4, lineheight = .95)
      g<-g+ggplot2::xlab(caption)
  }

 return(g)
}


