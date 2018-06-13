.text
.global bubblesort
.align 	2
.type	bubblesort, %function

bubblesort:				@ void bubblesort(&array, size)

	push	{r4, r5, r6}
	mov	r4, r0			@ r4 = &array
	mov	r5, r1			@ r5 = size 
	mov	r6, #1			@ r6 = Optimierungsvariable (wurde in innerer Schleife getauscht?)
	b	check_outer_loop

outer_loop:
	mov	r2, #0			@ r2 = index
	sub	r5, r5, #1		@ --size
	mov	r6, #0			@ r6 = false; bisher kein Tausch
	b	check_inner_loop

inner_loop:
	add	r3, r2, #1		@ j = i + 1
	ldr	r0, [r4, r2, LSL #2]	@
	ldr	r1, [r4, r3, LSL #2]	@

	cmp	r1, r0			@ if (arr[j] < arr[i])
	strlt	r1, [r4, r2, LSL #2]	@	swap(&arr[i], &arr[j])
	strlt	r0, [r4, r3, LSL #2]	@
	movlt	r6, #1			@	r6 = true;
	add	r2, r2, #1

check_inner_loop:
	cmp	r5, r2			@ size > index ?
	bgt	inner_loop

check_outer_loop:
	cmp	r5, #0			@ size > 0
	cmp	r6, #0			@ falls kein Tausch = Ende
	bgt	outer_loop
	pop	{r4, r5, r6}
	bx 	lr
