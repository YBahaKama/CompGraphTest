cmake_minimum_required(VERSION 3.16)

include(cmake/prelude.cmake)

project(ComputerGraphics VERSION 0.1.0 LANGUAGES CXX)

# Require C++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)
include(cmake/add_library.cmake)


# Toggle between static or shared
option(BUILD_SHARED_LIBS "Build ComputerGraphics as a shared library (DLL)" OFF)

# Library definition
add_library(ComputerGraphics
    src/vec2.cpp
    src/vec3.cpp
 "include/Export.h")

# Public includes for build and install
target_include_directories(ComputerGraphics
    PUBLIC
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_compile_options(ComputerGraphics PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4 /permissive->
    $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra -pedantic>
    $<$<CXX_COMPILER_ID:Clang>:-Wall -Wextra -pedantic>
)
# ---- Install rules ----
set(CMAKE_SKIP_INSTALL_RULES off)
if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----
message(STATUS "Including docs.cmake and configuring documentation targets")
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/docs.cmake")
  include(cmake/docs.cmake)
endif()

if(NOT executable_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of executable"
  )
endif()

include(cmake/dev-mode.cmake)



# Export symbols for DLL builds on Windows
if (BUILD_SHARED_LIBS)
    target_compile_definitions(ComputerGraphics
        PRIVATE CG_EXPORTS              # For building the DLL
        INTERFACE CG_IMPORTS            # For consuming the DLL
    )
endif()

# Examples
add_subdirectory(examples)

# -------------------------
# Install rules for packaging
# -------------------------

include(CMakePackageConfigHelpers)

# Create version file for package
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/ComputerGraphicsConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

# Create config file for find_package()
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/ComputerGraphicsConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/ComputerGraphicsConfig.cmake"
    INSTALL_DESTINATION lib/cmake/ComputerGraphics
)

# Install config files
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/ComputerGraphicsConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/ComputerGraphicsConfigVersion.cmake"
    DESTINATION lib/cmake/ComputerGraphics
)
