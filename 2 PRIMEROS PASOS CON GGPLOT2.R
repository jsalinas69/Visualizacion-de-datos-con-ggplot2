#------------------------------------#
# VISUALIZACIÓN DE DATOS CON GGPLOT2 # 
#   2. Primeros pasos con ggplot2    #
#     Mg. Jesús Salinas Flores       # 
#     jsalinas@lamolina.edu.pe       #
#------------------------------------#

rm(list = ls())  # Para limpiar el Workspace
graphics.off()   # Para eliminar los gráficos existentes
cat("\014")      # Para eliminar la consola
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Para direccionar el directorio de trabajo
getwd()

options(digits = 8)     # Para configurar el número de dígitos
options(scipen = 999)   # Para eliminar la notación científica

# Paquetes ----------------------------------------------------- 
library(pacman) # Package Manager
p_load(foreign, colourpicker, ggplot2, gganimate, png, 
       plotly, forcats, RColorBrewer, lubridate, scales,
       esquisse, patchwork) 
# La función p_load() instala el paquete si no está instalado
# y luego carga el paquete 

# Lectura de datos --------------------------------------------- 
library(foreign)
datos <- read.spss("Riesgo_morosidad.sav", 
                   use.value.labels = T,  
                   to.data.frame = TRUE)
attr(datos, "variable.labels") <- NULL   
# attr() elimina las variables labels de cada columna

str(datos)

mean(datos$edad)

attach(datos)  
# attach() permite romper el vínculo entre los datos y las 
# variables. Evitar estar usando datos$

mean(edad)

# Primeros pasos con ggplot2 -----------------------------------
# ggplot2 está basado en capas, permite hacer gráficos paso a paso,
# yendo de lo más básico o lo más avanzado
library(ggplot2) 

ggplot(data = datos)  # presenta el lienzo

ggplot(data = datos) + aes(x = morosidad) 
# presenta las categorías de las variable morosidad en el lienzo
# en la función o capa aes(la estética) únicamente pueden ir variables

ggplot(data = datos) + aes(x = morosidad) + geom_bar() 
# presenta el gráfico de barras 

# Todos los gráficos se realizan usando geometrías, toda 
# geometría tiene un stat que hace por defecto
# En el caso de geom_bar() por defecto cuenta la frecuencia por
# cada categoría de la variables a graficas, su stat por defecto
# es count. 
ggplot(data = datos) + aes(x = morosidad) + 
  geom_bar(stat = "count")  # Stat por defecto

ggplot(datos) + aes(morosidad) + geom_() # es equivalente

ggplot(datos, aes(morosidad)) + geom_bar()  # es equivalente

ggplot(datos) + geom_bar(aes(morosidad))    # es equivalente

ggplot(datos) + aes(morosidad) + geom_bar(stat = "count")

ggplot(datos) + aes(morosidad) + stat_count(geom = "bar")

# Gráfico con geom_col()
# Otra forma de realizar un gráfico de barras es con geom_col()
# A diferencia de geom_bar() no cuenta, sino que grafica 
# exactamente las cifras que se le proporciona
estadi <- data.frame(Genero = c("Masculino", "Femenino"),
                     Alumnos = c(20, 10))

estadi

ggplot(estadi)  + aes(x = Genero, y = Alumnos) + geom_col()

ggplot(estadi)  + aes(x = Genero, y = Alumnos) + 
  geom_col(stat = "identity")  # stat por defecto

ggplot(estadi)  + aes(x = Genero, y = Alumnos) + geom_col()

# Todas las geometrías disponibles en: 
# browseURL("https://ggplot2.tidyverse.org/reference/")

# Gráfico horizontal 
ggplot(datos) + aes(morosidad) + geom_bar() +  coord_flip()
ggplot(datos) + aes(y = morosidad) + geom_bar() 

# Añadiendo títulos al gráfico con labs() ----------------------
# La capa labs permite añadir títulos en un gráfico
# Además del título principal, se puede añadir un subtítulo,
# título en el eje X, título en el eje Y, caption, etc.
ggplot(datos) + aes(morosidad) + 
  geom_bar() + 
  labs(title = "Gráfico de Barras Vertical",
       subtitle = "Realizado con ggplot2",
       x = "Condición de la morosidad", 
       y = "Frecuencia",
       caption = "Fuente: Elaboración Propia") 

# Otra opción: tag

# Añadiendo temas de fondo con theme() -------------------------
# Se puede cambiar rápidamente la apariencia estética del gráfico,
# pero no los datos ni el tipo de gráfico.
ggplot(datos) + aes(morosidad) + 
  geom_bar() + 
  labs(title = "Gráfico de Barras Vertical",
       subtitle = "Realizado con ggplot2",
       x = "Condición de la morosidad", 
       y = "Frecuencia",
       caption = "Fuente: Elaboración Propia") -> gráfico1
gráfico1

gráfico1 + theme_gray()

# Temas: theme_bw()      theme_classic()   theme_dark()
#        theme_get()     theme_gray()      theme_grey()
#        theme_light()   theme_linedraw()  theme_minimal()
#        theme_replace() theme_set() *     theme_update()
#        theme_void()

# Se pueden usar todos los temas descritos a excepción de 
# theme_set() que permite configurar un tema.

# Muchos investigadores han aportado al crecimiento de ggplot2
# creando paquetes que permitan mejorar ggplot2. Estos paquetes
# se denominan extensiones. A la fecha hay más de 167 extensiones
# Pueden ver estas extensiones en este enlace:
browseURL("https://exts.ggplot2.tidyverse.org/gallery/")

# Existen extensiones que permiten disponer de más temas. 
# Tenemos como ejemplos: 
library(ggthemes)
library(tvthemes)
# 