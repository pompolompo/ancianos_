source("scripts/import.R")


# descriptiva breve

## CORRELACIONES

# vivienda
mat = cor(casa[,-1], use = "complete.obs")
testRes = cor.mtest(casa[,-1], conf.level = 0.95)

dev.new()
corrplot(mat, method = "color", diag = FALSE, type = "upper",
         p.mat = testRes$p, sig.level = 0.05, order = 'hclust',
         cex.main = 2, mar = c(0, 0, 2, 0), 
         title = "Correlaciones entre variables del hogar")
dev.off()

# demografía
mat = cor(pob[,-1], use = "complete.obs")
testRes = cor.mtest(pob[,-1], conf.level = 0.95)

dev.new()
corrplot(mat, method = "color", diag = FALSE, type = "upper",
         p.mat = testRes$p, sig.level = 0.05, order = 'hclust',
         cex.main = 2, mar = c(0, 0, 2, 0), 
         title = "Correlaciones entre variables demográficas")
dev.off()

# todas las variables
mat = cor(df[,-1], use = "complete.obs")
testRes = cor.mtest(df[,-1], conf.level = 0.95)

dev.new()
corrplot(mat, method = "color", diag = TRUE, addrect = 6,
         p.mat = testRes$p, sig.level = 0.05, order = 'hclust',
         cex.main = 2, mar = c(0, 0, 2, 0), tl.pos = "n", pch.cex = .75,
         title = "Correlaciones entre todas las variables")
dev.off()
