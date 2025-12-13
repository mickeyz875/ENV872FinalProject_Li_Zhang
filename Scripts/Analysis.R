# 1. Load required packages
library(tidyverse)
library(here)
library(sf)
library(mapview)
library(terra)

# 2. Load processed datasets
# Load SVI shapefile (raw geometry)
NCtracts <- st_read(
  here("Data/Raw/SVI2022_NC_byTract/SVI2022_NC_bytract.shp"),
  quiet = TRUE
)

triangle_counties <- c("Durham County", "Wake County", "Orange County")

triangle_tracts <- NCtracts %>%
  filter(COUNTY %in% triangle_counties) %>%
  select(
    COUNTY, LOCATION,
    RPL_THEME1, RPL_THEME2, RPL_THEME3, RPL_THEME4,
    RPL_THEMES
  ) %>%
  mutate(
    COUNTY = as.factor(COUNTY),
    LOCATION = as.factor(LOCATION)
  )

# Load processed canopy extraction results
canopy_df <- read.csv(
  here("Data/Processed/triangle_percent_tree_cover.csv")
)

# Attach canopy values
triangle_tracts$percent_canopy <- canopy_df$MEAN

# Drop geometry for modeling
triangle <- triangle_tracts %>%
  st_drop_geometry()

# Replace CDC missing values (-999) with NA
triangle$RPL_THEME1[triangle$RPL_THEME1 < 0] <- NA
triangle$RPL_THEME2[triangle$RPL_THEME2 < 0] <- NA
triangle$RPL_THEME3[triangle$RPL_THEME3 < 0] <- NA
triangle$RPL_THEME4[triangle$RPL_THEME4 < 0] <- NA
triangle$RPL_THEMES[triangle$RPL_THEMES < 0] <- NA

# 3. Exploratory Data Analysis (EDA)

## 3.1 Spatial visualization
mapview(
  triangle_tracts,
  zcol = "percent_canopy",
  layer.name = "Mean Percent Tree Canopy (0–1)"
)

## 3.2 Distribution of percent tree canopy
ggplot(triangle, aes(x = percent_canopy)) +
  geom_histogram(
    bins = 30,
    fill = "forestgreen",
    color = "black",
    alpha = 0.7
  ) +
  labs(
    x = "Percent Tree Canopy (0–1)",
    y = "Number of Census Tracts",
    title = "Distribution of Mean Tree Canopy Cover"
  )

## 3.3 Distribution of social vulnerability
ggplot(triangle, aes(x = RPL_THEMES)) +
  geom_histogram(
    bins = 30,
    fill = "steelblue",
    color = "black",
    alpha = 0.7
  ) +
  labs(
    x = "Overall Social Vulnerability Index (0–1)",
    y = "Number of Census Tracts",
    title = "Distribution of Social Vulnerability (RPL_THEMES)"
  )

## 3.4 Bivariate relationship: SVI vs canopy
ggplot(triangle, aes(x = RPL_THEMES, y = percent_canopy)) +
  geom_point(alpha = 0.7, color = "darkslategray") +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    x = "Overall Social Vulnerability Index (0–1)",
    y = "Percent Tree Canopy (0–1)",
    title = "Relationship Between Social Vulnerability and Tree Canopy"
  )

# 4. Statistical Analysis

## 4.1 Linear regression model
model <- lm(percent_canopy ~ RPL_THEMES, data = triangle)

# View regression summary
summary(model)

## 4.2 Model diagnostics
par(mfrow = c(2, 2))
plot(model)
par(mfrow = c(1, 1))
