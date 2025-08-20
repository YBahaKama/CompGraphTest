# ---- Variables ----

# Step 1: Capture coverage for the entire project.
set(
    COVERAGE_TRACE_COMMAND
    lcov -c -q
    -o "${PROJECT_BINARY_DIR}/coverage.info.base"
    -d "${PROJECT_BINARY_DIR}"
    --remove "*/test/*" \ "*/include&*" \ "/usr/include/*"
    --ignore-errors mismatch,gcov,unused
    CACHE STRING
    "Step 1: Generate a base trace for the 'coverage' target"
)

# Step 3: Generate the final HTML report from the filtered data.
set(
    COVERAGE_HTML_COMMAND
    genhtml --legend -f -q
    "${PROJECT_BINARY_DIR}/coverage.info"
    -p "${PROJECT_SOURCE_DIR}"
    -o "${PROJECT_BINARY_DIR}/coverage_html"
    CACHE STRING
    "Step 3: Generate an HTML report for the 'coverage' target"
)

# ---- Coverage target ----

add_custom_target(
    coverage
    # Run the commands in the correct order: trace, filter, then html.
    COMMAND ${COVERAGE_TRACE_COMMAND}
    COMMAND ${COVERAGE_HTML_COMMAND}
    COMMENT "Generating coverage report"
    VERBATIM
)