library(tidyverse)
library(doMC)
library(vroom)

registerDoMC(4)

base_url <- "http://www2.stat.duke.edu/~sms185/data/bike/"
bike <- foreach(year = 2013:2017, .combine = 'bind_rows') %dopar% {
  this_url <- paste0(base_url, 'cbs_', year, '.csv')
  vroom(this_url)
}
test_url <- paste0(base_url, 'cbs_test.csv')
bike_test <- vroom(test_url)

saveRDS(bike, './Data/bike/bike.Rda')
saveRDS(bike_test, './Data/bike/bike_test.Rda')