# ENV872FinalProject_Li_Zhang

## Summary

This repository contains data, scripts, and analyses for the project “Social Vulnerability and Forest Cover in the Triangle Area,North Carolina.”
Understanding this relationship helps reveal whether communities with higher social vulnerability—based on socioeconomic, demographic, and housing factors—have less access to forest cover or green space, a key environmental equity and resilience concern.

The project uses geospatial analysis and regression modeling in R to:
  - Calculate mean percent tree canopy cover per county.
  - Examine correlations between SVI scores and forest cover.
  - Map spatial patterns of social vulnerability and canopy cover.

Data sources include the Social Vulnerability Index (2022) and NC Tree Canopy Cover (2016).

## Investigators

Shu'er Li \
MEM Candidate'27 \
Nicholas School of the Environment, Duke University \
shuer.li@duke.edu \
Role:  responsible for data analysis and visualization.

Mickey Zhang \
MEM Candidate' 25  \
Nicholas School of the Environment, Duke University \
mickey.zhang@duke.edu \
Role: responsible for data processing and wrangling, and documentation. 

John Fay & Luana Lima \
ENV 872 – Environmental Data Analytics instructors  \
Role: project advisors

## Keywords

Environmental justice, social vulnerability, forest cover, tree canopy, land cover, GIS, North Carolina, environmental data analytics, spatial analysis

## Database Information

1. 2016 Forest Land Cover (NC OneMap / NCDA&CS): Access on December 2 2025, via NC OneMap data portal’s “Forest Land Cover 2016” dataset (https://www.nconemap.gov/datasets/ncagr::forest-land-cover-2016/explore?location=35.033142%2C-); download raster or geodatabase layers as needed for North Carolina. 
https://github.com/mickeyz875/ENV872FinalProject_Li_Zhang/releases/triangleTC.zip


2. Social Vulnerability Index (CDC/ATSDR): Access on December 2 2025, via the CDC/ATSDR SVI data download page (https://www.atsdr.cdc.gov/place-health/php/svi/svi-interactive-map.html); select “United States” or “North Carolina” for geography; download CSV or shapefile containing SVI scores.

## Folder structure, file formats, and naming conventions 

ENV872FinalProject_Li_Zhang/ \
├── Data/ \
│   ├── raw/                  # Unmodified original downloads \
│   └── processed/            # Final analysis-ready datasets \
├── Scripts/ \
│   ├── DataProcessing & Wrangling.R        # cleaning, reprojection, extraction \
│   └── Analysis.R                          # models, statistics, and plotting code \
├── Outputs/                  # RMD/HTML reports \
├── Docs/                     # Project rubric,sample project, data provenance notes \
├── .gitignore \
└── README.md \

## Metadata

This repository contains one raw spatial dataset and one processed tabular dataset used to analyze the relationship between social vulnerability and tree canopy cover in the North Carolina Triangle region.

Raw Data:

1. Social Vulnerability Index (SVI) 2022 — Census Tract Shapefile

    I. File path:`Data/Raw/SVI2022_NC_byTract/`

    II. Files included:
  - `SVI2022_NC_bytract.shp`  
  - `SVI2022_NC_bytract.dbf`  
  - `SVI2022_NC_bytract.shx`  
  - `SVI2022_NC_bytract.prj`  
  - `SVI2022_NC_bytract.cpg`  
  - `SVI2022_NC_bytract.sbn`  
  - `SVI2022_NC_bytract.sbx`  
  - `SVI2022_NC_bytract.shp.xml`  
  - `SVI2022Documentation_ZCTA.pdf`

    III. Source: Centers for Disease Control and Prevention (CDC) / Agency for Toxic Substances and Disease Registry (ATSDR), Social Vulnerability Index (SVI) 2022.

    IV. Description: This spatial dataset contains census-tract-level Social Vulnerability Index (SVI) metrics for the state of North Carolina. Each tract is represented as a polygon with associated demographic and socioeconomic indicators summarized as percentile rankings.

    V. Variables used in this project:

| Column name | Description | Data type | Units |
|------------|------------|----------|-------|
| COUNTY | County name | character / factor | N/A |
| LOCATION | Census tract identifier (CDC label) | character / factor | N/A |
| RPL_THEME1 | Theme 1 percentile: Socioeconomic Status | numeric | 0–1 |
| RPL_THEME2 | Theme 2 percentile: Household Composition & Disability | numeric | 0–1 |
| RPL_THEME3 | Theme 3 percentile: Minority Status & Language | numeric | 0–1 |
| RPL_THEME4 | Theme 4 percentile: Housing Type & Transportation | numeric | 0–1 |
| RPL_THEMES | Overall Social Vulnerability percentile | numeric | 0–1 |
| geometry | Census tract polygon geometry | sf geometry | meters (projected CRS) |

    VI. Notes:
  - Percentile values range from 0 (lowest vulnerability) to 1 (highest vulnerability).
  - Missing values in the original dataset are coded as `-999` and are converted to `NA` during data preparation.
  - Only census tracts from **Durham County, Wake County, and Orange County** are used in this analysis.

Processed Data:

2. Mean Percent Tree Canopy Cover by Census Tract

    I. File path: `Data/Processed/triangle_percent_tree_cover.csv`

    II. Description: This processed dataset contains mean tree canopy cover values extracted for each census tract in the Triangle region. Values were derived by spatially averaging a 30-meter resolution tree canopy raster within census tract boundaries.

    III. Variables:

| Column name | Description | Data type | Units |
|------------|------------|----------|-------|
| OBJECTID_First | Unique identifier generated during spatial extraction | integer | N/A |
| COUNT | Number of raster cells used in the extraction | numeric | cells |
| AREA | Total area used in extraction | numeric | square meters |
| MEAN | Mean proportion of tree canopy cover within the tract | numeric | proportion (0–1) |

    IV. Notes:
  - The `MEAN` column represents the final percent tree canopy variable used in statistical analysis.
  - This dataset is joined to the SVI tract-level data during analysis using row order correspondence.

Derived Analysis Dataset:

A final analysis-ready dataset is created in R by merging the SVI tract-level data with the processed tree canopy cover data and removing spatial geometry. This dataset is not saved as a separate file but is generated reproducibly within the analysis scripts.

## Scripts and code
- DataProcessing & Wrangling.R  contains codes for data cleaning, reprojection, extraction
- Analysis.R   contains codes for data analysis and visualization
