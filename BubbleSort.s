.global bubblesort
.align 	2
.type	bubblesort, %function

bubblesort:				@ void bubblesort(&array, size)

	push	{r4, r5}
	mov	r4, r0
	mov	r5, r1
	b	check_outer_loop

outer_loop:
	mov	r2, #0
	sub	r5, r5, #1
	b	check_inner_loop

inner_loop:
	add	r3, r2, #1
	ldr	r0, [r4, r2, LSL #2]
	ldr	r1, [r4, r3, LSL #2]

	cmp	r1, r0
	strlt	r1, [r4, r2, LSL #2]
	strlt	r0, [r4, r3, LSL #2]
	add	r2, r2, #1

check_inner_loop:
	cmp	r5, r2
	bgt	inner_loop

check_outer_loop:
	cmp	r5, #0
	bgt	outer_loop
	pop	{r4, r5}
	bx 	lr
