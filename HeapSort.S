.global heapsort
.align 	2
.type	heapsort, %function

left:
        mov r0, r0, LSL #1		@ left 	= 2*i + 1
        add r0, r0, #1  
        bx lr

right:
        mov r0, r0, LSL #1		@ right = 2*i + 1
        add r0, r0, #2  
        bx lr

max_heapify:

        push {r4-r9, lr}
        mov r4, r0              	@ r4 = &array;
        mov r5, r1              	@ r5 = i;
        mov r6, r2              	@ r6 = size;
        b       check_loop

loop:
        mov r7, r5              	@ r7 = index = i;
        mov r0, r5
        bl left                 	@ r0 = left(i);
        mov r8, r0              	@ r8 = r0 = left;

        mov r0, r5			
        bl right                	@ r0 = right(i);
        mov r9, r0              	@ r9 = r0 = right;

check_left:				@ Überprüfung linke Child-Node
        cmp r8, r6			@ if (l < size)	
        ldrlt r1, [r4, r8, LSL #2]	@	r1 = arr[l];
        ldrlt r2, [r4, r7, LSL #2]	@	r2 = arr[index];
        cmplt r2, r1			@ 	if (arr[index] < arr[l])
        movlt r7, r8			@		index = l;

check_right:				@ Überprüfung rechte Child-Node
        cmp r9, r6			@ if (r < size)
        ldrlt r1, [r4, r9, LSL #2]	@ 	r1 = arr[r];
        ldrlt r2, [r4, r7, LSL #2]	@	r2 = arr[index];
        cmplt r2, r1			@	if (arr[index] < arr[r])
        movlt r7, r9			@		index = r;

index_i:				@ Hat sich index geändert?
        cmp r7, r5			@ if (i == index)
        beq end				@	return;

        mov r0, r4
        mov r1, r5
        mov r2, r7
        bl swap				@ swap(&arr[i], &arr[index]);

        mov r5, r7			@ i = index;

check_loop:
        cmp r5, r6			@ if (size < i)
        blt loop			

end:
        pop {r4-r9, lr}
        bx lr


build_max_heap:
        push {r4-r7, lr}
        mov r4, r0              	@ r4 = &array;
        mov r5, r1, ASR #1      	@ r5 = index =  size / 2;
        mov r6, r1              	@ r6 = size;
        b check_loop2
loop2:
        mov r0, r4			@ Funktionsparameter vorbereiten
        mov r1, r5
        mov r2, r6
        bl max_heapify			@ max_heapify(&arr, index, size);

check_loop2:
        subs r5, r5, #1         	@ --index;
        bge loop2               	@ if (index >= 0)

        pop {r4-r7, lr}
        bx lr


heapsort:
        push {r4-r5, lr}

        mov r4, r0              	@ r4 = &array;
        mov r5, r1              	@ r5 = size;

        bl build_max_heap       	@ build_max_heap(&array, size);

        b check_loop3
loop3:
        mov r0, r4		
        mov r1, #0
        mov r2, r5
        bl swap				@ swap(&arr, index_i, index_j);

        mov r0, r4
        mov r1, #0
        mov r2, r5
        bl max_heapify			@ max_heapify(&arr, 0, size);

check_loop3:
        subs r5, r5, #1			@ --size;
        bne loop3			@ if (size >= 0)

        pop {r4-r5, lr}
        bx lr

