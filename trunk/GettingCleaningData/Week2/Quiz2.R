#####################
# Q1
#####################
ghToken = "2323c3df3a356b26b58e21a80e10079a3d8bdd23"
ibrary(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#

#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", key=ghToken, secret="ef33989a51346e93a46ceecc743e6e302fdfe953")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/users/jtleek/repos")
stop_for_status(req)
a <- content(req)

#####################
# Q2 & 3
#####################
myUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
acs = read.csv(myUrl)
summary(acs)
# load the package to read xlsx files
library(sqldf)

sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select distinct AGEP from acs")

DF <- data.frame(a = 1:8, g = gl(2, 4))
out <- sqldf("select group_concat(a) groupa from DF group by g")
out

##############################
# Q4
##############################
# readLines()
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode=readLines(con)
close(con)
htmlCode
mynchar = c(nchar(htmlCode[10]), nchar(htmlCode[20]),nchar(htmlCode[30]),nchar(htmlCode[100]))
mynchar


##############################
# Q5
##############################
x <- read.fwf(
  file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(x$V4)+sum(x$V5)

file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for'
file.dest <- 'getdata.for'

# download from the URL
download.file(file.url, file.dest)

# load the data
getdata <- read.fwf('getdata.for', skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))

# inspect data
head(getdata)

# calculate sum for column 4
sum(getdata$V4)




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

##############################
# Reading from web (eg HTML)
##############################

# readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode=readLines(con)
close(con)
htmlCode

# Parsing with XML
library(XML)
url = "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html = htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)

# GET from httr package
library(httr)
html2 = GET(url)
content2 = content(html2, as="text")


##############################
# apis
##############################
myapp = oauth_app()
sig = sign_oauth2.0(myapp)


##############################
# Other data sources
##############################
# foreign package loads data from Matlab, SASS, Octave, et al
# ?connections for more info

