if(BUILD_OS_OSX)
    set(_openssl_os darwin64-x86_64-cc enable-ec_nistp_64_gcc_128)
    set(_openssl_args no-ssl2 no-ssl3 no-zlib shared enable-cms)

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/old/1.0.2/openssl-1.0.2p.tar.gz
        URL_HASH SHA256=50a98e07b1a89eb8f6a99477f262df71c6fa7bef77df4dc83025a2845c827d00
        CONFIGURE_COMMAND perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} ${_openssl_args} ${_openssl_os}
        BUILD_COMMAND make depend && make
        INSTALL_COMMAND make install
        BUILD_IN_SOURCE 1
    )
elseif(BUILD_OS_LINUX)
    if(${CMAKE_CXX_LIBRARY_ARCHITECTURE} MATCHES "arm-linux-gnueabihf")
        set(_openssl_os linux-armv4)
    elseif(${CMAKE_CXX_LIBRARY_ARCHITECTURE} MATCHES "aarch64-linux-gnu")
        set(_openssl_os linux-aarch64 enable-ec_nistp_64_gcc_128)
    else()
        set(_openssl_os linux-x86_64 enable-ec_nistp_64_gcc_128)
    endif()
    set(_openssl_args no-ssl2 no-ssl3 no-zlib shared enable-cms)

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/old/1.0.2/openssl-1.0.2p.tar.gz
        URL_HASH SHA256=50a98e07b1a89eb8f6a99477f262df71c6fa7bef77df4dc83025a2845c827d00
        CONFIGURE_COMMAND perl Configure --prefix=${CMAKE_INSTALL_PREFIX} --openssldir=${CMAKE_INSTALL_PREFIX} ${_openssl_args} ${_openssl_os}
        BUILD_COMMAND make depend && make
        INSTALL_COMMAND make install_sw
        BUILD_IN_SOURCE 1
    )
endif()

return()

if(BUILD_OS_WINDOWS)
    if(BUILD_OS_WIN32)
        set(_openssl_os "VC-WIN32")
        set(_openssl_build ms\\do_nasm.bat && nmake -f ms\\nt.mak)
    else()
        set(_openssl_os "VC-WIN64A")
        set(_openssl_build ms\\do_win64a.bat && nmake -f ms\\nt.mak)
    endif()

    ExternalProject_Add(OpenSSL
        URL https://www.openssl.org/source/old/1.0.2/openssl-1.0.2k.tar.gz
        URL_HASH SHA256=6b3977c61f2aedf0f96367dcfb5c6e578cf37e7b8d913b4ecb6643c3cb88d8c0
        CONFIGURE_COMMAND perl Configure ${_openssl_os} --prefix=${CMAKE_INSTALL_PREFIX}
        BUILD_COMMAND ${_openssl_build}
        INSTALL_COMMAND nmake -f ms\\nt.mak install
        BUILD_IN_SOURCE 1
    )
endif()
