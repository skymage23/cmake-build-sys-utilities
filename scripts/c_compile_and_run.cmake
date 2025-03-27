include_guard(GLOBAL)
include("${CMAKE_CURRENT_LIST_DIR}/os_host_opts.cmake")

set(MSBUILD_STARTER_OPTS "-property:Configuration=Release")
set(MAKE_STARTER_OPTS "")

function(try_find_build_system PROG_NAME)
    unset(BUILD_SYS_COMMAND PARENT_SCOPE)
    #Hello
    set(executable_suffix "")
    if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
        look_for_dependency_program("MSBuild.exe")
        if(FOUND_ALTERNATIVE)
            if("${MSBUILD_STARTER_OPTS}" STREQUAL "")
                set( BUILD_SYS_COMMAND "${FOUND_ALTERNATIVE};${PROG_NAME}.sln" PARENT_SCOPE)
            else()
            set(
                BUILD_SYS_COMMAND "${FOUND_ALTERNATIVE};${MSBUILD_STARTER_OPTS};${PROG_NAME}.sln"
                PARENT_SCOPE
            )
            endif()
            return()
        endif()
        set(executable_suffix ".exe") 
    endif()

    look_for_dependency_program("make${executable_suffix}")
    if(FOUND_ALTERNATIVE)
        if("${MAKE_STARTER_OPTS}" STREQUAL "")
            set(BUILD_SYS_COMMAND "${FOUND_ALTERNATIVE}" PARENT_SCOPE)
        else()
            set(BUILD_SYS_COMMAND "${FOUND_ALTERNATIVE};${MAKE_STARTER_OPTS}" PARENT_SCOPE)
        endif()
    endif()
endfunction()


function(c_compile_and_run C_PROGRAM PROG_ARGS)
   unset(PROG_STDOUT PARENT_SCOPE)
   unset(PROG_STDERR PARENT_SCOPE)
   unset(PROG_RETVAL PARENT_SCOPE)

   set(project_name "my_project")
   set(my_cmake_file "
   cmake_minimum_required(VERSION 3.0)

   project(${project_name})
   add_executable(${project_name} ${project_name}.c)
   install(
        TARGETS ${project_name}
        DESTINATION \${CMAKE_CURRENT_LIST_DIR}
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
        RUNTIME
    )
   ")

   set("temp_filepath" "${CMAKE_CURRENT_LIST_DIR}/${project_name}")
   if(EXISTS "${temp_filepath}")
       file(REMOVE_RECURSE "${temp_filepath}")
   endif()

   file(MAKE_DIRECTORY "${temp_filepath}") 
   file(WRITE "${temp_filepath}/${project_name}.c" "${C_PROGRAM}")
   file(WRITE "${temp_filepath}/CMakeLists.txt" "${my_cmake_file}")
   file(MAKE_DIRECTORY "${temp_filepath}/build")

   try_find_build_system("${project_name}")
   if(NOT BUILD_SYS_COMMAND)
       message(FATAL_ERROR "Unable to find a supported C Programming Language build system.")
   endif()
   
   execute_process(
       COMMAND cmake ..
       WORKING_DIRECTORY "${temp_filepath}/build"
       COMMAND_ECHO STDOUT
       COMMAND_ERROR_IS_FATAL ANY
   )

   execute_process(
       COMMAND ${BUILD_SYS_COMMAND}
       WORKING_DIRECTORY "${temp_filepath}/build"
       COMMAND_ECHO STDOUT
       COMMAND_ERROR_IS_FATAL ANY
   )

   set(program_command "")
   if("${CMAKE_HOST_SYSTEM_NAME}" STREQUAL "Windows")
       #hello:
       set(program_command "./Release/${project_name}.exe")
   else()
       set(program_command "./${project_name}")
   endif()

   execute_process(
       COMMAND ${program_command} ${PROG_ARGS}
       WORKING_DIRECTORY "${temp_filepath}/build"
       OUTPUT_VARIABLE PROG_STDOUT
       ERROR_VARIABLE PROG_STDERR
       RESULT_VARIABLE PROG_RETVAL
       COMMAND_ERROR_IS_FATAL ANY
   )

   set(PROG_STDOUT ${PROG_STDOUT} PARENT_SCOPE)
   set(PROG_STDERR ${PROG_STDERR} PARENT_SCOPE)
   set(PROG_RETVAL ${PROG_RETVAL} PARENT_SCOPE)
   file(REMOVE_RECURSE "${temp_filepath}")
endfunction()