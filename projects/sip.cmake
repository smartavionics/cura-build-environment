if(BUILD_OS_WINDOWS)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
        --platform win32-msvc2015
    )
elseif(BUILD_OS_LINUX)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
    )
elseif(BUILD_OS_OSX)
    set(sip_command
        ${Python3_EXECUTABLE}
        configure.py
    )
else()
    set(sip_command "")
endif()

ExternalProject_Add(Sip
    URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.15/sip-4.19.15.tar.gz
    URL_MD5 236578d2199da630ae1251671b9a7bfe
    CONFIGURE_COMMAND ${sip_command}
    BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET Sip DEPENDS Python)

# Since PyQt5 5.11, PyQt5 requires its standalone sip module which needs to be built with the option
# --sip-module PyQt5.sip. See https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
ExternalProject_Add(PyQtSip
	URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.15/sip-4.19.15.tar.gz
	URL_MD5 236578d2199da630ae1251671b9a7bfe
	CONFIGURE_COMMAND ${sip_command} --sip-module PyQt5.sip
	BUILD_IN_SOURCE 1
)

SetProjectDependencies(TARGET PyQtSip DEPENDS Python)

