# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(executableTests LANGUAGES CXX)

# ---- Fetch Google Test ----

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.15.2.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE	
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# ---- Tests ----

add_executable(vec2_test source/vec2_test.cpp)
target_link_libraries(vec2_test PRIVATE ComputerGraphics gtest_main)
target_compile_features(vec2_test PRIVATE cxx_std_20)

add_test(NAME vec2_test COMMAND vec2_test)

# ---- End-of-file commands ----

add_folders(Test)