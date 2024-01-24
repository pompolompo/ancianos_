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

# descarte por combinación lineal
var_ex0 = c("60-64AÑOS", "POBDM", "TPRO", "2G", "ACTIVOS", "ALOJA",
           "OCUPADOS", "PARADOS", "SERV", "EMPNOE", "OTRO_T", "OTRO_P", 
           "MAS121", "CON3HABI", "CON3OCUP", "DEL41AL60", "OTRO")

X0 = df[, -which(names(df) %in% var_ex0)]
R0 = cor(X0[,-1], use = "complete.obs")

# descarte por comunalidad, suma de correlaciones absoluta o insignificación
var_ex1 = c("CON1HABI", "NOTFNO", "NOCAL", "DEL81AL90", 
            "CON5OMAS", "EA", "TRAEVEN", "AFAM", "COOP")

X1 = X0[, -which(names(X0) %in% var_ex1)]
R1 = cor(X1[,-1], use = "complete.obs")