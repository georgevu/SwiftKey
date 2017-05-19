#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(quanteda)
library(data.table)
# Define server logic required to draw a histogram
dataDir <- './data'
gramTable2File <- paste0(dataDir, 'gramTable2.csv')
gramTable3File <- paste0(dataDir, 'gramTable3.csv')
gramTable4File <- paste0(dataDir, 'gramTable4.csv')
gramTable5File <- paste0(dataDir, 'gramTable5.csv')

predict <- function(phrase) {
  textTokens <- tokens(phrase, what='word', remove_numbers=TRUE, remove_punct=TRUE, remove_twitter=TRUE, remove_url = TRUE, remove_symbols = TRUE, n=1, concatenator = " ")
  textTokens <- tokens_tolower(textTokens)[[1]]
  predictedText <- ""
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
      selected <- match[order(-count)]
      if (selected[,.N] > 4) {
        selected <- selected[1:4,]
      }
      predictedText <- unlist(selected[,predict])
      break
    }
  }
  return (predictedText)
}

shinyServer(function(input, output) {
  
  prediction <- reactive({predict(input$phrase)})
  output$distPlot <- renderPlot({
    ggplot(aes(x = carat, y = price), data = diamonds) + 
      geom_point(alpha = 0.5, size = 1, position = 'jitter', aes(color=color)) +
      scale_color_brewer(type = 'div',
                         guide = guide_legend(title = 'Color', reverse = F,
                                              override.aes = list(alpha = 1, size = 2))) +                         
      scale_x_continuous(trans = cuberoot_trans(), limits = c(0.2, 3),
                         breaks = c(0.2, 0.5, 1, 2, 3)) + 
      scale_y_continuous(trans = log10_trans(), limits = c(350, 15000),
                         breaks = c(350, 1000, 5000, 10000, 15000)) +
      ggtitle('Price (log10) by Cube-Root of Carat and Color') +
      geom_hline(yintercept = diamondPrice()[1]/10.0) +
      geom_smooth(method = "lm", se=FALSE, fullrange=TRUE)
  })
    
  output$diamondPrice <- renderText({
    paste0("Your diamond should be priced around $", format(round(diamondPrice()[1], 2), nsmall = 2))
  })
  
})
