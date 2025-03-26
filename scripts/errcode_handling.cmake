include_guard(GLOBAL)

#Need to map errcodes to messages.
#Do we really need a hashtable?

#What if we are trying to register different error codes
#For different modules.

set(ERRCODES "")
set(ERRCODE_LIST "")

function(register_errcode ERRCODE MESSAGE)
    if(${ARGC} LESS 4)
        message(FATAL_ERROR "register_errcode: too few arguments.")
    endif()

    if(${ARGC} GREATER 4)
        message(FATAL_ERROR "register_errcode: too many arguments.")
    endif()

    set(oneValueArgs "ERRCODE" "MESSAGE")
    cmake_parse_arguments(register_errcode "" "${oneValueArgs}" "" ${ARGN})

    if((NOT register_errcode_ERRCODE) OR
       ("${register_errcode_ERRCODE}" STREQUAL ""))
        message(FATAL_ERROR "register_errcode: ERRCODE cannot be empty.")
    endif()

    if((NOT register_errcode_MESSAGE) OR
       ("${register_errcode_MESSAGE}" STREQUAL ""))
        message(FATAL_ERROR "register_errcode: MESSAGE cannot be empty.")
    endif()

    list(APPEND ERRCODE_LIST "${register_errcode_ERRCODE}, ${register_errcode_MESSAGE}")
    set(ERRCODE_LIST ${ERRCODE_LIST} PARENT_SCOPE)
endfunction()

set(ERRCODE_MESSAGE "")
function(get_message_for_errcode)
    set(temp "")
    set(ERRCODE_MESSAGE "" PARENT_SCOPE)
    if(${ARGC} LESS 2)
        message(FATAL_ERROR "get_message_for_errcode: too few arguments.")
    endif()

    if(${ARGC} GREATER 2)
        message(FATAL_ERROR "get_message_for_errcode: too many arguments.")
    endif()


    set(oneValueArgs "ERRCODE")
    cmake_parse_arguments(get_message_for_errcode "" "${oneValueArgs}" "" ${ARGN})

    if((NOT get_message_for_errcode_ERRCODE) OR
       ("${get_message_for_errcode_ERRCODE}" STREQUAL ""))
        message(FATAL_ERROR "get_message_for_errcode: ERRCODE cannot be empty")
    endif()

    foreach(VAR in ${ERRCODE_LIST})
        string(REPLACE "," ";" VAR VAR)
        list(GET "${VAR}" 0 temp)
        
        if(${get_message_for_errcode_ERRCODE} EQUAL ${temp})
            list(GET "${VAR}" 1 temp)
            set(ERRCODE_MESSAGE "${temp}" PARENT_SCOPE)
            return()
        endif()
    endforeach()
endfunction()