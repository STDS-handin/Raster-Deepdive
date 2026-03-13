gdal_result=$(gdal pipeline \
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
          --output /vsistdout/ \
          --overwrite

  )

gdal vector sql \
	--dialect sqlite \
	--sql "SELECT z.value AS kantonsnummer, k.name, z.mean
               FROM $gdal_result z
	       JOIN './data/swissBOUNDARIES3D_1_5_LV95.gpkg'.tlm_kantonsgebiet k
	       ON CAST(z.value AS INTEGER) = k.kantonsnummer
	       WHERE z.value != '0'
	       ORDER BY z.mean DESC" \
	--format CSV \
	--output forest_stats.csv

