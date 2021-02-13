
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86 8.1

set INSTALL_DIR=c:\Users\burto\cura\inst-32

set PATH=c:\Program Files (x86)\mingw-w64\i686-8.1.0-posix-dwarf-rt_v6-rev0\mingw32\bin;%PATH%

set PATH=%INSTALL_DIR%\bin;%PATH%
set PATH=%INSTALL_DIR%\scripts;%PATH%
set PATH=%INSTALL_DIR%;%PATH%

REM cryptography by default links to OpenSSL 1.1.0 which has different library
REM file names, so we need this flag to be able to link to OpenSSL 1.0.2
set CRYPTOGRAPHY_WINDOWS_LINK_LEGACY_OPENSSL=1

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%INSTALL_DIR% -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% -DBUILD_OS_WIN32=ON -G "NMake Makefiles" -DCURA_VERSION=mb-master -DCURA_SAVITAR_BRANCH_OR_TAG=sip5 -DCURA_ARCUS_BRANCH_OR_TAG=sip5 ..
