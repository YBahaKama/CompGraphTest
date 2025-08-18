# Example executable
add_executable(main
    main.cpp
)

# Link with our library
target_link_libraries(main PRIVATE ComputerGraphics)
