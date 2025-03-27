include_guard(GLOBAL)
include("${CMAKE_CURRENT_LIST_DIR}/c_compile_and_run.cmake")

function(check_endianness)
    set(endianness_check_program "
    #include <stdio.h>
    #include <stdlib.h>
    
    int main() {
        union {
            int i;
            char c[sizeof(int)];
        } u;
        
        /* Set the integer to 1. In little-endian, the least significant byte (1) 
           will be stored at the lowest address. In big-endian, it will be stored 
           at the highest address. */
        u.i = 1;
        
        /* Check the first byte. If it's 1, we're little-endian. If it's 0, we're big-endian. */
        if (u.c[0] == 1) {
            printf(\"LITTLE_ENDIAN\\n\");
            return 0;
        } else if (u.c[0] == 0) {
            printf(\"BIG_ENDIAN\\n\");
            return 0;
        } else {
            fprintf(stderr, \"Error: Unexpected byte value %d\\n\", u.c[0]);
            return 1;
        }
    }
    ")
    
    c_compile_and_run("${endianness_check_program}" "")
    
    if(PROG_RETVAL EQUAL 0)
        if(PROG_STDOUT MATCHES "LITTLE_ENDIAN")
            set(IS_LITTLE_ENDIAN TRUE PARENT_SCOPE)
        elseif(PROG_STDOUT MATCHES "BIG_ENDIAN")
            set(IS_LITTLE_ENDIAN FALSE PARENT_SCOPE)
        else()
            message(FATAL_ERROR "Unexpected output from endianness check: ${PROG_STDOUT}")
        endif()
    else()
        message(FATAL_ERROR "Endianness check failed with error: ${PROG_STDERR}")
    endif()
endfunction()