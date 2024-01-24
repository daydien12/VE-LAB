.syntax unified
.cpu cortex-m3
.thumb

    .word 0x20000400
    .word 0x080000ed
    .space 0xe4

main:
    ldr r0, =0x20000010 @load in the string
    ldr r1, =0x20000100 @load in the string
loop:
    ldrb r9, [r0]
    cmp r9, #0 @check for the null character
    beq exit

    cmp r9, #32
    beq skip

    cmp r9, #96
    bgt skip

    add r9, #32
    strb r9, [r1]
    add r0, r0, #1
    add r1, r1, #1
    b loop

skip:
    strb r9, [r1]
    add r0, r0, #1
    add r1, r1, #1
    b loop

exit:
    b .
