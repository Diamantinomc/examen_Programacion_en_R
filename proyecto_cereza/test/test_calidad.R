library(testthat)
source("../funciones/evaluar_calidad.R")

# Dataset de prueba
df_prueba <- data.frame(
  calibre = c(1, 2, 3),
  peso_total_kg = c(10, 20, 30),
  n_cajas = c(5, 10, 15)
)

test_that("evaluar_calidad devuelve vector numérico", {
  resultado <- evaluar_calidad(df_prueba)
  expect_type(resultado, "double")
  expect_length(resultado, nrow(df_prueba))
})

test_that("evaluar_calidad lanza error si faltan columnas", {
  df_malo <- df_prueba[, -1]  # le quitamos calibre
  expect_error(evaluar_calidad(df_malo), "Faltan columnas")
})

test_that("evaluar_calidad lanza error si los pesos no suman 1", {
  expect_error(evaluar_calidad(df_prueba, 0.5, 0.5, 0.5), "suma de los pesos debe ser 1")
})

test_that("evaluar_calidad tolera NA en datos", {
  df_na <- df_prueba
  df_na$calibre[2] <- NA
  resultado <- evaluar_calidad(df_na)
  expect_true(is.na(resultado[2]))
})
