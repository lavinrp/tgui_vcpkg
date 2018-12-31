# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/TGUI-0.8.2)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/texus/TGUI/archive/v0.8.2.zip"
    FILENAME "tgui-0.8.2.zip"
    SHA512 49307d0c1e8c7327544010622f44926521e9386252df5f398e5effc828df84d0c22b55d013cc5e88c2eb680020d2a5b97fc5f3d18bf5528aeb0ede0ef1021f00
)
vcpkg_extract_source_archive(${ARCHIVE})

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" TGUI_SHARED_LIBS)
string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "static" TGUI_STATIC_STD_LIBS)

set(ENV{SFML_DIR} "${CURRENT_PACKAGES_DIR}/share/sfml" PARENT_SCOPE)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DTGUI_SHARED_LIBS=${TGUI_SHARED_LIBS}
    OPTIONS -DTGUI_USE_STATIC_STD_LIBS=${TGUI_STATIC_STD_LIBS}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(GLOB TEXTFILES
  "${CURRENT_PACKAGES_DIR}/debug/license.txt"
  "${CURRENT_PACKAGES_DIR}/license.txt"
  "${CURRENT_PACKAGES_DIR}/debug/README.md"
  "${CURRENT_PACKAGES_DIR}/README.md"
)
if(TEXTFILES)
  file(REMOVE ${TEXTFILES})
endif()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/tgui RENAME copyright)

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/TGUI)