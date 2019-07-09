if(BUILD_OS_LINUX)
    set(_appimagetool_path "${CMAKE_INSTALL_PREFIX}/bin/appimagetool.AppImage")
    set(_apprun_path "${CMAKE_INSTALL_PREFIX}/bin/AppRun")

    set(_appimagetool_release 12)

    if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "armv7l")
        set(_appimage_arch armhf)
    else()
        set(_appimage_arch x86_64)
    endif()

    add_custom_target(AppImageKit ALL
        COMMENT "Installing AppImageKit tools to ${CMAKE_INSTALL_PREFIX}/bin/"
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin/
	COMMAND curl -o "${_appimagetool_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/${_appimagetool_release}/appimagetool-${_appimage_arch}.AppImage
	COMMAND chmod a+x "${_appimagetool_path}"
	COMMAND curl -o "${_apprun_path}" -SL https://github.com/AppImage/AppImageKit/releases/download/${_appimagetool_release}/AppRun-${_appimage_arch}
	COMMAND chmod a+x "${_apprun_path}"
    )
endif()
