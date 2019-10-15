set(pyqt_command "")
if(BUILD_OS_WINDOWS)
    # Since PyQt5 5.11, PyQt5 requires its standalone sip module which needs to be built with the option
    # --sip-module PyQt5.sip. See https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
    ExternalProject_Add(PyQtSip
        URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.15/sip-4.19.15.tar.gz
        URL_MD5 236578d2199da630ae1251671b9a7bfe
        CONFIGURE_COMMAND ${sip_command} --sip-module PyQt5.sip
        BUILD_IN_SOURCE 1
    )

    SetProjectDependencies(TARGET PyQtSip DEPENDS Python)

    add_custom_target(PyQt
        COMMAND ${Python3_EXECUTABLE} -m pip install PyQt5==5.13
        COMMENT "Installing PyQt5"
    )

    SetProjectDependencies(TARGET PyQt DEPENDS Python PyQtSip)
else()
    if(BUILD_OS_OSX)
        set(pyqt_command
            "DYLD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${Python3_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )
        ExternalProject_Add(PyQt
            URL https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.10/PyQt5_gpl-5.10.tar.gz
            URL_MD5 4874c5985246fdeb4c3c7843a3e6ef53
            CONFIGURE_COMMAND ${pyqt_command}
            BUILD_IN_SOURCE 1
        )

        SetProjectDependencies(TARGET PyQt DEPENDS Qt Sip)
    else()
        set(pyqt_command
            # On Linux, PyQt configure fails because it creates an executable that does not respect RPATH
            "LD_LIBRARY_PATH=${CMAKE_INSTALL_PREFIX}/lib"
            ${Python3_EXECUTABLE} configure.py
            --sysroot ${CMAKE_INSTALL_PREFIX}
            --qmake ${CMAKE_INSTALL_PREFIX}/bin/qmake
            --sip ${CMAKE_INSTALL_PREFIX}/bin/sip
            --confirm-license
        )

        # Since PyQt5 5.11, PyQt5 requires its standalone sip module which needs to be built with the option
        # --sip-module PyQt5.sip. See https://www.riverbankcomputing.com/static/Docs/PyQt5/installation.html
        ExternalProject_Add(PyQtSip
            URL https://www.riverbankcomputing.com/static/Downloads/sip/4.19.15/sip-4.19.15.tar.gz
            URL_MD5 236578d2199da630ae1251671b9a7bfe
            CONFIGURE_COMMAND ${Python3_EXECUTABLE} configure.py --sip-module PyQt5.sip
            BUILD_IN_SOURCE 1
        )
        SetProjectDependencies(TARGET PyQtSip DEPENDS Python)

        ExternalProject_Add(PyQt
            URL https://www.riverbankcomputing.com/static/Downloads/PyQt5/5.13.0/PyQt5_gpl-5.13.0.tar.gz
            #URL_MD5 e9bd7ade2d04a4da144570a8b654e054
            CONFIGURE_COMMAND ${pyqt_command}
            BUILD_IN_SOURCE 1
        )

        SetProjectDependencies(TARGET PyQt DEPENDS Qt PyQtSip)
    endif()

endif()
