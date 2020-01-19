
if(BUILD_OS_LINUX)
set(qt_url https://download.qt.io/archive/qt/5.13/5.13.2/single/qt-everywhere-src-5.13.2.tar.xz)
set(qt_md5 7c04c678d4ecd9e9c06747e7c17e0bb9)
endif()

if(BUILD_OS_OSX)
set(qt_url https://download.qt.io/archive/qt/5.13/5.13.2/single/qt-everywhere-src-5.13.2.tar.xz)
set(qt_md5 7c04c678d4ecd9e9c06747e7c17e0bb9)
endif()

if(BUILD_OS_WINDOWS)
    # For some as of yet unknown reason, building Qt on Windows fails because it does not create moc targets.
    # Due to that we install the PyQt wheel into the built Python manually.
    return()
endif()

set(_qt_configure_cmd "./configure")
set(qt_options
    -release
    -prefix ${CMAKE_INSTALL_PREFIX}
    -archdatadir ${CMAKE_INSTALL_PREFIX}/lib
    -datadir ${CMAKE_INSTALL_PREFIX}/share
    -opensource
    -confirm-license
    -nomake examples
    -nomake tests
    -nomake tools
    -no-cups
    -no-sql-db2
    -no-sql-ibase
    -no-sql-mysql
    -no-sql-oci
    -no-sql-odbc
    -no-sql-psql
    -no-sql-sqlite
    -no-sql-sqlite2
    -no-sql-tds
    -no-icu
    -skip qtconnectivity
    -skip qtdoc
    -skip qtlocation
    -skip qtmultimedia
    -skip qtscript
    -skip qtsensors
    -skip qtwebchannel
    -skip qtwebengine
    -skip qtandroidextras
    -skip qtactiveqt
    -skip qttools
    -skip qtxmlpatterns
    -skip qt3d
    -skip qtcanvas3d
    -skip qtserialport
    -skip qtserialbus
    -skip qtwayland
    -skip qtgamepad
    -skip qtscxml
)

if(BUILD_OS_OSX)
    list(APPEND qt_options -no-framework -no-egl)
    if(CURA_OSX_SDK_VERSION)
        list(APPEND qt_options -sdk macosx${CURA_OSX_SDK_VERSION})
    endif()
    set(_qt_config_cmd ${CMAKE_SOURCE_DIR}/projects/qt-patch-macosx-target.sh && ${_qt_configure_cmd})
elseif(BUILD_OS_WINDOWS)
    list(APPEND qt_options -opengl desktop -no-egl)
elseif(BUILD_OS_LINUX)
    list(APPEND qt_options
     -use-gold-linker
	 -rpath
	 -pkg-config
     -no-gtk
	 -qt-xcb
     -no-linuxfb
	 -fontconfig
	 -system-freetype
	 -system-zlib
	 -ssl -openssl-runtime
	 -I "${CMAKE_INSTALL_PREFIX}/include"
	 -L "${CMAKE_INSTALL_PREFIX}/lib")
    if(${CMAKE_CXX_LIBRARY_ARCHITECTURE} MATCHES "arm-linux-gnueabihf")
        list(APPEND qt_options -opengl es2 -platform linux-g++-armv8)
    else()
        list(APPEND qt_options -opengl desktop -no-egl)
    endif()
endif()

if(BUILD_OS_OSX)
    ExternalProject_Add(Qt
        URL ${qt_url}
        URL_MD5 ${qt_md5}
        CONFIGURE_COMMAND ${_qt_configure_cmd} ${qt_options}
        BUILD_IN_SOURCE 1
        DEPENDS OpenSSL
    )
else()
    ExternalProject_Add(Qt
        URL ${qt_url}
        URL_MD5 ${qt_md5}
        CONFIGURE_COMMAND cp -uav ${CMAKE_SOURCE_DIR}/projects/linux-g++-armv8 qtbase/mkspecs
        COMMAND ./configure ${qt_options}
        BUILD_IN_SOURCE 1
    )
endif()
