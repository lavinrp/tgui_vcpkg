# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular.cmake)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/move
    REF boost-1.66.0
    SHA512 e431ca8c709f6acb205f93e3c1de1a3b46325e183726bd9b862f4fba436af92b3f5a945eddfe04c3fa775fd88311f98eafa9e81f5014f3a0309096f18b837286
    HEAD_REF master
)

boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})