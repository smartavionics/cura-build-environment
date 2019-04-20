
call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64 8.1

set INSTALL_DIR=c:\Users\burto\cura\inst

set PATH=%INSTALL_DIR%\bin;%PATH%
set PATH=%INSTALL_DIR%\scripts;%PATH%
set PATH=%INSTALL_DIR%;%PATH%

REM cryptography by default links to OpenSSL 1.1.0 which has different library
REM file names, so we need this flag to be able to link to OpenSSL 1.0.2
set CRYPTOGRAPHY_WINDOWS_LINK_LEGACY_OPENSSL=1

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%INSTALL_DIR% -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% -DBUILD_OS_WIN64=ON -G "NMake Makefiles" -DCURA_VERSION=mb-master ..
