gdal raster zonal-stats --input ./data/forest_raster_cent \
       	--zones ./data/kantone_raster \
	--stat=mean \
	--overwrite \
	--output ./data/cantonal_forest_proportion.csv

