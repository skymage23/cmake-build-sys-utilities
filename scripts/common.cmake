include_guard(GLOBAL)
#YOU SPLIT OFF YOUR CMAKE AND PYTHON FILES INTO THEIR OWN REPOSITORIES FOR EASIER FOCUS DURING THEIR DEVELOPMENT. SMART MOVE, BUT DON'T FORGET TO GLUE THE PROJECT BACK TOGETHER.
#This whole file needs to be rewritten to programmatically get these values instead.


file(REAL_PATH "${CMAKE_CURRENT_LIST_DIR}/.." MODULE_BASE)
#message(STATUS "MODULE_BASE: ${MODULE_BASE}")
##include(${MODULE_BASE}/os_host_setup.cmake)

file(REAL_PATH "${MODULE_BASE}/scripts" SCRIPTS_DIR)
#message(STATUS "SCRIPTS_DIR: ${SCRIPTS_DIR}")
