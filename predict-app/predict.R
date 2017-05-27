gramTable2File <- './gramTable2.csv'
gramTable3File <- './gramTable3.csv'
gramTable4File <- './gramTable4.csv'
gramTable5File <- './gramTable5.csv'

predict <- function(phrase) {
  textTokens <- tokens(phrase, what='word', remove_numbers=TRUE, remove_punct=TRUE, remove_twitter=TRUE, remove_url = TRUE, remove_symbols = TRUE, n=1, concatenator = " ")
  textTokens <- tokens_tolower(textTokens)[[1]]
  n <- length(textTokens)
  for (i in min(n-1, 4):1) {
    if (i == 4) {
      searchText <- trimws(paste(textTokens[n-i+1], textTokens[n-i+2], textTokens[n-i+3], textTokens[n-i+4], collpase = ""))
      gramTable5 <- fread(gramTable5File)
      setkey(gramTable5, gram)
      match <- gramTable5[gram == searchText]
    } else if (i == 3) {
      searchText <- trimws(paste(textTokens[n-i+1], textTokens[n-i+2], textTokens[n-i+3], collpase = ""))
      gramTable4 <- fread(gramTable4File)
      setkey(gramTable4, gram)
      match <- gramTable4[gram == searchText]
    } else if (i == 2) {
      searchText <- trimws(paste(textTokens[n-i+1], textTokens[n-i+2], collapse = ""))
      gramTable3 <- fread(gramTable3File)
      setkey(gramTable3, gram)
      match <- gramTable3[gram == searchText]
    } else {
      searchText <- trimws(paste0(textTokens[n-i+1], " ", collapse = ""))
      gramTable2 <- fread(gramTable2File)
      setkey(gramTable2, gram)
      match <- gramTable2[gram == searchText]
    } 
    if (match[,.N] > 0) {
      break
    }
  }
  predictedText <- NA
  if (match[,.N] > 0) {
    match[order(-count)]
    if (match[,.N] > 4) {
      match <- match[1:4,]
    }
    predictedText <- match[,predict]
  }
  return (predictedText)
}