library(tidyverse)
library(rvest)

url <- "https://finance.yahoo.com/quote/SPSM/history?period1=1448668800&period2=1606521600&interval=div%7Csplit&filter=div&frequency=1d&includeAdjustedClose=true"
h <- read_html(url)
tab <- h %>% html_nodes("table")
table <- tab %>% html_table(fill = TRUE)
tabledf <- data.frame(table)
tabledf <- tabledf[1:21,1:2]
dates <- tabledf[,1]
dividends <-gsub(" .*$","",tabledf[,2])
dividends <- as.numeric(dividends)
exportTable <- data.frame(Dates = dates, Dividends = dividends)


