#' Generar reporte interactivo de calidad por variedad
#'
#' Permite al usuario seleccionar una variedad, genera resumen, gráficos
#' y exporta los datos filtrados a un archivo Excel.
#'
#' @param data Un data.frame con columnas: variedad, calibre, peso_total_kg, n_cajas, turno
#' @return NULL
#' @export

generar_reporte <- function(data) {
  if (!"variedad" %in% names(data)) {
    stop("La columna 'variedad' no está presente en el dataset.")
  }
  
  # Mostrar variedades únicas
  variedades <- unique(data$variedad)
  cat("Variedades disponibles:\n")
  for (i in seq_along(variedades)) {
    cat(i, "-", variedades[i], "\n")
  }
  
  # Solicitar selección
  opcion <- as.integer(readline("Seleccione el número de la variedad a analizar: "))
  if (is.na(opcion) || opcion < 1 || opcion > length(variedades)) {
    stop("Selección inválida.")
  }
  
  variedad_seleccionada <- variedades[opcion]
  cat("\nHas seleccionado:", variedad_seleccionada, "\n")
  
  # Filtrar datos
  data_filtrada <- dplyr::filter(data, variedad == variedad_seleccionada)
  
  # Evaluar calidad
  data_filtrada$calidad <- evaluar_calidad(data_filtrada)
  
  # Resumen
  cat("\nResumen estadístico de la calidad:\n")
  print(summary(data_filtrada$calidad))
  
  cat("\nResumen general de variables numéricas:\n")
  print(summary(dplyr::select(data_filtrada, calibre, peso_total_kg, n_cajas)))
  
  # Gráficos
  if (requireNamespace("ggplot2", quietly = TRUE)) {
    library(ggplot2)
    
    # Histograma
    print(
      ggplot(data_filtrada, aes(x = calidad)) +
        geom_histogram(bins = 15, fill = "skyblue", color = "black") +
        labs(title = paste("Distribución de Calidad -", variedad_seleccionada),
             x = "Calidad", y = "Frecuencia") +
        theme_minimal()
    )
    
    # Boxplot por turno
    if ("turno" %in% names(data_filtrada)) {
      print(
        ggplot(data_filtrada, aes(x = turno, y = calidad)) +
          geom_boxplot(fill = "lightgreen") +
          labs(title = paste("Calidad por Turno -", variedad_seleccionada),
               x = "Turno", y = "Calidad") +
          theme_minimal()
      )
    }
  } else {
    warning("Paquete ggplot2 no disponible. Instálalo con install.packages('ggplot2')")
  }
}
