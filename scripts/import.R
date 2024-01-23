library(sf)
library(dplyr)
library(readxl)

# IMPORTACIÓN DE DATOS
pob = read_xls("datos/POBLACIÓN.xls") %>% rename(OTRO_T = OTRO)
casa = read_xls("datos/EQUICASA.XLS") %>% rename(OTRO_P = OTRO)
df = inner_join(pob, casa, by = "SECCEN")

shp = read_sf("datos/shape_data/13_27_SeccionCensal.shp") %>%
  mutate(sec = paste0(cod_distr, cod_secci)) %>%
  filter(sec %in% casa$SECCEN,           # coincida con las secciones de población.xls y equicasa.xls
         municipio == "Sevilla") %>%     # esté en el municipio de Sevilla
    select(sec, geometry) %>%
    arrange(sec)

# SELECCIÓN DE VARIABLES

var_ex = c("60-64AÑOS", "POBDM", "TPRO", "2G", "ACTIVOS", "ALOJA",
           "OCUPADOS", "PARADOS", "SERV", "EMPNOE", "OTRO_T", "OTRO_P", 
           "MAS121", "CON3HABI", "CON3OCUP", "DEL41AL60", "OTRO")

X0 = df[, -which(names(df) %in% c(var_ex))]