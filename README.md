# Native Land Mapbox tileset

Scripts to generate a [Mapbox tileset](https://docs.mapbox.com/mapbox-tiling-service/guides/) using data from [Native-Land.ca Project](https://native-land.ca/) 

- Mapbox tileset: [`planemad.native-boundaries`](https://studio.mapbox.com/tilesets/planemad.native-boundaries/)
- Mapbox style: [Sample style](https://api.mapbox.com/styles/v1/planemad/ckmehe10h1rm317o7qgi6pcnk.html?fresh=true&title=copy&access_token=pk.eyJ1IjoicGxhbmVtYWQiLCJhIjoiemdYSVVLRSJ9.g3lbg_eN0kztmsfIPxa9MQ)

**Layers and data sources**

- Native territory boundaries 
- Native language boundaries
- Native treaty boundaries

### Scripts

**Installation**
- [tilesets-cli](https://github.com/mapbox/tilesets-cli/#installation)
- [jq](https://stedolan.github.io/jq/download/)

**Tileset options**
1. Configure Mapbox account and tileset details in `mapbox-tileset.config`
2. Create the [tileset recipe](https://docs.mapbox.com/mapbox-tiling-service/reference/) in `tileset-recipe.json`

**Usage**
1. `./data.sh` to download and process the raw data sources into gpkg and line delimited geojson
2. `./tileset.sh upload` to upload/replace the data sources to your Mapbox account
3. `./tileset.sh create` to create and publish the tileset for the first time
4. `./tileset.sh update` to update the tileset with any recipe or data changes