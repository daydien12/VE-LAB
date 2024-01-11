.syntax unified
.cpu cortex-m3
.thumb

.word 0x20000400
.word 0x080000ed
.space 0xe4

mov r6, #65
movw r5, #22895
movt r4, #26966
movw r3, #0x0101
movt r3, #0x2023
B .
