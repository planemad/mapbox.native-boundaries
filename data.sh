#!/usr/bin/env bash

# https://native-land.ca/ Native-Land.ca indigenous territory, languages and treaty boundaries
# License: `CC-by <a href='hhttps://native-land.ca/resources/api-docs/'>Native-Land.ca</a>`

# Create output directories
mkdir -p data/raw
mkdir -p data/processed

#
# Layer 1
#

layer_name="native_territory_boundaries"
datasource_url=https://native-land.ca/coordinates/indigenousTerritories.json

echo "Generating data layer: $layer_name"
echo "Downloading data from $datasource_url -> data/raw/$layer_name.gpkg"

# Raw data
curl $datasource_url > data/raw/$layer_name.geojson

# convert to GPKG
ogr2ogr data/raw/$layer_name.gpkg data/raw/$layer_name.geojson \
    -nln $layer_name 

# transform the GPKG
ogr2ogr data/processed/$layer_name.gpkg data/raw/$layer_name.gpkg \
    -nlt MULTIPOLYGON \
    -dialect sqlite -sql \
    "SELECT \
        *
    FROM \"$layer_name\""

# Export to line delimited geojson
ogr2ogr data/processed/$layer_name.geojsonl data/processed/$layer_name.gpkg

#
# Layer 2
#

layer_name="native_language_boundaries"
datasource_url=https://native-land.ca/coordinates/indigenousLanguages.json

echo "Generating data layer: $layer_name"
echo "Downloading data from $datasource_url -> data/raw/$layer_name.gpkg"

# Raw data
curl $datasource_url > data/raw/$layer_name.geojson

# convert to GPKG
ogr2ogr data/raw/$layer_name.gpkg data/raw/$layer_name.geojson \
    -nln $layer_name 

# transform the GPKG
ogr2ogr data/processed/$layer_name.gpkg data/raw/$layer_name.gpkg \
    -nlt MULTIPOLYGON \
    -dialect sqlite -sql \
    "SELECT \
        *
    FROM \"$layer_name\""

# Export to line delimited geojson
ogr2ogr data/processed/$layer_name.geojsonl data/processed/$layer_name.gpkg

#
# Layer 3
#

layer_name="native_treaty_boundaries"
datasource_url=https://native-land.ca/coordinates/indigenousTreaties.json

echo "Generating data layer: $layer_name"
echo "Downloading data from $datasource_url -> data/raw/$layer_name.gpkg"

# Raw data
curl $datasource_url > data/raw/$layer_name.geojson

# convert to GPKG
ogr2ogr data/raw/$layer_name.gpkg data/raw/$layer_name.geojson \
    -nln $layer_name 

# transform the GPKG
ogr2ogr data/processed/$layer_name.gpkg data/raw/$layer_name.gpkg \
    -nlt MULTIPOLYGON \
    -dialect sqlite -sql \
    "SELECT \
        *
    FROM \"$layer_name\""

# Export to line delimited geojson
ogr2ogr data/processed/$layer_name.geojsonl data/processed/$layer_name.gpkg