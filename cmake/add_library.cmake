add_custom_target(docs
    COMMAND doxygen ${CMAKE_SOURCE_DIR}/Doxyfile
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)