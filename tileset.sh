#!/usr/bin/env bash

#
# Script to create and manage a Mapbox tileset using Mapbox Tiling Service
# https://docs.mapbox.com/mapbox-tiling-service/
#
# Usage
# ./tileset.sh <action> [<layer>]
# 
# actions: info upload create update view
# layer: layer name as specified in the tileset-recipe.json

source mapbox-tileset.config

recipe_json=tileset-recipe.json
mapbox_tileset_id=$mapbox_username.$tileset_id
default_layer_name=$(cat $recipe_json| jq '.layers | keys[0]' -r)

action="${1:-info}"
layer="${2:-$default_layer_name}"

mapbox_source_id=$layer

# View tileset info
if [[ $action = "info" ]]
then
    echo "Tileset id: $mapbox_tileset_id"
    echo "$tileset_name : $tileset_description"
    echo "$tileset_attribution"
    echo "Tileset layers:"
    cat $recipe_json| jq '.layers | keys'
fi

# Creating Mapbox source data
if [[ $action = "upload" ]]
then
    tilesets upload-source $mapbox_username $mapbox_source_id "data/processed/${layer}.geojsonl" --no-validation --replace
fi

# Create and publish tileset
if [[ $action = "create" ]]
then
    tilesets create $mapbox_tileset_id --recipe $recipe_json \
        --name "$tileset_name" \
        --description "$tileset_description" \
        --privacy=$tileset_privacy \
        --attribution="$tileset_attribution"

    tilesets publish $mapbox_tileset_id
fi

# Update recipe
if [[ $action = "update" ]]
then
    tilesets update $mapbox_tileset_id \
        --name "$tileset_name" \
        --description "$tileset_description" \
        --privacy=$tileset_privacy \
        --attribution="$tileset_attribution"

    # tilesets update-recipe $mapbox_tileset_id $recipe_json && tilesets publish $mapbox_tileset_id
fi

# View tileset source
if [[ $action = "view" ]]
then
  tilesets view-source $mapbox_username $mapbox_source_id
fi




