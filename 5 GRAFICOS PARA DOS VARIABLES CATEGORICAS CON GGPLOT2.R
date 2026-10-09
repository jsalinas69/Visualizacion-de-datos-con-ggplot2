#----------------------------------------------#
#       VISUALIZACIÓN DE DATOS CON GGPLOT2     # 
#  5. Gráficos para dos variables categóricas  #
#          Mg. Jesús Salinas Flores            # 
#          jsalinas@lamolina.edu.pe            #
#----------------------------------------------#

rm(list = ls())  # Para limpiar el Workspace
graphics.off()   # Para eliminar los gráficos existentes
cat("\014")      # Para eliminar la consola
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Para direccionar el directorio de trabajo
getwd()

options(digits = 8)     # Para configurar el número de dígitos
options(scipen = 999)   # Para eliminar la notación científica

# Paquetes ----------------------------------------------------- 
library(pacman) # Package Manager
p_load(foreign, ggplot2) 
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

# Gráfico de barras apiladas en valor absoluto -----------------
# (Stacked Bar Plot) 

ggplot(datos) + aes(tiporenta) + geom_bar()

# Para cruzar dos variables categóricas, una de ella va al eje
# x y la otra con la opción fill
# Por defecto realizar un gráfico de barras apiladas

ggplot(datos) + aes(tiporenta, fill = morosidad) + geom_bar()

ggplot(datos) + aes(x = tiporenta, fill = morosidad) +
  geom_bar(position = "stack") + # position = position_stack()
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta",
       x = "Tipo de Renta",
       y = "Frecuencia",
       fill = "Situación")  +
  scale_fill_manual(values = c("darkolivegreen3", "firebrick2"))

##### La opción position = "stack" es por default

ggplot(datos) + aes(x = tiporenta, fill = morosidad) +
  geom_bar(position = position_stack()) + # Equivalente a position = "stack"
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta",
       x = "Tipo de Renta",
       y = "Frecuencia",
       fill = "Situación")  +
  scale_fill_manual(values = c("darkolivegreen3", "firebrick2"))


# Gráfico de barras apiladas en proporción ---------------------
# (Fill Bar Plot) 
# Para obtener los valores en proporción se usa el argumento
# position = "fill" dentro de geom_bar()
ggplot(datos) + aes(x = tiporenta, fill = morosidad) +
  geom_bar(position = "fill") +  # position = position_fill()
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta",
       x = "Tipo de Renta",
       y = "Proporción") +
  scale_fill_manual(values = c("darkolivegreen3", "firebrick2"))


# Gráfico de barras en Porcentaje (%) ----------------------
# Para ponerlo en % se recurre a la función percent_format()
# que se encuentra en el paquete scales

# ¿Qué departamentos tienen la mayor morosidad y qué % de 
#  morosidad tienen?
library(scales)
ggplot(datos) + aes(dpto, fill = morosidad) +
  geom_bar(position = "fill") +
  labs(title = "% de morosos y de no morosos por departamento",
       x = "Departamentos", y = "%", fill = "Situación") +
  scale_fill_manual(values = c("darkolivegreen3", "firebrick2")) +
  scale_y_continuous(labels = scales::percent_format(),
                     breaks = seq(0, 1, 0.1))


# Gráfico de Barras Agrupadas en valor absoluto ----------------
# (Grouped Bar Plot)
ggplot(datos) + aes(x = tiporenta, fill = morosidad) +
  geom_bar(position = "dodge") + # position = position_dodge()
  theme_bw() +
  labs(title = "Situación de la Morosidad según el Tipo de Renta",
       x = "Tipo de Renta",
       y = "Frecuencia")  +
  scale_fill_manual(values = c("darkolivegreen3", "firebrick2"))

