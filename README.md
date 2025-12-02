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

Shu'er Li 
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
├── Outputs/                  # RMD/PDF reports \
├── Docs/                     # Project rubric,sample project, data provenance notes \
├── .gitignore \
└── README.md \

## Metadata
<For each data file in the repository, describe the data contained in each column. Include the column name, a description of the information, the class of data, and any units associated with the data. Create a list or table for each data file.>

## Scripts and code
- DataProcessing & Wrangling.R  contains codes for data cleaning, reprojection, extraction
- Analysis.R   contains codes for data analysis and visualization
