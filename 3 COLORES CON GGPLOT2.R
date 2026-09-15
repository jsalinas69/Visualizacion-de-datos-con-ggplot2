#------------------------------------#
# VISUALIZACIÓN DE DATOS CON GGPLOT2 # 
#  3. Manejo de colores con ggplot2  #
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

# Manejo de Colores --------------------------------------------
# La función colors() permite ver los colores disponibles
# que tienen un nombre
colors()

# 1. Especificando colores de la barra -------------------------
# El argumento color permite asignarle un color al borde de la 
# barra y el argumento fill permite asignarle un color al relleno
# de la barra
ggplot(datos) + aes(x = morosidad) + 
  geom_bar(color = "blue", fill = "white") + 
  theme_light() + 
  labs(title = "Gráfico de Barras Vertical", 
       x = "Condición de la morosidad", 
       y = "Frecuencia") 

# 2. Usando diferentes colores en las barras -------------------
ggplot(datos) + aes(morosidad) + 
  geom_bar(color = "black", fill = c("darkgreen", "red3")) +
  theme_light() + 
  labs(title = "Gráfico de Barras Vertical", 
       x = "Condición de la morosidad", 
       y = "Frecuencia")

# 3. Usando diferentes colores en formato hexadecimal ----------
# R dispone de 16**6 = 16'777,216 colores. Estos están en formato
# hexagesimal precedidos por el signo #.
# En el siguiente link puede ver la paleta con todos los colores
browseURL("https://htmlcolorcodes.com/es/")

ggplot(datos) + aes(morosidad) +
  geom_bar(color = "black",
           fill = c("#0B1857", "#EB611A")) +
  theme_light() +
  labs(title = "Gráfico de Barras Vertical",
       x = "Condición de la morosidad",
       y = "Frecuencia")


# 4. Cambiando color de la barra por defecto usando opción fill ----
ggplot(datos) + aes(x = morosidad, fill = morosidad) +
  geom_bar() +
  theme_light() +
  labs(title = "Gráfico de Barras Vertical",
       x = "Condición de la morosidad",
       y = "Frecuencia") 

# Los colores que aparecen en cada barra corresponden a la 
# paleta de colores de Hadley Wickham

# 5. Cambiando los colores por defecto usando scale_fill_manual ----
ggplot(datos) + aes(morosidad, fill = morosidad) +
  geom_bar(color = "black", show.legend = F) +
  theme_light() +
  labs(title = "Gráfico de Barras Vertical",
       x = "Condición de la morosidad",
       y = "Frecuencia") + 
  scale_fill_manual(values = c("darkgreen", "orange")) 

# 6. Aplicando paletas de colores de R base --------------------
#    rainbow(n), heat.colors(n), terrain.colors(n),
#    topo.colors(n), and cm.colors(n)
ggplot(datos, aes(morosidad)) +
  geom_bar(color = "black", fill = heat.colors(2)) +
  theme_light() +
  labs(title = "Gráfico de Barras Vertical",
       x = "Condición de la morosidad",
       y = "Frecuencia")

# Se debe especificar el número de categorías o niveles de la
# variables

# 7. Usando paletas de colores con RColorBrewer ----------------
# Existen paquetes en R que ofrecen paletas de colores, entre
# ellas, una de la más conocidas es RColorBrewer
library(RColorBrewer)
display.brewer.all()

# Si se desea ver una de las paletas con más detalles, puede
# hacerlo especificando su nombre y el número de franjas que
# se quiere visualizar (mínimo 3 y máximo 8 variables)

display.brewer.pal(n = 6, name = 'Accent')

ggplot(datos) + aes(dpto, fill = dpto) +
  geom_bar() +
  theme_bw() + 
  scale_fill_brewer(palette = "Accent") +
  theme(legend.position = "none")

ggplot(datos) + aes(dpto, fill = dpto) +
  geom_bar() +
  theme_bw() +
  scale_fill_brewer(palette = "Spectral") +
  theme(legend.position = "none")

