include_guard(GLOBAL)
#What if the user changes the log file during execution?
#Easy. WE DON'T LET THEM!

#Do we need log churn?
#Maybe. If so, we do the churn when this file is first executed.


#set(LOG_HOLD_LIMIT 5)
#set(LOG_HOLD_TIMEOUT "") #When to dump old logs.

if(DEFINED ENV{BUILD_LOG_FILE})
    set(BUILD_LOG "$ENV{BUILD_LOG_FILE}")
else()
    set(BUILD_LOG "${CMAKE_CURRENT_LIST_DIR}/build_log.txt")
endif()

file(REMOVE "${BUILD_LOG}")

function(log MESSAGE)
   file(APPEND "${BUILD_LOG}" "${MESSAGE}")
   message(STATUS "${MESSAGE}")
endfunction()