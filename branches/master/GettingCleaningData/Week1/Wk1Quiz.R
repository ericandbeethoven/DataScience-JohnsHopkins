# ++++++++++++++++++++++++++++++++++
# Q1
# ++++++++++++++++++++++++++++++++++
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# dir.create("data")
download.file(fileUrl, destfile = "./data/properties.csv", method="wget")
list.files("./data")
propertiesData = read.table("./data/properties.csv", sep=",", header=TRUE)
Above1MIL = subset(propertiesData, VAL > 23)

# ++++++++++++++++++++++++++++++++++
# Q3
# ++++++++++++++++++++++++++++++++++
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/FDATA_gov_NGAP.xlsx", method="wget")
list.files("./data")
# load the package to read xlsx files
library(xlsx)

# specify the rows and columns to import
rowIndex <- 18:23
colIndex <- 7:15

# read the xlsx file
dat <- read.xlsx("./data/FDATA_gov_NGAP.xlsx", sheetIndex=1, rowIndex = rowIndex, colIndex = colIndex)

# perform the required test
sum(dat$Zip*dat$Ext,na.rm=T)


# ++++++++++++++++++++++++++++++++++
# Q4
# ++++++++++++++++++++++++++++++++++
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml", method='wget')
list.files("./data")
# load the XML package
library(XML)

# read the XML file
doc <- xmlTreeParse('.data/restaurants.xml', useInternalNodes = TRUE)

# define the rootnode
rootNode <- xmlRoot(doc)

# write the zipcode data to a list
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)

# table the zipcodes
table(zipcode)[['21231']]


# ++++++++++++++++++++++++++++++++++
# Q5
# ++++++++++++++++++++++++++++++++++
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/Fss06pid.csv", method='wget')
list.files("./data")

# load the data.table package
library(data.table)

# read the data
DT <- fread('./data/Fss06pid.csv')


# time the processes
# ERRORrowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
# WRONG O/P mean(DT$pwgtp15,by=DT$SEX)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])

