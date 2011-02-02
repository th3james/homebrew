require 'formula'

class Mapnik2 <Formula
  head 'http://svn.mapnik.org/trunk/', :using => :svn
  homepage 'http://mapnik.org'

  # build dependency
  depends_on 'scons'
  
  # core dependencies
  depends_on 'libpng'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'proj'
  depends_on 'icu4c'
  depends_on 'boost'
  
  # Mapnik will build plugins for these optional dependencies if they exist.
  # if not it will skip. Seems safer to not enforce these, as users may want
  # to build against Framework versions provided by http://www.kyngchaos.com/
  # Todo - put in caveat...
  #depends_on 'gdal'
  #depends_on 'postgis'
  #depends_on 'sqlite'
  
  def options
    [
      ["--with-cairo", "Enables the Cairo rendering backend"]
    ]
  end

  if ARGV.include? '--with-cairo'
    depends_on 'pkg-config'
    depends_on 'cairomm'
  end   
  
  def install
    icu = Formula.factory "icu4c"

    configure_args = [
      "JOBS=#{Hardware.processor_count}",
      "OPTIMIZATION=3",
      "ICU_LIBS=#{icu.lib}",
      "ICU_INCLUDES=#{icu.include}",
      "INPUT_PLUGINS=shape,raster,gdal,postgis,ogr,sqlite,osm",
      "PGSQL2SQLITE=True",
      "configure"
      ]
    
    if ARGV.include? '--with-cairo'
      configure_args << "CAIRO=True"
    else
      configure_args << "CAIRO=False"
    end
    
    system "scons", *configure_args
    system "scons install"

  end
end
