#
library(zoo)
library(plyr)
#
shalookup <- read.csv("~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/sha+pct_lookup.csv", header=T)
sha <- unique(shalookup[,c("SHA","SHAname")])
aList <- sha$SHA
names(aList) <- sha$SHAname
#
db.tables=read.csv("~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/db_tables.csv", header=T)
bList=db.tables$id
names(bList)=db.tables$name
