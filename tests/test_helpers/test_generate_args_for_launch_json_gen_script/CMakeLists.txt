cmake_minimum_required(VERSION 3.30)
project(test_generate_args_for_launch_json_gen_script)
include(${CMAKE_CURRENT_LIST_DIR}/../../../scripts/common.cmake)
include(${SCRIPTS_DIR}/build_sys_opts.cmake)
include(${SCRIPTS_DIR}/debug.cmake)
include(${SCRIPTS_DIR}/common.cmake)

set(EXPECTED_TARGET "hello_world")
set(LEN "")
set(OUTPUT "")

add_subdirectory(custom_targets)

get_targets_list_under_dir("${CMAKE_CURRENT_LIST_DIR}/custom_targets")
message(STATUS "TARGET_LIST: ${TARGET_LIST}")
list(LENGTH TARGET_LIST LEN)
if(${LEN} LESS_EQUAL 0)
    message(FATAL_ERROR "Target list check failed:  generated target list is not the right length.")
endif()

list(FIND TARGET_LIST "${EXPECTED_TARGET}" OUTPUT)
message(STATUS "OUTPUT: ${OUTPUT}")
if(${OUTPUT} LESS_EQUAL -1)
    message(FATAL_ERROR "Expected target \"${EXPECTED_TARGET}\" not found in the target list.")
endif()



