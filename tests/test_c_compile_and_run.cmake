include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/c_compile_and_run.cmake")

macro(setup)
    set(C_PROG_BASE_DIR "${CMAKE_SOURCE_DIR}")
endmacro()
add_setup_macro(MACRO_NAME setup)

macro(teardown)
    unset(C_PROG_BASE_DIR)
endmacro()

macro(test_run_c_program)
    set(C_PROGRAM "
    #include <stdio.h>
    
    int main(){
        fprintf(stdout, \"Hello, World!\");
        fprintf(stderr, \"Ha ha. I'm an error.\");
        return 0;
    }
")

c_compile_and_run("${C_PROGRAM}" "")
    if(EXISTS "${CMAKE_SOURCE_DIR}/my_project")
        message(FATAL_ERROR "Project directory was not correctly deleted.")
    endif()
   
    if((NOT DEFINED PROG_RETVAL) OR (NOT "${PROG_RETVAL}" STREQUAL "0"))
        message(FATAL_ERROR "Program compiled, but unexpected retcode returned when ran: ${PROG_RETVAL}")
    endif()
    
    if((NOT DEFINED PROG_STDOUT) OR (NOT "${PROG_STDOUT}" STREQUAL "Hello, World!"))
        message(FATAL_ERROR "Program compiled, but STDOUT output is not correct.")
    endif()
    
    if((NOT DEFINED PROG_STDERR) OR (NOT "${PROG_STDERR}" STREQUAL "Ha ha. I'm an error."))
        message(FATAL_ERROR "Program compiled, but STDERR output is not correct.")
    endif()
endmacro()
add_test_macro(MACRO_NAME test_run_c_program)