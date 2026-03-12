gdal vector rasterize -l tlm_kantonsgebiet \
       	--resolution 100,100 \ # The resolution of the cells (here 100x100 meters
      	--input ./data/swissBOUNDARIES3D_1_5_LV95_LN02.gpkg \ # input file
	-a kantonsnummer \ # value to burn
       	--overwrite \ # states, that overwriting is ok, if kantone_raster exists
	--output ./data/kantone_raster # output file
	




