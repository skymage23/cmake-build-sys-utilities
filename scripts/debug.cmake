include_guard(GLOBAL)

#
# Assert functions:
########################

function(assert_filesystem_object PATH)
    if(NOT EXISTS "${PATH}")
        message(FATAL_ERROR "ASSERT_FAILED: ${CMAKE_CURRENT_FUNCTION}, PATH: ${PATH}")
    endif()
endfunction()

function(assert_is_directory PATH)
    assert_filesystem_object("${PATH}")
    if(NOT IS_DIRECTORY "${PATH}")
        message(FATAL_ERROR "ASSERT_FAILED: ${CMAKE_CURRENT_FUNCTION}, PATH: ${PATH}")
    endif()
endfunction()

#
# Helper functions:
########################
#Yeah. This needs to be fixed.
function(print_debug MESSAGE LOCAL_PREFIX)
    if($ENV{DEBUG})
        set(PREFIX "")
        get_filename_component(PREFIX ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
        #
        #Some of our tests require running CMake in a separate process
        #in isolation.  Those tests are defined in a CMakeLists.txt
        #file located inside a directory named according to the 
        #test. Hence, for those CMake files, we use the directory
        #name as the debug logging prefix instead of the filename.
        #

        if(NOT "${PREFIX}" MATCHES "test_")
           get_filename_component(PREFIX ${CMAKE_CURRENT_LIST_FILE} NAME)
        else()
           get_filename_component(PREFIX ${PREFIX} NAME)
        endif()

        if(LOCAL_PREFIX)
            set(PREFIX "${PREFIX}: ${LOCAL_PREFIX}")
        endif()

        message(STATUS "DEBUG: ${PREFIX}: ${MESSAGE}")
    endif()
endfunction()

