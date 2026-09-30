#------------------------------------#
# VISUALIZACIÓN DE DATOS CON GGPLOT2 # 
#  4. Gráficos animados con ggplot2  #
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
p_load(foreign, ggplot2, gganimate, png) 
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

# Gráficos animados con gganimate -----------------------------
library(gganimate)
library(gifski)
library(png)

# gifski permite renderizar la animación como un formato de
#        archivo GIF (GIF es un formato de imagen popular para
#        imágenes animadas).

ganim <- ggplot(datos) + aes(morosidad) +
  geom_bar(color = "black",
           fill = c("darkgreen", "orange"))

ganim
# Para animar un gráfico usamos la capa transition_(). Para el 
# caso de un gráfico de barras se usa transition_states()

ganim + transition_states(morosidad)

# Para que la transición entre una barra y otra podemos usar
# efectos de entrada (enter_) y/o efectos de salida (exit_)
ganim +  transition_states(morosidad)  +
  enter_fade() +
  exit_fade()

ganim + transition_states(morosidad)  +
  enter_grow() +
  exit_fade()

# Por defecto, las variables cambian linealmente (paso a paso 
# con la misma velocidad). Pero con ease_aes() puedes cambiar la
# forma en que ocurren esas transiciones.
# * "linear"         → cambio constante, sin aceleración.
# * "cubic-in-out"   → empieza lento, acelera en el medio, y 
#                      termina lento (suave).
# * "bounce-out"     → hace un “rebote” al final.
# * "elastic-in-out" → efecto elástico al inicio y al final.

ggplot(datos) + aes(dpto, fill = dpto) +
  geom_bar(color = "black")  +
  transition_states(dpto) +
  enter_grow() +
  exit_shrink() +
  ease_aes('elastic-in-out')

ganim  +
  transition_states(morosidad) +
  enter_grow() +
  shadow_mark() # para que no desaparezca la barra


# Se puede usar otros formatos como *.gif , *.mp4
# Para videos instalar el paquete av

# fps: el ser humano es capaz de ver y distinguir entre 10 y 12
#      imágenes por segundo. A partir de ese ratio, el cerebro
#      en vez de ver imágenes ve una animación (fuente).
#      Por tanto, el número de frames por segundo siempre
#      debería ser superior a 12.

# * fps bajo (ej. 5 fps):  la animación se ve lenta y algo
#                          “entrecortada”.
# * fps alto (ej. 30 fps): la animación es fluida, pero el 
#                          archivo pesa más.

# En general:
# * GIFs suelen usarse con fps = 10–15.
# * Videos (mp4, mov) suelen ir con fps = 24–30
#   (como el cine/televisión).

# duration : Cuánto quieres que dure la animación dependerá de
#            ti. Claro está que cuantos más  estados haya que
#            recorrer, mayor será la duración. Para transiciones
#            largas con muchos estados, lo ideal es que cada
#            estado dure 0,5 segundos.

g1 <- ggplot(datos) + aes(dpto, fill = dpto) +
  geom_bar(color = "black")  +
  transition_states(dpto) +
  enter_grow() +
  shadow_mark() # para que no desaparezca la barra

g1

animate(g1)
animate(g1, nframes = 100, fps = 10)
animate(g1, duration = 15, fps = 10)

# Se puede grabar la animación como un *.gif usando la función
# anim_save()

anim_save("Grafico de Barras Animado.gif", g1)

# Para grabar la animación en un video se debe tener instalado
# el paquete av
library(av)
b <- animate(g1,
             duration = 20,
             fps = 20,
             renderer = av_renderer())
anim_save("Grafico de Barras Animado.mp4", b)