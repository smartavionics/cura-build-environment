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
    COMMAND ${Python3_EXECUTABLE} -m pip install sip==5.4.0
    COMMENT "Installing sip"
)

SetProjectDependencies(TARGET Sip DEPENDS Python)
