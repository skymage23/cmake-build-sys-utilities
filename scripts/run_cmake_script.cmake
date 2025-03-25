function(run_cmake_script)

    if(${ARGC} LESS 2)
        message(FATAL_ERROR "run_cmake_script: too few arguments.")
    endif()

    if(${ARGC} GREATER 4)
        message(FATAL_ERROR "run_cmake_script: too many arguments.")
    endif()

    set(oneValueArgs "INPUT" "WORKING_DIRECTORY")
    cmake_parse_arguments(arg_run_cmake_script "" "${oneValueArgs}" "" ${ARGN})

    foreach(i RANGE ${ARGC})
        message(STATUS "Argument ${i}: ${ARGV${i}}")
    endforeach()    


    if((NOT arg_run_cmake_script_INPUT) OR
       ("${arg_run_cmake_script_INPUT}" STREQUAL ""))
        message(FATAL_ERROR "run_cmake_script: INPUT argument does not exist or it is empty.")
    endif()

    file(REAL_PATH "${arg_run_cmake_script_INPUT}" arg_run_cmake_script_INPUT EXPAND_TILDE)

    if(NOT EXISTS "${arg_run_cmake_script_INPUT}")
        message(FATAL_ERROR "run_cmake_script: INPUT does not exist on the filesystem.")
    endif()

    if(IS_DIRECTORY "${arg_run_cmake_script_INPUT}")
        message(FATAL_ERROR "run_cmake_script: INPUT is not a directory, not a file.")
    endif()

 

    if((NOT arg_run_cmake_script_WORKING_DIRECTORY) OR
       ("${arg_run_cmake_script_WORKING_DIRECTORY}" STREQUAL ""))
        message(FATAL_ERROR "run_cmake_script: WORKING_DIRECTORY argument does not exist or it is empty.")
    endif()

    file(REAL_PATH "${arg_run_cmake_script_WORKING_DIRECTORY}" arg_run_cmake_script_WORKING_DIRECTORY EXPAND_TILDE)

    if(NOT EXISTS "${arg_run_cmake_script_WORKING_DIRECTORY}")
        message(FATAL_ERROR "run_cmake_script: WORKING_DIRECTORY does not exist on the filesystem.")
    endif()

    if(NOT IS_DIRECTORY "${arg_run_cmake_script_WORKING_DIRECTORY}")
        message(FATAL_ERROR "run_cmake_script: WORKING_DIRECTORY is not a file, not a directory.")
    endif()


    execute_process(
        COMMAND "${CMAKE_COMMAND}" "-P" ${arg_run_cmake_script_INPUT}
        WORKING_DIRECTORY "${arg_run_cmake_script_WORKING_DIRECTORY}"
        COMMAND_ERROR_IS_FATAL ANY 
    )
endfunction()