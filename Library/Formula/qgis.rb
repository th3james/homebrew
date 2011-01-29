require 'formula'

class Qgis <Formula
  url 'http://qgis.org/downloads/qgis-1.6.0.tar.bz2'
  homepage 'http://qgis.org/'
  md5 '9ea8a784d970f5009b0e6271820248f6'

  depends_on 'cmake' => :build
  depends_on 'postgis'
  depends_on 'python' if ARGV.include? "--framework --universal"
  depends_on 'qt'
  depends_on 'gdal'
  depends_on 'geos'
  depends_on 'proj'
  depends_on 'sqlite'
  depends_on 'libspatialite' => :optional # causing problems, switched to internal lib
  depends_on 'libiconv' => :optional
  depends_on 'gsl'
  depends_on 'pyqt'
  depends_on 'sip'
  depends_on 'qwt'
  # not yet in homebrew available: depends_on 'pyqwt'

  def install
    geos = Formula.factory 'geos'
    gdal = Formula.factory 'gdal'
    python = Formula.factory 'python'
    
    system "cmake -DCMAKE_INSTALL_PREFIX=~/Applications -DCMAKE_BUILD_TYPE=Release -DCMAKE_BUILD_TYPE=MinSizeRel -DWITH_INTERNAL_SPATIALITE=TRUE -DGEOS_INCLUDE_DIR=#{geos.include} -DGEOS_LIBRARY=#{geos.lib}/libgeos_c.dylib -DGDAL_INCLUDE_DIR=#{gdal.include} -DGDAL_LIBRARY=#{gdal.lib}/libgdal.dylib -DPYTHON_EXECUTABLE=#{python.bin}/python -DPYTHON_LIBRARY=#{python.prefix}/Frameworks/Python.framework"
    
    system "make install"
  end
  
  def caveats
    caveats = <<-EOS.undent
      Quantum GIS was installed in
      ~/Applications

    EOS
    return caveats
  end
  
end
