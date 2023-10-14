#Reetika Sindhi
rm(list=ls()) # to remove all the objects from the list (clearing the envt)
setwd(dirname(rstudioapi::getSourceEditorContext()$path)) #setting the working directory 
library(tidyverse) #importing a package

PERMID <- "6832752"
PERMID <- as.numeric(gsub("\\D", "", PERMID))
set.seed(PERMID)

airbnb <- read_csv("airbnb_data.csv", col_names = TRUE)
airbnb = airbnb %>%
  rename("neighborhood" = "neighbourhood")

neighborhoods <- airbnb %>%
  count(neighborhood, sort = TRUE)


neighborhoods= neighborhoods %>%
  filter(!is.na(neighborhood)) %>%
  arrange(desc(n)) %>%
  head(20)


# view(neighborhoods)
airbnb_top_neighborhoods <- airbnb %>%
  filter(neighborhood %in% neighborhoods$neighborhood)

summary_stats_top_neighborhoods <- airbnb_top_neighborhoods %>%
  group_by(neighborhood) %>%
  summarize(avg_square_feet=mean(square_feet, na.rm=T),avg_price=mean(price, na.rm=T), 
            sd_price=sd(price, na.rm=T), max_price=max(price, na.rm=T), min_price=min(price, na.rm=T)) 
 

summary_stats_top_neighborhoods <- summary_stats_top_neighborhoods %>%
  arrange(desc(avg_square_feet))

#view(summary_stats_top_neighborhoods)

highest_avg_square_ft= summary_stats_top_neighborhoods[[1,2]] 

summary_stats_top_neighborhoods<- summary_stats_top_neighborhoods %>% 
  arrange(desc(avg_price))
second_avg_price= summary_stats_top_neighborhoods[[2,3]] 


