.text
.align 2

left:
        mov r0, r0, LSL #1
        add r0, r0, #1  
        bx lr

right:
        mov r0, r0, LSL #1
        add r0, r0, #2  
        bx lr

swap:
        push    {r4, lr}
        ldr     r3, [r0, r1, LSL #2]
        ldr     r4, [r0, r2, LSL #2]
        str     r3, [r0, r2, LSL #2] 
        str     r4, [r0, r1, LSL #2]
        pop     {r4, lr}
        bx lr


max_heapify:

        push {r4-r9, lr}
        mov r4, r0              @ r4 = &array
        mov r5, r1              @ r5 = i
        mov r6, r2              @ r6 = size
        b       check_loop

loop:
        mov r7, r5              @ r7 = index
        mov r0, r5
        bl left                 @ left(i) = 2 * i + 1
        mov r8, r0              @ r8 = l

        mov r0, r5
        bl right                 @ right(i) = 2 * i + 2
        mov r9, r0               @ r9 = r

check_left:
        cmp r8, r6
        ldrlt r1, [r4, r8, LSL #2]
        ldrlt r2, [r4, r7, LSL #2]
        cmplt r2, r1
        movlt r7, r8

check_right:
        cmp r9, r6
        ldrlt r1, [r4, r9, LSL #2]
        ldrlt r2, [r4, r7, LSL #2]
        cmplt r2, r1
        movlt r7, r9

index_i:
        cmp r7, r5
        beq end

        mov r0, r4
        mov r1, r5
        mov r2, r7
        bl swap

        mov r5, r7

check_loop:
        cmp r5, r6
        blt loop

end:
        pop {r4-r9, lr}
        bx lr


build_max_heap:
        push {r4-r7, lr}
        mov r4, r0              @ r4 = &array
        mov r5, r1, ASR #1      @ r5 = i =  size / 2
        mov r6, r1              @ r6 = size
        b check_loop2
loop2:
        mov r0, r4
        mov r1, r5
        mov r2, r6
        bl max_heapify

check_loop2:
        subs r5, r5, #1         @ i--
        bge loop2               @ if (i >= 0)

        pop {r4-r7, lr}
        bx lr

.global heapsort
.align 	2
.type	heapsort, %function
heapsort:
        push {r4-r5, lr}

        mov r4, r0              @ r4 = &array
        mov r5, r1              @ r5 = arraysize

        bl build_max_heap       @ build_max_heap(&array, size)

        b check_loop3
loop3:
        mov r0, r4
        mov r1, #0
        mov r2, r5
        bl swap

        mov r0, r4
        mov r1, #0
        mov r2, r5
        bl max_heapify

check_loop3:
        subs r5, r5, #1
        bne loop3

        pop {r4-r5, lr}
        bx lr

