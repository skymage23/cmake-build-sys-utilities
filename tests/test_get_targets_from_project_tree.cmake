include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/common.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/common.cmake)

#set(BUILD_DIR_PATH "${CMAKE_CURRENT_LIST_DIR}/build")
#
#if(NOT EXISTS "${BUILD_DIR_PATH}")
#    make_directory("${BUILD_DIR_PATH}")
#endif()
#
#execute_process( COMMAND ${CMAKE_COMMAND}  ${TEST_HELPERS_DIR}/test_generate_args_for_launch_json_gen_script/CMakeLists.txt
#    TIMEOUT 4s
#    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/build
#    COMMAND_ECHO STDOUT
#    COMMAND_ERROR_IS_FATAL ANY
#)
#
#file(REMOVE_RECURSE "${BUILD_DIR_PATH}")



include(${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake)

macro(test_generate_args_for_launch_json_gen_script)
    execute_process( 
        COMMAND ${CMAKE_COMMAND}  ${test_dir}/CMakeLists.txt
        TIMEOUT 4s
        WORKING_DIRECTORY ${test_dir}/build
        COMMAND_ECHO STDOUT
        COMMAND_ERROR_IS_FATAL ANY
    )
endmacro()

macro(teardown)
    file(REMOVE_RECURSE ${BUILD_DIR})
endmacro()
add_teardown_macro(MACRO_NAME teardown)

macro(setup)
    set(test_dir "${TEST_HELPERS_DIR}/test_generate_args_for_launch_json_gen_script")
    set(BUILD_DIR "${test_dir}/build")

    if(EXISTS "${BUILD_DIR}")
       teardown()
    endif()
    make_directory("${BUILD_DIR}")
endmacro()
add_setup_macro(MACRO_NAME setup)

add_test_macro(MACRO_NAME test_generate_args_for_launch_json_gen_script)
