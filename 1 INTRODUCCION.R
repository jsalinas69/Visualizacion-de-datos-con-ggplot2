#------------------------------------#
# VISUALIZACIÓN DE DATOS CON GGPLOT2 #    
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

View(datos)
