source("scripts/import.R")
library(corrplot)
library(kableExtra)
library(psych)

# SELECCIÓN DE VARIABLES
testRes = cor.mtest(R0, conf.level = 0.95)

cor_tab0 = data.frame(
  'Comunalidad' = smc(R0) %>% round(digits = 4),
  'Suma' = abs(R0) %>% colSums() %>% round(digits = 2),
  'p-val' = colSums(testRes$p < .05)
) %>% arrange(desc(Comunalidad)) %>%
  filter(Comunalidad < .7, 
         Suma < median(Suma), 
         p.val < 30) %>%
  kable(booktabs = TRUE, format = "latex", align = "c",
        caption = "Correlaciones de las variables seleccionadas, se muestran las 15 con menor comunalidad",
        row.names = TRUE) %>%
  kable_styling(latex_options = c("striped", "hold_position"),
                full_width = FALSE)


