#if(BUILD_OS_WINDOWS)
#    set(sip_command
#        ${Python3_EXECUTABLE}
#        configure.py
#        --platform win32-msvc2015
#    )
#elseif(BUILD_OS_LINUX)
#    set(sip_command
#        ${Python3_EXECUTABLE}
#        configure.py
#    )
#elseif(BUILD_OS_OSX)
#    set(sip_command
#        ${Python3_EXECUTABLE}
#        configure.py
#    )
#else()
#    set(sip_command "")
#endif()
#
#ExternalProject_Add(Sip
#    URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz
#    #URL_MD5 236578d2199da630ae1251671b9a7bfe
#    CONFIGURE_COMMAND ${sip_command}
#    BUILD_IN_SOURCE 1
#)

add_custom_target(Sip
    COMMENT "Installing sip"
    DEPENDS ${CMAKE_PREFIX_PATH}/bin/sip-module ${CMAKE_PREFIX_PATH}/include/python3.5/sip.h
)

add_custom_command(
    OUTPUT ${CMAKE_PREFIX_PATH}/bin/sip-module ${CMAKE_PREFIX_PATH}/include/python3.5/sip.h
    COMMAND ${Python3_EXECUTABLE} -m pip install --force-reinstall sip==5.4.0
    COMMAND ${CMAKE_PREFIX_PATH}/bin/sip-module --sdist --target-dir ${CMAKE_PREFIX_PATH}/lib/python3.5 sip5
    COMMAND ${Python3_EXECUTABLE} -m pip install ${CMAKE_PREFIX_PATH}/lib/python3.5/sip5-12.8.1.tar.gz
    COMMAND ${CMAKE_PREFIX_PATH}/bin/sip-module --sip-h --target-dir ${CMAKE_PREFIX_PATH}/include/python3.5 sip5
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
