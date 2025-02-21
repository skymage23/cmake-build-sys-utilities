include("${CMAKE_CURRENT_LIST_DIR}/third_party/cmake-script-test-framework/cmake-test.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/../scripts/os_host_opts.cmake")
macro(test_should_exist_on_path)
    set(PROGRAM_TO_LOOK_FOR "")
    if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
        set(PROGRAM_TO_LOOK_FOR "PowerShell.exe")
    elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Darwin")
        set(PROGRAM_TO_LOOK_FOR "sh")
    elseif( ${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
        set(PROGRAM_TO_LOOK_FOR "sh")
    else()
        message(FATAL_ERROR "\"${CMAKE_HOST_SYSTEM_NAME}\" is not a supported build host OS.")
    endif()

    look_for_dependency_program(${PROGRAM_TO_LOOK_FOR})
    if((NOT FOUND_ALTERNATIVE) OR(FOUND_ALTERNATIVE MATCHES "^[ \t]?$"))
        message(
            FATAL_ERROR
            "test_should_exist_on_path: The program we were looking for was not found."
        ) 
    endif()
endmacro()
add_test_macro(MACRO_NAME test_should_exist_on_path)

macro(test_should_not_exist_on_path)
   set(PROGRAM_TO_LOOK_FOR "i_should_not_exist.exe")
   look_for_dependency_program(${PROGRAM_TO_LOOK_FOR})
   if(FOUND_ALTERNATIVE)
        message(
            FATAL_ERROR
            "test_should_not_exist_on_path: FOUND_ALTERNATIVE was set, indicating we somehow \"found\" a program that should not exist on the system PATH."
        )
   endif()
endmacro()
add_test_macro(MACRO_NAME test_should_not_exist_on_path)