# Example OTP Configuration

This directory should contain your transit data files:

## Required Files

### GTFS Files
- General Transit Feed Specification files (*.zip)
- Contains transit schedules, routes, stops, etc.
- Example: `agency-gtfs.zip`

### OSM Files
- OpenStreetMap data (*.osm.pbf)
- Contains street network data
- Example: `region.osm.pbf`

## Getting Data

### GTFS Data
- Check your local transit agency's website for GTFS feeds
- Many agencies provide open data portals with GTFS downloads

### OSM Data
- Download from [Geofabrik](https://download.geofabrik.de/)
- Choose the region/country relevant to your transit data

## Example Structure

```
data/
├── agency-gtfs.zip
└── region.osm.pbf
```

## First Time Setup

When you first start OTP with data:

1. OTP will build a routing graph from your data (this can take several minutes)
2. The graph will be cached for faster subsequent startups
3. Once built, the API will be available at http://localhost:8080

## Notes

- Building graphs requires significant memory (4GB+ recommended)
- Larger datasets (major cities/regions) may require 8GB+ RAM
- Graph building is a one-time process per dataset
