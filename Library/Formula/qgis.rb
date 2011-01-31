require 'formula'

class Qgis <Formula
  url 'http://qgis.org/downloads/qgis-1.6.0.tar.bz2'
  homepage 'http://qgis.org/'
  md5 '9ea8a784d970f5009b0e6271820248f6'

  depends_on 'cmake' => :build
  depends_on 'postgis'
  depends_on 'python' # TODO: requires python "--framework --universal", check for "Python.framework"
  depends_on 'qt'
  depends_on 'gdal'
  depends_on 'geos'
  depends_on 'proj'
  depends_on 'sqlite'
  depends_on 'libspatialite' => :optional # causing problems, switched to internal lib
  depends_on 'libiconv'
  depends_on 'gsl'
  depends_on 'pyqt'
  depends_on 'sip'
  depends_on 'qwt'
  # not yet in homebrew available: depends_on 'pyqwt'

  def install
    geos = Formula.factory 'geos'
    gdal = Formula.factory 'gdal'
    python = Formula.factory 'python'
    gsl = Formula.factory 'gsl'
    
    system "cmake -DCMAKE_INSTALL_PREFIX=~/Applications -DCMAKE_BUILD_TYPE=Release -DCMAKE_BUILD_TYPE=MinSizeRel -DWITH_INTERNAL_SPATIALITE=TRUE -DGEOS_INCLUDE_DIR=#{geos.include} -DGEOS_LIBRARY=#{geos.lib}/libgeos_c.dylib -DGDAL_INCLUDE_DIR=#{gdal.include} -DGDAL_LIBRARY=#{gdal.lib}/libgdal.dylib -DGSL_INCLUDE_DIR=#{gdal.include} -DGSL_LIBRARIES=#{gsl.lib} -DPYTHON_EXECUTABLE=#{python.bin}/python"
    system "make install"
  end
  
  def caveats; <<-EOS.undent
      Quantum GIS 1.6 was installed in
      ~/Applications
    EOS
  end
  
end
