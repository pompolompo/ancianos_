source("scripts/import.R")
library(corrplot)
library(kableExtra)
library(psych)

# SELECCIÓN DE VARIABLES
mat = cor(X0[,-1], use = "complete.obs")
testRes = cor.mtest(X0[,-1], conf.level = 0.95)

cor_tab0 = data.frame(
  'Comunalidad' = smc(mat) %>% round(digits = 4),
  'Suma' = abs(mat) %>% colSums() %>% round(digits = 2),
  'p-val' = colSums(testRes$p < .05)
) %>% arrange(desc(Comunalidad)) %>% tail(10) %>%
  kable(booktabs = TRUE, format = "latex", align = "c",
        caption = "Correlaciones de las variables seleccionadas, se muestran las 15 con menor comunalidad",
        row.names = TRUE) %>%
  kable_styling(latex_options = c("striped", "hold_position"),
                full_width = FALSE)

