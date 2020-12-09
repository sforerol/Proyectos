library(tidyverse)
library(rvest)
library("writexl")
url <- "https://finance.yahoo.com/quote/GE/history?period1=1448668800&period2=1606521600&interval=div%7Csplit&filter=div&frequency=1d&includeAdjustedClose=true"
h <- read_html(url)
tab <- h %>% html_nodes("table")
table <- tab %>% html_table(fill = TRUE)
tabledf <- data.frame(table)
endrow <- nrow(tabledf)-1
tabledf <- tabledf[1:endrow,1:2]
dates <- tabledf[,1]
dividends <-gsub(" .*$","",tabledf[,2])
dividends <- as.numeric(dividends)
exportTable <- data.frame(Dates = dates, Dividends = dividends)
write_xlsx(exportTable,"C:/Users/Sergio/Documents/Documents/Dividend/DividendTable.xlsx")

