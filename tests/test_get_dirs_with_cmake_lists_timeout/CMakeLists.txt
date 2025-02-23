cmake_minimum_required(VERSION 3.30)
project(cmake_test_get_subdirectories_with_cmake_lists)

add_subdirectory(custom_targets)

include(${CMAKE_CURRENT_LIST_DIR}/../../scripts/common.cmake)
include(${SCRIPTS_DIR}/debug.cmake)
include(${SCRIPTS_DIR}/dir_opts.cmake)

get_subdirectories_with_cmake_lists_txt(${CMAKE_CURRENT_LIST_DIR})

print_debug("SUBDIRECTORIES: ${GET_SUBDIRECTORIES_OUTPUT}" "${CMAKE_CURRENT_LIST_FILE}")
message(STATUS "OUTPUT: ${GET_SUBDIRECTORIES_OUTPUT}")
if((NOT "${GET_SUBDIRECTORIES_OUTPUT}" MATCHES "hello_world") AND
   (NOT "${GET_SUBDIRECTORIES_OUTPUT}" MATCHES "goodbye"))
    message(FATAL_ERROR "Test failed: ${CMAKE_CURRENT_LIST_DIR}" )
endif()




