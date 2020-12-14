arg <- commandArgs(trailingOnly = TRUE)
library(tidyverse)
library(rvest)
library("writexl")
segment1 <- "https://finance.yahoo.com/quote/"
segment2 <- "/history?period1="
segment3 <- "&period2="
segment4 <- "&interval=div%7Csplit&filter=div&frequency=1d&includeAdjustedClose=true"
initialDate <- as.character(as.numeric(as.POSIXct(arg[1])))
finalDate <- as.character(as.numeric(as.POSIXct(arg[2])))
symbol <- arg[3]
url <- gsub(" ", "", paste(segment1,symbol,segment2,initialDate,segment3,finalDate,segment4)) 
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

