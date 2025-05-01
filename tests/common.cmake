include_guard(GLOBAL)
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/common.cmake")

set(TESTS_DIR "${MODULE_BASE}/tests")
set(TESTS_SCRIPTS_DIR "${TESTS_DIR}/scripts")
set(TESTS_THIRD_PARTY_DIR "${TESTS_DIR}/third_party")
set(CMAKE_TESTS_FRAMEWORK_DIR "${TESTS_THIRD_PARTY_DIR}/cmake-script-test-framework")
