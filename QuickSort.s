.text

.global quicksort

.type quicksort, %function

swap:
	push 	{r4}
	ldr r3, [r0, r1, LSL #2]
	ldr r4, [r0, r2, LSL #2]
	str r3, [r0, r2, LSL #2]
	str r4, [r0, r1, LSL #2]
	pop 	{r4}
	bx 	lr

partition:
	push {r4-r9, lr}
	
	mov r4, r0
	mov r5, r1
	mov r6, r2
	ldr r7, [r4, r6, LSL #2]
	sub r8, r5, #1
	mov r9, r5
	
	b check_loop_partition

partition_loop:
	ldr r0, [r4, r9, LSL #2]
	
	cmp 	r7, r0
	addge	r8, r8, #1	
	movge 	r0, r4
	movge 	r1, r8
	movge 	r2, r9
	blge	swap
	
	add	r9, r9, #1

check_loop_partition:
	cmp r6, r9
	bgt partition_loop

	mov r0, r4
	add r1, r8, #1
	mov r2, r6
	bl swap

	add r0, r8, #1
	
	pop {r4-r9, lr}
	bx lr

quicksort:
	push {r4-r7, lr}
	mov r4, r0
	mov r5, r1
	mov r6, r2

	cmp r5, r6
	bllt partition
	
	mov r7, r0	
	
	cmp r5, r6
	movlt r0, r4
	movlt r1, r5
	sublt r2, r7, #1
	bllt quicksort	

	cmp r5, r6
	movlt r0, r4
	addlt r1, r7, #1
	movlt r2, r6
	bllt quicksort

	pop {r4-r7, lr}	
	bx lr


