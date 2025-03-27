include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/check_endianness.cmake")

macro(test_check_endianness)
    # Call the check_endianness function
    check_endianness()
    
    # Verify that IS_LITTLE_ENDIAN was set
    if(NOT DEFINED IS_LITTLE_ENDIAN)
        message(FATAL_ERROR "check_endianness failed: IS_LITTLE_ENDIAN was not defined")
    endif()
    
    # Log the result for verification
    if(IS_LITTLE_ENDIAN)
        message(STATUS "System is little-endian")
    else()
        message(STATUS "System is big-endian")
    endif()
endmacro()
add_test_macro(MACRO_NAME test_check_endianness) 