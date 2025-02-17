include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/run_cmake_script.cmake")

macro(test)
    run_cmake_script(
        INPUT "${CMAKE_CURRENT_LIST_DIR}/test_helpers/scripts/test-script.cmake"
        WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/test_helpers/scripts" 
    )
endmacro()