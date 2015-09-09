fileUrl = "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
dir.create("data")
download.file(fileUrl, destfile = "./data/cameras.csv", method="wget")
list.files("./data")