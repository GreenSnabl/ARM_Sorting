.text
.global swap
.align 2
.type	swap, %function

swap:
	push 	{r4}
	ldr r3, [r0, r1, LSL #2]
	ldr r4, [r0, r2, LSL #2]
	str r3, [r0, r2, LSL #2]
	str r4, [r0, r1, LSL #2]
	pop 	{r4}
	bx 	lr

