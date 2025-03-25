include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/common.cmake")
include ("${CMAKE_CURRENT_LIST_DIR}/../scripts/logging.cmake")

macro(setup)
    set(temp "")
endmacro()
add_setup_macro(MACRO_NAME setup)

macro(teardown)
    set(temp "")
    if(EXISTS "${BUILD_LOG}")
        file(REMOVE "${BUILD_LOG}")
    endif()
endmacro()
add_teardown_macro(MACRO_NAME teardown)

macro(test_log)
    log("Trial run")
    if(NOT EXISTS "${BUILD_LOG}")
        message(FATAL_ERROR "\"test_log\" failed.  Log file not created")
    endif()
    file(READ "${BUILD_LOG}" temp)
    if(NOT "${temp}" STREQUAL "Trial run")
        message(FATAL_ERROR "\"test_log\" failed. Log file does not contain expected data.")
    endif()
endmacro()
add_test_macro(MACRO_NAME test_log)