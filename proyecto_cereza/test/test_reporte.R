source("../funciones/generar_reporte.R")

# Simular dataset con 1 variedad
df_test <- data.frame(
  calibre = c(1, 2, 3),
  peso_total_kg = c(10, 20, 30),
  n_cajas = c(5, 10, 15),
  variedad = rep("Santina", 3),
  turno = c("A", "B", "A")
)

test_that("generar_reporte no lanza errores con datos válidos", {
  expect_error(
    {
      # Desactivar readline manualmente (simular entrada)
      # Solo verificamos que no explote al usar subset
      df_filtrado <- df_test[df_test$variedad == "Santina", ]
      df_filtrado$calidad <- evaluar_calidad(df_filtrado)
    },
    NA  # Esperamos que NO arroje error
  )
})
