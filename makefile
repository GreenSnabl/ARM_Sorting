GCC = arm-elf-gcc

all: bubblesort quicksort heapsort

bubblesort: mainBubbleSort.S 
	$(GCC) -g -o bubblesort.elf mainBubbleSort.S BubbleSort.S Printer.S
quicksort: mainQuickSort.S
	$(GCC) -g -o quicksort.elf mainQuickSort.S QuickSort.S Swap.S Printer.S
heapsort: mainHeapSort.S
	$(GCC) -g -o heapsort.elf mainHeapSort.S HeapSort.S Swap.S Printer.S
clean:
	rm *.o
