include_guard(GLOBAL)
include(${CMAKE_SCRIPTS_DIR}/debug.cmake)
include(${CMAKE_SCRIPTS_DIR}/stack.cmake)

function(get_subdirectories_with_cmake_lists_txt DIRECTORY)
    assert_is_directory("${DIRECTORY}")

    set(GET_SUBDIRECTORIES_OUTPUT "" PARENT_SCOPE)
    set(SUBDIR_OUTPUT_LIST "")
    set(STACK "")
    set(STACK_EMPTY FALSE)
    set(STACK_ELEM_TEMP "")
    stack_init(STACK)
    set(SUBDIRECTORY "")
    set(SUBDIRECTORIES "")

    stack_push(STACK ${DIRECTORY})
    
    stack_is_empty(STACK STACK_EMPTY)
    while(NOT ${STACK_EMPTY})
        stack_pop(STACK STACK_ELEM_TEMP)
            print_debug("STACK_ELEM_TEMP: ${STACK_ELEM_TEMP}" "${CMAKE_CURRENT_FUNCTION}")
        get_property(SUBDIRECTORIES DIRECTORY ${STACK_ELEM_TEMP} PROPERTY SUBDIRECTORIES)
        foreach(SUBDIRECTORY ${SUBDIRECTORIES})
            list(APPEND SUBDIR_OUTPUT_LIST ${SUBDIRECTORY})
            stack_push(STACK ${SUBDIRECTORY})
        endforeach()
        stack_is_empty(STACK STACK_EMPTY)
    endwhile()
    set(GET_SUBDIRECTORIES_OUTPUT "${SUBDIR_OUTPUT_LIST}" PARENT_SCOPE)

endfunction()

