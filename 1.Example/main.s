.syntax unified
.cpu cortex-m3
.thumb

.word 0x20000400
.word 0x080000ed
.space 0xe4

main:
    ldr   r1, =0x20000100
    ldrb   r3, [r1, #1] 
    mov r6, r3
B .
