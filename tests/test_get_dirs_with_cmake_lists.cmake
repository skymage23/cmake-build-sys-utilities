#This isn't being included in the tests:
include(third_party/cmake-script-test-framework/cmake-test.cmake)
include(common.cmake)
macro(teardown)
    file(REMOVE_RECURSE ${BUILD_DIR})
endmacro()
add_teardown_macro(MACRO_NAME teardown)

macro(setup)  
    set(test_dir "${TEST_HELPERS_DIR}/test_get_dirs_with_cmake_lists_timeout")
    set(BUILD_DIR "${test_dir}/build")
    if(EXISTS "${BUILD_DIR}")
       teardown()
    endif()
    make_directory("${BUILD_DIR}")
endmacro()
add_setup_macro(MACRO_NAME setup)


macro(test)
execute_process( COMMAND ${CMAKE_COMMAND}  ${test_dir}/CMakeLists.txt
    TIMEOUT 7s
    WORKING_DIRECTORY ${BUILD_DIR}
    COMMAND_ECHO STDOUT
    COMMAND_ERROR_IS_FATAL ANY
)
endmacro()
add_test_macro(MACRO_NAME test)