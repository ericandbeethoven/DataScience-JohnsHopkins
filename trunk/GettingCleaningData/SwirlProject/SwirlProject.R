###################################################################################
#
# Load Swirl and install Getting and Cleaning Data Course
#
###################################################################################
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()

###################################################################################
#
# Lesson One - Manipulating Data with dplyr
#
###################################################################################
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
head(mydf)
library(dplyr)
cran <- tbl_df(mydf)
rm("mydf")
cran
# Select columns
select(cran, ip_id, package, country) 
select(cran, r_arch:country)
select(cran, country:r_arch)
-(5:20)
select(cran, -(X:size))
# Filter on rows
filter(cran, package == "swirl")
filter(cran, r_version == "3.1.1", country == "US") 
filter(cran, country == "US" | country == "IN") 
filter(cran, size > 100500, r_os == "linux-gnu") 
filter(cran, !is.na(r_version)) 
# arrange sorts rows according to values of particular variable
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id) 
arrange(cran2, country, desc(r_version), ip_id) 
# mutate function to create a new variable based on values of variable
cran3 <- select(cran, ip_id, package, size)
cran3
mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)
mutate(cran3, correct_size = size + 1000)

###################################################################################
#
# Lesson Two - Grouping and Chaining with dplyr
#
###################################################################################
# summarize
summarize(cran, avg_bytes = mean(size))
# group_by
by_package <- group_by(cran, package)
summarize(by_package, mean(size))
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count > 679)
top_counts_sorted <- arrange(top_counts, desc(count))
quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
top_unique_sorted <- arrange(top_unique, desc(unique))


###################################################################################
#
# Lesson Three - Tidying Data with tidyr
#
###################################################################################
library(tidyr)
gather(students, sex, count, -grade)
# gather tidy data column creation
res <- gather(students2, sex_class, count, -grade)
# separate one column into multiple columns
separate(data = res, col = sex_class, into = c("sex", "class"))
