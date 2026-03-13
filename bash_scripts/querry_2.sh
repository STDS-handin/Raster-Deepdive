gdal vector rasterize --where "objektart='Wald'" \
       	-l tlm_bb_bodenbedeckung \
	--resolution 100,100 \
      	--input ./data/SWISSTLM3D_2025.gpkg \
	--overwrite \
	--nodata 255 \
	--init 0 \
	--burn 1 \
       	--output ./data/forest_raster
