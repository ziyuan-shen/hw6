library(tidyverse)
library(jsonlite)
library(httr)

darksky_key <- fromJSON("api_keys.json")$darksky_key

dc_lat <- 38.9072
dc_long <- -77.0369
# Loop over all possible dates from 2013 - 2018
days <- seq(as.Date("2013-01-01"), as.Date("2018-12-31"), by = 1)

ds_urls <- str_c("https://api.darksky.net/forecast/", darksky_key, "/",
                 dc_lat, ",", dc_long, ",", days[1100], "T12:00:00")

# List of JSON files, strung together in a list
queries <- map(ds_urls, function(url) {
  Sys.sleep(0.1)
  content(GET(url)) })

# Save each day's query as a separate RDS
file_names <- str_c("./Data/darksky/darksky_", days)
for (i in seq_along(file_names)) {
  saveRDS(object = queries[[i]], file = file_names[i])
}