include_guard(GLOBAL)
include("${CMAKE_CURRENT_LIST_DIR}/c_compile_and_run.cmake")

function(is_current_encoding_8_bit)
    set(ENCODING_IS_8_BIT False PARENT_SCOPE)
    set(c_get_8_bit_encoding "
    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>
    
    #ifdef _WIN32
    #include <windows.h>
    char* get_text_encoding_windows() {
        UINT code_page = GetACP();
        static char encoding[15];
        //Map to Linux labels:
        switch (code_page) {
            case 1252:
                strncpy_s(encoding,15, \"ISO-8859-1\", sizeof(char) * 11);
                break;
            case 65001:
                strncpy_s(encoding, 15, \"UTF-8\", sizeof(char) * 6);
                break;
            default:
                strncpy_s(encoding, 15, \"DEADBEEF\", sizeof(char) * 9);
        }
        return encoding;
    }
    #else
    #include <locale.h>
    #include <langinfo.h>
    
    char* get_text_encoding_linux() {
        // Get the current locale's character encoding
        ;
        char* charmap_ret = (char*)nl_langinfo(CODESET);
        size_t ret_len = strnlen(charmap_ret, (15));
    
        if ((ret_len == 15) && (charmap_ret[14] != '\\0')) {
            fprintf(stderr, \"Something went wrong getting the current system charmap.\");
            exit(-1);
        }
    
        static char encoding[15];
        if (strncmp(charmap_ret, \"ANSI_X3.4-1968\", ret_len) == 0){
            strncpy(encoding, \"ASCII\", sizeof(char) * 6);
    
        }else if ((strncmp(charmap_ret, \"ISO-8859-1\", ret_len) == 0) ||
                  (strncmp(charmap_ret, \"UTF-8\", ret_len) == 0)){
            strncpy(encoding, charmap_ret, ret_len);
    
        } else {
            strncpy(encoding, \"DEADBEEF\", sizeof(char) * 9);
        }
    
        return encoding;
    }
    #endif
    
    
    int main()
    {
        //Not pretty, but it works.
        char* (*get_text_encoding)();
    
    #ifdef _WIN32
        get_text_encoding = get_text_encoding_windows;
        const char* fmt_str = \"%s\\r\\n\";
    #else
        get_text_encoding = get_text_encoding_linux;
        const char* fmt_str = \"%s\\n\";
    #endif
    
    
        char* encoding = get_text_encoding();
        fprintf(stdout, fmt_str, encoding);
    
        //If we are ASCII, UTF-8, or Windows-1252
        if (encoding == \"DEADBEEF\") {
            return 1;
        }
        return 0;
    }"
    )
    
    c_compile_and_run("${c_get_8_bit_encoding}" "")
    
    if(PROG_RETVAL EQUAL 0)
        set(ENCODING_IS_8_BIT True PARENT_SCOPE)
    endif()
endfunction()