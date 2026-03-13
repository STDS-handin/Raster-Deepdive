#!/bin/bash

# Step 1: Compute mean forest coverage (%) per canton zone, write to temp CSV.
# A temp file is required here: the CSV driver needs a seekable file,
# so it cannot read from a pipe or /vsistdin/.
gdal pipeline \
  ! read ./data/SWISSTLM3D_2025.gpkg \
  ! rasterize \
      --input-layer tlm_bb_bodenbedeckung \
      --where "objektart='Wald'" \
      --burn 100 --init 0 --nodata 255 \
      --resolution 100,100 \
  ! zonal-stats \
      --zones [ read ./data/swissBOUNDARIES3D_1_5_LV95_LN02.gpkg \
                ! rasterize --resolution 100,100 \
                -a kantonsnummer -l tlm_kantonsgebiet ] \
      --stat mean \
  ! write --output-format CSV \
          --output /tmp/forest_stats.csv \
          --overwrite

# Step 2: Join canton names using gdal vector sql (SQLite cross-datasource join).
# value=0 is the background zone (outside all cantons), so we exclude it.
gdal vector sql \
  --dialect sqlite \
  --sql "SELECT z.value AS kantonsnummer, k.name, z.mean
         FROM forest_stats z
         JOIN './data/swissBOUNDARIES3D_1_5_LV95_LN02.gpkg'.tlm_kantonsgebiet k
           ON CAST(z.value AS INTEGER) = k.kantonsnummer
         WHERE z.value != '0'
         ORDER BY z.mean DESC" \
  --format CSV \
  /tmp/forest_stats.csv \
  /vsistdout/
