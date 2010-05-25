require 'formula'
require 'date'

class Mapnik2 <Formula
  head 'http://svn.mapnik.org/trunk/', :using => :svn
  homepage 'http://mapnik.org'

  depends_on 'icu4c'
  depends_on 'boost'
  depends_on 'proj'
  depends_on 'jpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'gdal'
  depends_on 'postgis'
  depends_on 'sqlite'
  depends_on 'scons'

  
  def options
    [
      ["--with-cairo", "Enables the Cairo rendering backend"]
    ]
  end

  if ARGV.include? '--with-cairo'
    depends_on 'pkg-config'
    depends_on 'cairo'
    depends_on 'cairomm'
  end   
  
  def install

    if ARGV.include? '--with-cairo'
      system "scons",
              "CAIRO=True",
              "JOBS=#{Hardware.processor_count}",
              "OPTIMIZATION=3",
              "INPUT_PLUGINS=shape,raster,gdal,postgis,ogr,sqlite,osm",
              "configure"    
    else
      system "scons",
              "CAIRO=False",
              "JOBS=#{Hardware.processor_count}",
              "OPTIMIZATION=3",
              "INPUT_PLUGINS=shape,raster,gdal,postgis,ogr,sqlite,osm",
              "configure"        
    end
  
    system "scons install"

  end

end
