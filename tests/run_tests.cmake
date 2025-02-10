cmake_minimum_required(VERSION 3.30)
include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test-runner.cmake")
#
# Here, we are mainly concerned with testing the CMake scripts.
# For testing purposes, we make up some nonsense targets
#

run_test(TEST_SCRIPT_FILE "${CMAKE_CURRENT_LIST_DIR}/test_get_dirs_with_cmake_lists.cmake")
run_test(TEST_SCRIPT_FILE "${CMAKE_CURRENT_LIST_DIR}/test_get_targets_from_project_tree.cmake")

