#' Calcular puntaje de calidad de cerezas
#'
#' Esta función evalúa la calidad combinando calibre, peso total y número de cajas.
#'
#' @param data Un data.frame con las columnas: "calibre", "peso_total_kg", "n_cajas"
#' @param peso_calibre Peso asignado a calibre (default = 0.4)
#' @param peso_peso Peso asignado a peso total (default = 0.3)
#' @param peso_cajas Peso asignado a número de cajas (default = 0.3)
#' @return Un vector numérico con los puntajes de calidad
#' @export

evaluar_calidad <- function(data,
                            peso_calibre = 0.4,
                            peso_peso = 0.3,
                            peso_cajas = 0.3) {
  
  # Validación de columnas
  required_cols <- c("calibre", "peso_total_kg", "n_cajas")
  if (!all(required_cols %in% names(data))) {
    stop("Faltan columnas necesarias en el data.frame: calibre, peso_total_kg o n_cajas")
  }
  
  # Validación de pesos
  total_peso <- peso_calibre + peso_peso + peso_cajas
  if (abs(total_peso - 1) > 0.01) {
    stop("La suma de los pesos debe ser 1")
  }
  
  # Mapeo si calibre es texto
  if (is.character(data$calibre) || is.factor(data$calibre)) {
    calibre_map <- c("L" = 1, "XL" = 2, "XXL" = 3)
    data$calibre <- calibre_map[as.character(data$calibre)]
  }
  
  # Normalización min-max
  normalize <- function(x) {
    if (all(is.na(x))) return(rep(NA, length(x)))
    (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
  }
  
  norm_calibre <- normalize(data$calibre)
  norm_peso    <- normalize(data$peso_total_kg)
  norm_cajas   <- normalize(data$n_cajas)
  
  # Calcular puntaje compuesto
  puntaje <- peso_calibre * norm_calibre +
    peso_peso    * norm_peso +
    peso_cajas   * norm_cajas
  
  return(round(puntaje, 3))
}

