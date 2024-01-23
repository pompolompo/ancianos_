library(sf)
library(dplyr)
library(readxl)

pob = read_xls("datos/POBLACIÓN.xls")
casa = read_xls("datos/EQUICASA.XLS")
df = inner_join(pob, casa, by = "SECCEN")

shp = read_sf("datos/shape_data/13_27_SeccionCensal.shp") %>%
  mutate(sec = paste0(cod_distr, cod_secci)) %>%
  filter(sec %in% casa$SECCEN,           # coincida con las secciones de población.xls y equicasa.xls
         municipio == "Sevilla") %>%     # esté en el municipio de Sevilla
    select(sec, geometry) %>%
    arrange(sec)



