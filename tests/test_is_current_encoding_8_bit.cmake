include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/text_processing.cmake")

macro(setup)
    set(C_PROG_BASE_DIR "${CMAKE_SOURCE_DIR}")
endmacro()
add_setup_macro(MACRO_NAME setup)

macro(teardown)
    unset(C_PROG_BASE_DIR)
endmacro()
add_teardown_macro(MACRO_NAME teardown)

macro(test_is_current_encoding_8_bit_runs)
    is_current_encoding_8_bit()
    message(STATUS "${ENCODING_IS_8_BIT}")
endmacro()
add_test_macro(MACRO_NAME test_is_current_encoding_8_bit_runs)