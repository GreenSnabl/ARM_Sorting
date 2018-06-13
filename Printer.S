.text
.global printer
.align 	2
.type	printer, %function

printer:
	push    {r4-r6, lr}

        mov     r4, r0
        mov     r5, r1
	mov     r6, #0

	b       check_print_loop

print_loop:
	ldr     r0, =number
	ldr     r1, [r4, r6, LSL #2]
	bl      printf
	add     r6, r6, #1

check_print_loop:
	cmp     r5, r6
	bgt     print_loop
	
	ldr	r0, =newline
	bl	printf

	pop     {r4-r6, lr}
	bx      lr

.data
number:	.asciz	"%d "
newline: .asciz "\n"

