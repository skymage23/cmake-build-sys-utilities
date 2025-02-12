include_guard(GLOBAL)
include(${CMAKE_CURRENT_LIST_DIR}/common.cmake)
#include(${SCRIPTS_DIR}/debug.cmake)
include(${SCRIPTS_DIR}/dir_opts.cmake)



#CMake sucks at handling multiple returns:

function(get_targets_list_under_dir DIRECTORY)
    set(TARGET_LIST "" PARENT_SCOPE)
    set(DIR_LIST "")
    set(TARGET_LIST "")
    set(OUTPUT_TEMP "")
    set(OUTPUT_TARGET_TEMP "")
    assert_is_directory("${DIRECTORY}")
    get_subdirectories_with_cmake_lists_txt(${DIRECTORY})
    set(DIR_LIST "${GET_SUBDIRECTORIES_OUTPUT}")

    foreach(VAR ${DIR_LIST})
        get_property(OUTPUT_TEMP DIRECTORY ${VAR} PROPERTY BUILDSYSTEM_TARGETS)
        list(APPEND OUTPUT_TARGET_TEMP ${OUTPUT_TEMP})
    endforeach()
    set(TARGET_LIST "${OUTPUT_TARGET_TEMP}" PARENT_SCOPE)
endfunction()