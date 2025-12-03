library(tidyverse);library(here);library(sf)
library(mapview);library(leaflet)
library(terra)

here()
#extract counties & svi data
NCtracts = st_read(here('./Data/Raw/SVI2022_NC_byTract/SVI2022_NC_bytract.shp'))
str(NCtracts)
triangle_counties = c("Durham County","Wake County", "Orange County")
triangle_tracts = NCtracts %>% 
  filter(COUNTY %in% triangle_counties) %>%
  select(COUNTY,
         LOCATION,
         SPL_THEME1, #Sum of series for Socioeconomic Status theme
         RPL_THEME1, #Percentile ranking for Socioeconomic Status theme summary
         SPL_THEME2, #Sum of series for Household Characteristics theme
         RPL_THEME2, #Percentile ranking for Household Characteristics theme summary
         SPL_THEME3, #Sum of series for Racial and Ethnic Minority Status theme
         RPL_THEME3, #Percentile ranking for Racial and Ethnic Minority Status theme
         SPL_THEME4, #Sum of series for Housing Type/ Transportation theme
         RPL_THEME4, #Percentile ranking for Housing Type/ Transportation theme
         SPL_THEMES, #Sum of series themes
         RPL_THEMES  #Percentile ranking overall
         ) %>%
  mutate(COUNTY = as.factor(COUNTY),
         LOCATION = as.factor(LOCATION))
st_crs(triangle_tracts)
mapview(triangle_tracts)

#tree cover
tif_url = "https://github.com/mickeyz875/ENV872FinalProject_Li_Zhang/releases/download/ENV872-FinalProject/triangleTC.tif"
tree_cover = rast(tif_url)
tree_cover
triangle_tracts = st_transform(triangle_tracts, crs = "EPSG:2264")
st_crs(triangle_tracts)
samp = spatSample(tree_cover, size = 1000, method = "random", na.rm = TRUE)
summary(samp)
min(samp); max(samp)

percent_forest_cover = extract(tree_cover,triangle_tracts, fun = mean, na.rm = TRUE)
#triangle_tree_cover = crop(tree_cover, triangle_tracts) 
#triangle_tree_cover = mask(triangle_tree_cover,triangle_tracts)
mapview(triangle_tree_cover)
  







