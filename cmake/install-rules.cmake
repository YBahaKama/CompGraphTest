# Install the ComputerGraphics library
install(TARGETS ComputerGraphics
    EXPORT ComputerGraphicsTargets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

# Install public headers
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/
    DESTINATION include
)

# Export targets for find_package support
install(EXPORT ComputerGraphicsTargets
    FILE ComputerGraphicsTargets.cmake
    NAMESPACE ComputerGraphics::
    DESTINATION lib/cmake/ComputerGraphics
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
