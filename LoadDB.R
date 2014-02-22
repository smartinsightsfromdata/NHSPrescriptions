library(MonetDB.R)
#remove.packages("MonetDB.R")
#
source("global.R")
#
port <- 50001
dbfold <- "dbfold1"
maindb <- "NHS0"
unlink(paste0(getwd(),"/",dbfold,"/"), recursive = TRUE)
paste0(getwd(),"/",dbfold)
pid <- cMonetDB(dbfold,maindb,port)
conn <- dbConnect(MonetDB.R(),paste0("monetdb://localhost:",port,"/",maindb) )
#
#
filed <- "sha_lookup.csv"
tabled <- "sha_lookup"
fnamed <- file.path(getwd(),"data",filed)
#
nrows <- 12
monetdb.read.csv(conn,fnamed,nrows=nrows, tablename=tabled,newline="\n")
##
##
filed <- "T201211PDPI+BNFT.CSV"
tabled <- "T201211P"
nrows <- 10074500
#
fnamed <- file.path(getwd(),"data",filed)
##fname <- file.path(getwd(),filed)
##fname
##shalookup <- read.csv(fnamed, header=T)
##write.table(shalookup, fname, sep=",")
library(data.table)
ddframe <- fread(input="~/DevLib/ShinyApps/NHSPrescriptions/data/T201211PDPI+BNFT.csv", nrows=0,header=T)
#
ddframe <- fread(input="~/DevLib/ShinyApps/NHSPrescriptions/data/T201211PDPI+BNFT.csv", nrows=nrows,header=T)
ddframe[,11] <- NULL
#ddframe$spr <- NULL
str(ddframe)
write.csv(ddframe,paste0(getwd(),"/data/",tabled,".csv"),quote=FALSE)
#a <- fread(input=paste0(getwd(),"/data/",tabled,".csv"), nrows=100,header=T)
monetdb.read.csv(conn,paste0(getwd(),"/data/",tabled,".csv"),nrows=nrows,header=TRUE,tablename=tabled,delim=",")

file.remove(fname)
remove(filed)
tablex <- monet.frame(connx,tablex)
#
#
monetdb.read.csv(conn,file.path(getwd(),"data","T201211PDPI+BNFT.CSV"),nrows=1000000,"T201211P")
)
                 T201211P <- monet.frame(conn,"T201211P")
#
#
monetdb.read.csv(conn,"~/Dropbox/DevLib/ShinyApps/NHSPrescriptions/data/T201211ADDR+BNFT.CSV",nrows=1000,"T201211ADDR")
T201211A <- monet.frame(conn,"T201211A")
#
closedb(conn,pid,port)

#file.remove(fold1,recursive=TRUE)
dbListTables(conn)
##
##
file <- tempfile()
write.table(iris, file, sep=",")
dbWriteTable(conn,"iris",iris)
monetdb.read.csv(conn, file, "iris", 150)
# create table and import CSV
dfmIris <- monet.frame(conn,"iris")
str(dfmIris)
dbGetQuery(conn, "SELECT * FROM t201211p;")
dbSendQuery(conn, "DROP TABLE t201211p;")
str(res)
dbListFields(conn,"iris")
#
dbDisconnect(conn)
#
monetdb.server.stop(pid)
##
#dbfold <- "mydbfarm"
#maindb <- "NHSpdb"
#pid <- cMonetDB(dbfold,maindb,port)
##
install.packages("~/Downloads/MonetDB.R_0.9.tar", repos = NULL, type = "source")

