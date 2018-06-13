.text
.global quicksort
.align 2
.type quicksort, %function

partition:
	push {r4-r9, lr}
	
	mov r4, r0			@ r4 = &array;
	mov r5, r1			@ r5 = low;
	mov r6, r2			@ r6 = high;
	ldr r7, [r4, r6, LSL #2]	@ r7 = pivot = array[high];
	sub r8, r5, #1			@ i  = low - 1;
	mov r9, r5			@ j  = low;
	
	b check_loop_partition

partition_loop:
	ldr r0, [r4, r9, LSL #2]	@ r0 = array[j];
	
	cmp	r0, r7			@ if (arr[j] <= pivot)
	addle	r8, r8, #1		@ 	++i;
	cmple	r8, r9			@	if (i < j)
	movlt	r0, r4			@     	   swap(&array, i, j);
	movlt	r1, r8			@ 
	movlt	r2, r9			@
	bllt	swap			@
	
	add	r9, r9, #1

check_loop_partition:
	cmp r6, r9			@ if (high > j)
	bgt partition_loop		

	mov r0, r4			
	add r1, r8, #1
	mov r2, r6
	bl swap				@ swap(&array, i + 1, high);

	add r0, r8, #1			@ return (i + 1);
	
	pop {r4-r9, lr}
	bx lr

quicksort:
	push {r4-r7, lr}
	mov r4, r0			@ r4 = &array;
	mov r5, r1			@ r5 = low;
	mov r6, r2			@ r6 = high;

	cmp r5, r6			@ if (low < high)
	bllt partition			@	r0 = pivot = partition(&array, low, high);
					@ Pivotelement befindet sich an korrekter Position im Array
	
	mov r7, r0			@ r7 = r0 = pivot;
	
	cmp r5, r6			@ if (low < high)
	movlt r0, r4			@	quicksort(&array, low, pivot - 1);
	movlt r1, r5
	sublt r2, r7, #1		@ Rekursion
	bllt quicksort	

	cmp r5, r6			@ if (low < high)
	movlt r0, r4			@	quicksort(&array, pivot + 1, high)
	addlt r1, r7, #1
	movlt r2, r6			@ Rekursion
	bllt quicksort

	pop {r4-r7, lr}	
	bx lr
