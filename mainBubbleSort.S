.global main

main:
        push {r4-r5, lr}
        ldr r0, =array
        mov r1, r0
        add r0, r0, #4
        ldr r1, [r1]
        mov r2, #1
        rsb r1, r2, r1, ASR #2  

        mov r4, r0
        mov r5, r1

        bl printer

        mov r0, r4
        mov r1, r5

        bl bubblesort 

        mov r0, r4
        mov r1, r5

        bl printer

        pop {r4-r5, lr}
        bx lr

.data
.align 2
message: .asciz "Array:"
.align 2
number: .asciz " %d"
.align 2
newline: .asciz "\n"
.align 2
array: .word (array_end-array), 5, 4 , 6, 12, 3, 53, 63, 16, 77, 56, 45, 43, 15, 17, 435, 2342, 6969, 4345, 34344, 2322, 9453, 234, 1345, 66321
array_end:
