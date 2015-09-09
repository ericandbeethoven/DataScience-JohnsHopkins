##############################
# MY SQL
##############################
library(RMySQL)
hg19 = dbConnect(MySQL(), user="genome",
                   db="hg19",
                   host="genome-mysql.cse.ucsc.edu")
# result=dbGetQuery(ucscDb, "show databases;"); 
allTables = dbListTables(hg19)
length(allTables)
allTables[1:5]
dbDisconnect(hg19)
# dbDisconnect(ucscDb)
# result

##############################
# HDF5
##############################
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created=h5createFile("example.h5")
created