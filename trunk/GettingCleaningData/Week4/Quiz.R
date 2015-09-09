# Question 1

# download data
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
file.dest <- 'ACS4.csv'
download.file(file.url, file.dest)

# load the data
ACS <- read.csv(file.dest)

# extract names
names <- names(ACS)

# string split
strsplit(names, 'wgtp')[123]

# Question 2
# download data
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
file.dest <- 'GDP4.csv'
download.file(file.url, file.dest, method='wget')

# read the data
GDP <- read.csv(file.dest, skip=4, nrows=190)

# substitute comma's out
GDPdol <- gsub(",", "", GDP$X.4)

# convert to integer and calculate mean
GDPdol <- as.integer(GDPdol)
mean(GDPdol, na.rm=TRUE)

# Question 3
# attach the GDP data frame
attach(GDP)
grep("^United",GDP$V4)

# Question 4

# download data and load it
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
file.dest <- 'GDP4.csv'
download.file(file.url, file.dest, method='wget')
GDP <- read.csv(file.dest, skip=4, nrows=190)
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
file.dest <- 'edu.csv'
download.file(file.url, file.dest, method='wget')
edu <- read.csv(file.dest)

# merge the datasets
merged <- merge(GDP, edu, by.x = 'X', by.y = 'CountryCode')

# extract the information
fy.june <- grep('Fiscal year end: June', merged$Special.Notes)
length(fy.june)

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 


# create logical for year 2012
year2012 <- grepl('2012-*', sampleTimes)

# count 2012 observations (i.e. true)
table(year2012)

# subset based on 2012
sampleTimes2012 <- subset(sampleTimes, year2012)

# convert to day of week
day <- format(sampleTimes2012, '%A')

# count each day
table(day)

