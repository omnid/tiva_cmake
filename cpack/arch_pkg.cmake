find_program(MAKEPKG makepkg)
if(MAKEPKG STREQUAL makepkg-NOTFOUND)
  message(STATUS "Could not find makepkg, skipping archlinux package")
endif()

file(COPY ${CPACK_PACKAGE_DIRECTORY}/${CPACK_PACKAGE_FILE_NAME}.tar.gz
     DESTINATION ${CPACK_PACKAGE_DIRECTORY}/archlinux)

set(ENV{PKGEXT} ".pkg.tar.xz")
execute_process(COMMAND ${MAKEPKG}
                WORKING_DIRECTORY ${CPACK_PACKAGE_DIRECTORY}/archlinux)

file(COPY
     ${CPACK_PACKAGE_DIRECTORY}/archlinux/${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}-any.pkg.tar.xz
     DESTINATION ${CPACK_PACKAGE_DIRECTORY})
