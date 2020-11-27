set(pyqt_command "")
if(BUILD_OS_WINDOWS)
#    # Since PyQt5 5.11, PyQt5 requires its standalone sip module which needs to be built with the option
#    # --sip-module PyQt5.sip. See https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
#    ExternalProject_Add(PyQtSip
#        #URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz
#        URL https://files.pythonhosted.org/packages/af/68/c603a9d6319ef1126187c42e0b13ac5fcf556d040feded2e574e1a6a27e4/sip-5.4.0.tar.gz
#        #URL_MD5 236578d2199da630ae1251671b9a7bfe
#        CONFIGURE_COMMAND ${Python3_EXECUTABLE} configure.py --platform win32-msvc2015 --sip-module PyQt5.sip
#        BUILD_IN_SOURCE 1
#    )

    add_custom_target(PyQt5-Sip
        COMMAND ${Python3_EXECUTABLE} -m pip install PyQt5-Sip==12.8.1
        COMMENT "Installing PyQt5-Sip"
    )

    SetProjectDependencies(TARGET PyQt5-Sip DEPENDS Python)

    add_custom_target(PyQt
        COMMAND ${Python3_EXECUTABLE} -m pip install PyQt5==5.15.1
        COMMENT "Installing PyQt5"
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Python PyQt5-Sip)
else()
    if(BUILD_OS_OSX)
        set(pyqt_command
            "DYLD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${CMAKE_INSTALL_PREFIX}/bin/sip-build --no-make
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --confirm-license
        )
    else()
        set(pyqt_command
            # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
            "LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${CMAKE_INSTALL_PREFIX}/bin/sip-build --no-make
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --confirm-license
        )
    endif()
#    # Since PyQt5 5.11, PyQt5 requires its standalone sip module which needs to be built with the option
#    # --sip-module PyQt5.sip. See https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
#    ExternalProject_Add(PyQtSip
#        URL https://files.pythonhosted.org/packages/af/68/c603a9d6319ef1126187c42e0b13ac5fcf556d040feded2e574e1a6a27e4/sip-5.4.0.tar.gz
#        #URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.24/sip-4.19.24.tar.gz
#        #URL_MD5 236578d2199da630ae1251671b9a7bfe
#        CONFIGURE_COMMAND ${Python3_EXECUTABLE} configure.py --sip-module PyQt5.sip
#        BUILD_IN_SOURCE 1
#    )
#    SetProjectDependencies(TARGET PyQtSip DEPENDS Python)

    add_custom_target(PyQt-Builder
        COMMAND ${Python3_EXECUTABLE} -m pip install PyQt-Builder==1.5.0
        COMMENT "Installing PyQt-Builder"
    )

    SetProjectDependencies(TARGET PyQt-Builder DEPENDS Python)

    add_custom_target(PyQt5-Sip
        COMMAND ${Python3_EXECUTABLE} -m pip install PyQt5-Sip==12.8.1
        COMMENT "Installing PyQt5-Sip"
    )

    SetProjectDependencies(TARGET PyQt5-Sip DEPENDS Python)

    ExternalProject_Add(PyQt
        #URL https://www.riverbankcomputing.com/static/Downloads/PyQt5/PyQt5-5.14.2.dev2002051759.tar.gz
        #URL https://files.pythonhosted.org/packages/4d/81/b9a66a28fb9a7bbeb60e266f06ebc4703e7e42b99e3609bf1b58ddd232b9/PyQt5-5.14.2.tar.gz
        URL https://files.pythonhosted.org/packages/1d/31/896dc3dfb6c81c70164019a6cbba6ab037e3af7653d9ca60ccc874ee4c27/PyQt5-5.15.1.tar.gz
        #URL_MD5 e9bd7ade2d04a4da144570a8b654e054
        CONFIGURE_COMMAND ${pyqt_command}
        BUILD_COMMAND make -C build
        INSTALL_COMMAND make -C build install
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Qt PyQt-Builder PyQt5-Sip)
#    SetProjectDependencies(TARGET PyQt DEPENDS Qt PyQtSip)
endif()
