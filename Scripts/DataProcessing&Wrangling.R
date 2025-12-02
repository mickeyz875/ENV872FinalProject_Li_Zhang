library(tidyverse);library(here);library(sf)
library(mapview);library(leaflet)

here()
NCtracts = st_read(here('./Data/Raw/SVI2022_NC_byTract/SVI2022_NC_bytract.shp'))
st_crs(NCtracts)