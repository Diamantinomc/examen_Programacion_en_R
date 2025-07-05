# Evaluación de Calidad en Packing de Cerezas

Este proyecto fue desarrollado como parte del curso *Programación en R* del Magíster en Ciencia de Datos (UDLA). El objetivo es construir funciones personalizadas en R que permitan analizar y evaluar la calidad de cerezas procesadas en un packing, utilizando herramientas del ecosistema `tidyverse` y buenas prácticas de programación funcional.

## 🧠 Objetivo

- Calcular una puntuación de calidad por registro, combinando calibre, peso total y número de cajas.
- Generar reportes interactivos para el análisis por variedad.
- Validar el funcionamiento del código mediante pruebas automáticas con `testthat`.

## 📂 Estructura del repositorio

📁 funciones/
├── evaluar_calidad.R
└── generar_reporte.R

📁 test/
└── test_calidad.R

📄 informe.qmd ← Informe Quarto (opcional)
📄 README.md ← Este archivo
📄 packing_cerezas.csv ← Dataset utilizado


## ▶️ ¿Cómo usar el proyecto?

1. Clona este repositorio o descarga los archivos.
2. Abre RStudio y establece el directorio de trabajo en la raíz del proyecto.
3. Carga las funciones:

```r
source("funciones/evaluar_calidad.R")
source("funciones/generar_reporte.R")

4. Ejecuta la función interactiva:
generar_reporte(data_final)
Asegúrate de tener cargado el dataset packing_cerezas.csv como data_final.

Este proyecto utiliza los siguientes paquetes de R:
dplyr
ggplot2
testthat

Puedes instalarlos con:
install.packages(c("dplyr", "ggplot2", "testthat", "writexl"))

✅ Pruebas
Las pruebas están definidas en el archivo test/test_calidad.R. Puedes ejecutarlas con:
library(testthat)
test_file("test/test_calidad.R")

👨‍💻 Autor
Adán Marchena
Magíster en Ciencia de Datos - Universidad de Las Américas (UDLA)

Este proyecto fue evaluado como parte de la segunda cátedra y tiene fines exclusivamente académicos.
