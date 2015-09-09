# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Bastiaan Quast
# bquast@gmail.com


# write the file url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
file.dest <- 'ACS.csv'

# download from the URL
download.file(file.url, file.dest,)

# read the data
ACS <- read.csv('ACS.csv')

# create vector
ACS$agricultureLogical <- ifelse(ACS$ACR==3 & ACS$AGS==6,TRUE,FALSE)

# read lines
which(ACS$agricultureLogical)

# QUESTION 2
# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Bastiaan Quast
# bquast@gmail.com

# write the file url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
file.dest <- 'jeff.jpg'

# download from the URL
download.file(file.url, file.dest, mode='wb' )

# load package
library(jpeg)

# load the data
picture <- readJPEG('jeff.jpg', native=TRUE)

# get the quantile info
quantile(picture, probs = c(0.3, 0.8) )

# QUESTION 3
# write the file url and file destination to an object
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
file.dest <- 'GDP.csv'

# download from the URL
download.file(file.url, file.dest )

# specify the right lines
rowNames <- seq(10,200, 2)

# read the data
gdp <- read.csv('GDP.csv', header=F, skip=5, nrows=190)
View(gdp)

# second data file
file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
file.dest <- 'GDP2.csv'

# download from the URL
download.file(file.url, file.dest )

# read second file
fed <- read.csv('GDP2.csv')
View(fed)

# merge datasets
combined <- merge(gdp, fed, by.x='V1', by.y='CountryCode', sort=TRUE)
View(combined)

# Q3.
# sort the data
combined[with(combined, order(-V2) )]

# Q4.
# OECD
mean(combined[combined$Income.Group=='High income: OECD',]$V2)
# non OECD
mean(combined[combined$Income.Group=='High income: nonOECD',]$V2)

# Q5.
# assign quentile values
quentile <- c(0.2,0.4,0.6,0.8,1)
q <- quantile(combined$V2, quentile)
q1 <- combined$V2 <= 38

xtabs(q1 ~ combined$Income.Group)

