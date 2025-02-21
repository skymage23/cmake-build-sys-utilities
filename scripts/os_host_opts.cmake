include_guard(GLOBAL)

#There appears to be some weirdness in the CMake
#implementation (v3.31.4) where function scopes
#persist across function calls. This means
#that variables set during a previous invocation
#are still set in the next. Thus,
#we have to clear local variables before
#we set them once again.

#It may be related to this:
# https://www.mgaudet.ca/technical/2017/8/31/some-notes-on-cmake-variables-and-scopes

#Our workaround (determined via trial and error) is to both
#manually unset local variables and to use the "NO_CACHE"
#argument of "find_program". Things work now.
#We should investigate why, if only to see
#if there is a more universal solution
#that we can apply elsewhere, but that
#is not a priority.
function(look_for_dependency_program)
    unset(FOUND_ALTERNATIVE)
    unset(FOUND_ALTERNATIVE PARENT_SCOPE)
    list(LENGTH ARGN ARG_LEN_OUTPUT)
    if(ARG_LEN_OUTPUT LESS 1)
        message(FATAL_ERROR "No arguments passed.")
    endif()

    foreach(ALTERNATIVE ${ARGN})
	    find_program(FOUND_ALTERNATIVE ${ALTERNATIVE} NO_CACHE)
        if(FOUND_ALTERNATIVE MATCHES "-NOTFOUND[ \t]?$")
            unset(FOUND_ALTERNATIVE PARENT_SCOPE)
        else()
            break()
        endif()
    endforeach()

    if(FOUND_ALTERNATIVE)
        set(FOUND_ALTERNATIVE "${FOUND_ALTERNATIVE}" PARENT_SCOPE)
    endif()
endfunction()