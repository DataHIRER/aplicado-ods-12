library(quantmod)
library(readr)
library(plyr)

#impedindo que haja erro durante a busca pelas informações
options("getSymbols.warning4.0" = FALSE)
options("getSymbols.yahoo.warning" = FALSE)

#lendo o arquivo codigos_bovespa.csv criado no python
codigos_ibovespa <- read_csv("codigos_bovespa.csv")

precos_ibovespa <- data.frame()

for (codigo in codigos_ibovespa$Codigo) {
  getSymbols(codigo, from = "2018-09-01",
  to = "2023-09-01", warnings = FALSE,
  auto.assign = TRUE)
  df_temp <- data.frame(
    Ticker = codigo,
    Data = index(get(codigo)),
    Fechamento = Cl(get(codigo))
  )
  precos_ibovespa <- rbind.fill(precos_ibovespa, df_temp)
}

write.csv(precos_ibovespa, file = "dados_acoes.csv")