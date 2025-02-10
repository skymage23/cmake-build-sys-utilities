include_guard(GLOBAL)
# Stack implementation using CMake lists
# Usage: include(stack.cmake)

# Initialize an empty stack
function(stack_init STACK_NAME)
    set(${STACK_NAME} "" PARENT_SCOPE)
endfunction()

# Push an element onto the stack
function(stack_push STACK_NAME ELEMENT)
    # Get the current stack
    set(TEMP_STACK ${${STACK_NAME}})
    # Add the new element to the front (top) of the list
    list(PREPEND TEMP_STACK ${ELEMENT})
    # Update the stack in parent scope
    set(${STACK_NAME} ${TEMP_STACK} PARENT_SCOPE)
endfunction()

# Pop an element from the stack
function(stack_pop STACK_NAME RESULT_VAR)
    # Get the current stack
    set(TEMP_STACK ${${STACK_NAME}})
    # Check if stack is empty
    list(LENGTH TEMP_STACK STACK_SIZE)
    if(STACK_SIZE EQUAL 0)
        message(WARNING "Cannot pop from empty stack")
        set(${RESULT_VAR} "" PARENT_SCOPE)
        return()
    endif()
    
    # Get the top element
    list(GET TEMP_STACK 0 TOP_ELEMENT)
    # Remove the top element
    list(REMOVE_AT TEMP_STACK 0)
    
    # Update the stack and return the popped value
    set(${STACK_NAME} ${TEMP_STACK} PARENT_SCOPE)
    set(${RESULT_VAR} ${TOP_ELEMENT} PARENT_SCOPE)
endfunction()

# Get the top element without removing it
function(stack_peek STACK_NAME RESULT_VAR)
    # Get the current stack
    set(TEMP_STACK ${${STACK_NAME}})
    # Check if stack is empty
    list(LENGTH TEMP_STACK STACK_SIZE)
    if(STACK_SIZE EQUAL 0)
        message(WARNING "Cannot peek empty stack")
        set(${RESULT_VAR} "" PARENT_SCOPE)
        return()
    endif()
    
    # Get the top element
    list(GET TEMP_STACK 0 TOP_ELEMENT)
    set(${RESULT_VAR} ${TOP_ELEMENT} PARENT_SCOPE)
endfunction()

# Check if stack is empty
function(stack_is_empty STACK_NAME RESULT_VAR)
    list(LENGTH ${STACK_NAME} STACK_SIZE)
    if(STACK_SIZE EQUAL 0)
        set(${RESULT_VAR} TRUE PARENT_SCOPE)
    else()
        set(${RESULT_VAR} FALSE PARENT_SCOPE)
    endif()
endfunction() 
