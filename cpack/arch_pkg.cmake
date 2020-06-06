find_program(MAKEPKG makepkg)
if(MAKEPKG STREQUAL makepkg-NOTFOUND)
  message(STATUS "Could not find makepkg, skipping archlinux package")
endif()

file(COPY ${CPACK_PACKAGE_DIRECTORY}/${CPACK_PACKAGE_FILE_NAME}.tar.gz
     DESTINATION ${CPACK_PACKAGE_DIRECTORY}/archlinux)

