#
library(zoo)
library(plyr)
library(data.table)
#
shalookup <- read.csv("~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/sha+pct_lookup.csv", header=T)
sha <- unique(shalookup[,c("SHA","SHAname")])
aList <- sha$SHA
names(aList) <- sha$SHAname
#
shaTables <- read.csv("~/DevLib/ShinyApps/NHSPrescriptions/data/db_tables.csv", header=T)
bList=shaTables$id
names(bList)=shaTables$name
#
shaTable <- fread(input="~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/T201211PDPI+BNFT.csv", header=T)
colName <- c("period","pcode","pname","adr1","adr2","town","county","postcode")
bnfFrame <- read.csv("~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/T201211ADDR+BNFT.csv", header=F,col.names=colName)
bnfTable <- data.table(bnfFrame)
rm(bnfFrame)
