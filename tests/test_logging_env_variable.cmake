include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/run_cmake_script.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/common.cmake")

macro(setup)
    set(temp "")
    unset(ENV{BUILD_LOG_FILE}) 
endmacro()
add_setup_macro(MACRO_NAME setup)

macro(teardown)
    if(DEFINED ENV{BUILD_LOG_FILE})
        file(REMOVE "$ENV{BUILD_LOG_FILE}")
    endif()
    unset(ENV{BUILD_LOG_FILE})
    unset(temp)
endmacro()
add_teardown_macro(MACRO_NAME teardown)

macro(test_log_build_env)
    set(ENV{BUILD_LOG_FILE} "${CMAKE_SOURCE_DIR}/scripts/build_log.txt")
    run_cmake_script(
        INPUT "${CMAKE_SOURCE_DIR}/scripts/test-logging-env-var.cmake"
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}/scripts"
    )
    message(STATUS $ENV{BUILD_LOG_FILE})
    file(READ "$ENV{BUILD_LOG_FILE}" temp)
    if(NOT "${temp}" STREQUAL "Trial run")
        message(FATAL_ERROR "\"test_log\" failed. Log file does not contain expected data.")
    endif()
endmacro()
add_test_macro(MACRO_NAME test_log_build_env)