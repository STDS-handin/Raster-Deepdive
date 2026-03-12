gdal vector rasterize -l tlm_kantonsgebiet --resolution 100,100  --input ./data/swissBOUNDARIES3D_1_5_LV95_LN02.gpkg --output ./data/kantone_BOUNDARIES
gdal vector rasterize -l tlm_kantonsgebiet --resolution 100,100  --input ./data/swissBOUNDARIES3D_1_5_LV95_LN02.gpkg --output ./data/kantone_raster
gdal vector rasterize --where objektart=Wald -l tlm_bb_bodenbedeckung --resolution 100,100  --input ./data/SWISSTLM3D_2025.gpkg --output ./data/forest_rasters
