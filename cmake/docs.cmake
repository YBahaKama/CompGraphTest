# ---- Dependencies ----
set(extract_timestamps "")
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24")
  set(extract_timestamps DOWNLOAD_EXTRACT_TIMESTAMP YES)
endif()

include(FetchContent)
FetchContent_Declare(
    mcss URL
    https://github.com/friendlyanon/m.css/releases/download/release-1/mcss.zip
    URL_MD5 00cd2757ebafb9bcba7f5d399b3bec7f
    SOURCE_DIR "${PROJECT_BINARY_DIR}/mcss"
    UPDATE_DISCONNECTED YES
    ${extract_timestamps}
)
FetchContent_MakeAvailable(mcss)

find_package(Python3 3.6 REQUIRED)

# ---- Paths ----
set(DOXYGEN_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/docs" CACHE PATH "Path for the generated Doxygen documentation")
set(working_dir "${PROJECT_BINARY_DIR}/docs")
file(MAKE_DIRECTORY "${working_dir}")

# Configure templates into the build tree
message(STATUS "Configuring documentation files into: ${working_dir}")
foreach(file IN ITEMS Doxyfile conf.py)
  configure_file("${CMAKE_SOURCE_DIR}/docs/${file}.in" "${working_dir}/${file}" @ONLY)
endforeach()

set(mcss_script "${mcss_SOURCE_DIR}/documentation/doxygen.py")
get_filename_component(config "${working_dir}/conf.py" ABSOLUTE)

# Only guard the target creation, not the file configuration
if(NOT TARGET docs)
  add_custom_target(
      docs
      COMMAND "${CMAKE_COMMAND}" -E echo "Running m.css with config: ${config}"
      COMMAND "${CMAKE_COMMAND}" -E echo "Working directory: ${working_dir}"
      COMMAND "${CMAKE_COMMAND}" -E remove_directory "${DOXYGEN_OUTPUT_DIRECTORY}/html"
      COMMAND "${CMAKE_COMMAND}" -E remove_directory "${DOXYGEN_OUTPUT_DIRECTORY}/xml"
      COMMAND "${Python3_EXECUTABLE}" "${mcss_script}" "${config}"
      WORKING_DIRECTORY "${working_dir}"
      COMMENT "Building documentation using Doxygen and m.css"
      VERBATIM
  )
else()
  message(STATUS "Target 'docs' already exists; skipping target creation but files were configured.")
endif()