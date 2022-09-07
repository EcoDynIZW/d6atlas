#' @title Transform your data & plot with suitable bounding box
#' @description atlasauto aims to provide ATLAS users in Dedelow a fast solution to plot your data after receiving / downloading it. The function automatically transforms X and Y into a sf-object, transforms the coordinates into ETRS89 / UTM zone 33N and crops the underlying map for your needs.
#' @param data your data frame, can be filtered or unfiltered
#' @param size size of the dots, Default: 1
#' @param color color of the dots, Default: "red"
#' @param scalebar Boolean: add a scale bar, Default: FALSE
#' @param north_arrow Boolean: add a north arrow, Default: FALSE
#' @param color_intensity Numeric: control the desaturation of
#'                        the color intensity, ranging from 0 (fully
#'                        desaturated) to 1 (fully saturated), Default: 1
#' @return a ggplot object with the bounding box of your data
#' @examples
#' \dontrun{
#' starling_2547 <- d6atlas::starling_2547
#' d6atlas::atlasauto(starling_2547)
#'  }
#' }
#' @seealso
#'  \code{\link[sf]{st_as_sf}},\code{\link[sf]{st_transform}}
#'  \code{\link[ggplot2]{CoordSf}}
#' @rdname atlasauto
#' @export
#' @importFrom sf st_as_sf st_transform st_bbox
#' @importFrom ggplot2 geom_sf
#' @importFrom ggspatial annotation_scale annotation_north_arrow

atlasauto <- function(data,
                      size=1,
                      color="red",
                      scalebar=FALSE,
                      north_arrow=FALSE,
                      color_intensity=1) {

  #transform crs
  data <- sf::st_as_sf(data,coords = c("X","Y"), crs = 32633)
  data <- sf::st_transform(data,crs = 25833)
  bbox <- sf::st_bbox(data)
  #plot
 g <- atlasplot(color_intensity=color_intensity)+
   ggplot2::geom_sf(data = data, color = color, size = size)+
   ggplot2::coord_sf(xlim = c(bbox[1],bbox[3]),
                     ylim = c(bbox[2],bbox[4]))
 ## annotation scale.........................................................
 if (scalebar == TRUE) {
   message("Adding annotation scalebar.")

   g<-g+ggspatial::annotation_scale(
     location=c("bl"),
     height = ggplot2::unit(0.4, "cm"),
     line_width = 1.3, width_hint = .36,
     text_col = "black", text_cex = 1, #text_family = font_family,
     pad_x = ggplot2::unit(0.2, "cm"), pad_y = ggplot2::unit(0.2, "cm")
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

return(g)

 }


