# ---- Variables ----

# We use variables separate from what CTest uses, because those have
# customization issues
set(
    COVERAGE_TRACE_COMMAND
    lcov -c -q
    -o "${PROJECT_BINARY_DIR}/coverage.info"
    -d "${PROJECT_BINARY_DIR}"
    --include "${PROJECT_SOURCE_DIR}/src/*"
    --include "${PROJECT_SOURCE_DIR}/include/*"
    --ignore-errors mismatch,gcov
    CACHE STRING
    "; separated command to generate a trace for the 'coverage' target"
)

set(
    COVERAGE_FILTER_COMMAND
    lcov -q
    --remove "${PROJECT_BINARY_DIR}/coverage.info.base"
    # Exclude test code, dependencies, and system headers.
    "*/test/*"
    "*/_deps/*"
    "/usr/include/*"
    -o "${PROJECT_BINARY_DIR}/coverage.info"
    --ignore-errors unused
    CACHE STRING
    "; separated command to filter the trace for the 'coverage' target"
)

set(
    COVERAGE_HTML_COMMAND
    genhtml --legend -f -q
    "${PROJECT_BINARY_DIR}/coverage.info"
    -p "${PROJECT_SOURCE_DIR}"
    -o "${PROJECT_BINARY_DIR}/coverage_html"
    CACHE STRING
    "; separated command to generate an HTML report for the 'coverage' target"
)

# ---- Coverage target ----

add_custom_target(
    coverage
    COMMAND ${COVERAGE_TRACE_COMMAND}
    COMMAND ${COVERAGE_HTML_COMMAND}
    COMMENT "Generating coverage report"
    VERBATIM
)
