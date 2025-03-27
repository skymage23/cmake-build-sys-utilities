include_guard(GLOBAL)
include("${CMAKE_CURRENT_LIST_DIR}/check_endianness.cmake")

macro(ROTL result value bits)
   math(EXPR result "(${value} << ${bits}) | (${value} >> (64 - ${bits}))")
endmacro()


macro(sipround ROUNDS)
    math(EXPR v0 "${v0} + ${v1}")
    ROTL(v1 ${v1} 13)
    math(EXPR v1 "${v1} ^ ${v0}")
    ROTL(v0 ${v0} 32)
    math(EXPR v2 "${v2} + ${v3}")
    ROTL(v3 ${v3} 16)
    math(EXPR v3 "${v3} ^ ${v2}")
    math(EXPR v0 "${v0} + ${v3}")
    ROTL(v3 "${v3}" 21)
    math(EXPR v3 "${v3} ^ ${v0}")
    math(EXPR v2 "${v3} + ${v1}")
    ROTL(v1 "${v1}" 17)
    math(EXPR v1 "${v1} ^ ${v2}")
    ROTL(v2 "${v2}" 32)
endmacro()

#Attempts to break the message up into
#64-bit chunks.  Output is the broken-up
#message in the form of a CMake list.

#Don't forget: Little endian.
set(BROKEN_MESSAGE "")
function(break_message_for_siphash MESSAGE)
    set(BROKEN_MESSAGE "" PARENT_SCOPE)
    get_system_text_encoding()
endfunction()

set(HASH "")
#Ints are automatically signed 64-bit.
function(siphash KEY0 KEY1 COMPRESSION_ROUNDS FINALIZATION_ROUNDS MESSAGE)
    set(temp "")
    #LITTLE ENDIAN ONLY!
    check_endianness()
    if(NOT "${ENDIANNESS}" STREQUAL "LITTLE")
        message(FATAL_ERROR "Endiannesses other than Little Endian are not supported.")
    endif()

    #Constants from SipHash specification.
    math(EXPR v1 "${KEY0} ^ 0x736f6d6570736575" )
    math(EXPR v2 "${KEY1} ^ 0x646f72616e646f6d" )
    math(EXPR v3 "${KEY0} ^ 0x6c7967656e657261" )
    math(EXPR v4 "${KEY1} ^ 0x7465646279746573" )

    break_message_for_siphash("${MESSAGE}")
    foreach(VAR in ${BROKEN_MESSAGE})
        math(EXPR v3 "${v3} ^ ${VAR}")
        sipround("${COMPRESSION_ROUNDS}")
        math(EXPR v0 "${v0} ^ ${VAR}")
    endforeach()
    math(EXPR v2 "${v2} ^ 0xff")
    sipround("${FINALIZATION_ROUNDS}")
    
    math(EXPR temp "${v0} ^ ${v1} ^ ${v2} ^ ${v3}")
    set(HASH "${temp}" PARENT_SCOPE)
endfunction()


#Remember, this is little endian, in terms of byte oder.
#01000000000000ab