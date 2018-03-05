TITLE Composite Numbers   (demo1.asm)

; Author: Lim Cheng Qing
; Course / Project ID: Programming Assignment #5                  Date: 1/3/2018
; Description: 
; Below are the program task: 
;	1. Introduce the program.
;	2. Get a user request in the range [min = 10 .. max = 200].
;	3. Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements
;	of an array.
;	4. Display the list of integers before sorting, 10 numbers per line.
;	5. Sort the list in descending order (i.e., largest first).
;	6. Calculate and display the median value, rounded to the nearest integer.
;	7. Display the sorted list, 10 numbers per line.



INCLUDE Irvine32.inc

; (Upper limit for user input)
UPPER_LIMIT = 400			; E.G.


;  Get a user request in the range
min = 10
max = 200

; Generate request random integers in the range,
lo = 100
hi = 999

.data
introduction_message_1	BYTE	"Sorting Random Integers			Programmed by Lim Cheng Qing",0
introduction_message_2	BYTE	"This program generates random numbers in the range [100 .. 999],",0
introduction_message_3	BYTE	"displays the original list, sorts the list, and calculates the,",0
introduction_message_4	BYTE	"median value. Finally, it displays the list sorted in descending order.",0

question_message_1	BYTE	"How many numbers should be generated? [10 .. 200]: ", 0

input_invalid_message	BYTE	"Invalid input ",0

output_message_1	BYTE	"The unsorted random numbers: ",0
output_message_2	BYTE	"The median is  ",0
output_message_3	BYTE	"The sorted list:: ",0

input_1	DWORD	?
array DWORD max DUP(?)

median DWORD ?

count			BYTE	0
space			BYTE	"   ", 0

.code
main PROC

	; ------------Program Introduction Section----------
	call	introduction;
	;---------------------------------------------------

	; ------------Program getData Section----------
	push	OFFSET input_1
	call	getData
	;---------------------------------------------------

	; ------------Program fillArray Section----------
	push	OFFSET array
	push	input_1
	call	fillArray
	;---------------------------------------------------

	; ------------Program displayList Section----------
	call	CrLf
	mov		edx, OFFSET output_message_1
	call	WriteString
	call	CrLf

	push	OFFSET array
	push	input_1

	call	displayList
	call	CrLf
	;---------------------------------------------------

	; ------------Program sortList Section----------
	push	OFFSET array
	push	input_1
	call	sortList
	;---------------------------------------------------

	; ------------Program displayMedian Section----------
	push	OFFSET array
	push	input_1

	mov		edx, OFFSET output_message_2
	call	WriteString
	call	displayMedian
	call	CrLf
	;---------------------------------------------------

	; ------------Program displayList Section----------
	mov		edx, OFFSET output_message_3
	call	WriteString
	call	CrLf

	push	OFFSET array
	push	input_1

	call	displayList
	call	CrLf
	;---------------------------------------------------

	exit	; exit to operating system
main ENDP


; ---------------------------------------------------------
; Procedure to display program instructions
; receives: introduction_message_1, introduction_message_2, introduction_message_3,
;			introduction_message_4 
; returns: nothing
; preconditions: n/a
; registers changed: n/a
; ---------------------------------------------------------
introduction PROC USES edx

	mov edx, OFFSET introduction_message_1
	call	WriteString
	call	CrLf

	mov edx, OFFSET introduction_message_2
	call	WriteString
	call	CrLf

	mov edx, OFFSET introduction_message_3
	call	WriteString
	call	CrLf

	mov edx, OFFSET introduction_message_4
	call	WriteString
	call	CrLf
	call	CrLf

	ret

introduction ENDP


; ---------------------------------------------------------
; Procedure Obtain user number input
; receives: n/a
; returns: n/a
; preconditions: n/a
; registers changed: n/a
; ---------------------------------------------------------
getData PROC

	push	ebp
	mov		ebp, esp

userInput:

	mov edx, OFFSET question_message_1
	call	WriteString
	call	CrLf											; Display Input Instruction

	call	ReadDec
	mov		input_1, eax									; Store input to variable "input_1"

	cmp		input_1, min
	jl		error											; if(input_1 < min) { goto error}

	cmp		input_1, max									; if(input_1 > max) {goto error}
	jg		error

	pop		ebp												; Obtain range, get value from stack
	
	ret														; return 

error:
	mov edx, OFFSET input_invalid_message
	call WriteString
	call CrLf											; Display error message if user's input invalid	

	jmp	userInput										; Jmp to top procedure

getData ENDP


; ---------------------------------------------------------
; Procedure: Fills an array with random numbers
; receives: The topmost of the stack parameter and the number of elements in the array
; returns: n/a
; preconditions: parameters must be in the stac
; registers changed: n/a
; ---------------------------------------------------------
fillArray PROC

	push	ebp
	mov		ebp, esp											;Set up stack above
	mov		esi, [ebp+12]										;Set address of array
	mov		ecx, [ebp+8]										;Get counter value for loop

	cmp		ecx, 0
	JE		quitt												;If (ecx (loop register) == 0)	{goto endHello}					; 

	mov		edx, hi												 
	sub		edx, lo												; (const)999 - (const)100

again:

	mov		eax, edx
	call	RandomRange											;Obtain random number					
	add		eax,lo
	mov		[esi], eax											;Cur element
	add		esi, 4												;Next element
	loop	again													

quitt:
	pop		ebp													;Return stack
	ret		8													;Return 

fillArray ENDP


; ---------------------------------------------------------
; Procedure: Displays the given array
; receives: The address of the topmost stacks and the number of elements in the array
; returns: n/a
; preconditions: Parameters must be in the stack
; registers changed: n/a
; ---------------------------------------------------------
displayList PROC						

	push	ebp
	mov		ebp, esp												;Set up address above stack
	mov		esi, [ebp+12]											;Set address of array	
	mov		ecx, [ebp+8]											;Get  counter for loop

print:
	mov		eax, [esi]												;Current element
	call	WriteDec												;Print current element
	add		count, 1
	mov		edx, OFFSET space										;Print space between the numbers
	call	WriteString

	cmp		count, 10												;if (count == 10){print "\n"; count = 0}
	je		newLine													
	jmp		next_print

newLine:
	call	CrLf													;print "\n" 
	mov		count, 0												;(variable) count = 0 (to reset)
	jmp		next_print

next_print:
	add		esi, 4													;Point to next element of array
	loop	print													;loop to (print) to display elements (ecx - 1)

end_Print:
	pop		ebp														;restore stack
	ret		8														;return	

displayList ENDP

; ---------------------------------------------------------
; Procedure: using bubble sort technique to sort an array in descending order
; receives: The address of the topmost stacks and the number of elements in the array
; returns: n/a
; preconditions: n/a
; registers changed: n/a
; ---------------------------------------------------------
sortList	PROC													; Bubble sort algorithm from text-book pp 376
	push	ebp
	mov		ebp, esp						
	mov		ecx, [ebp+8]											; get count for loop

loop1:
	push	ecx														;Store count from ECX register
	mov		esi,[ebp+12]											;Point to first value in array

loop2:
	mov		eax, [esi]												;Cur value

	cmp		[esi+4], eax											;Compare cur to next value
	jl		loop3													;if (cur < next_value) { jump to loop 3}

	xchg	eax, [esi+4]											;else {Exchange the values}
	mov		[esi], eax												;Store value

loop3:
	add		esi, 4													;Go to next element
	loop	loop2

	pop		ecx													
	loop	loop1

	loop4:
	pop		ebp														;Restore stack
	ret		8														;Return

sortList	ENDP


; ---------------------------------------------------------
; Procedure: Display the median number of a sorted array
; receives: The address of the topmost stacks and the number of elements in the array
; returns: n/a
; preconditions: n/a
; registers changed: n/a
; ---------------------------------------------------------
displayMedian proc

	push	ebp
	mov		ebp, esp												;Set up address above stack
	mov		esi, [ebp+12]											;Get address of array
	mov		ebx, [ebp+8]											;Get elements in the array

	xor		edx, edx												;Set edx = 0
	mov		eax, ebx												
	mov		ebx, 2
	div		ebx														; elements in array / 2 

	cmp		edx, 0		
	je		even_median												; if 0 {it's even}

	cmp		edx, 1
	je		odd_median												; if(1) {it's odd}
	jmp		 end_median

even_median:
	
	mov		ebx, eax												; Store the first element of the median
	dec		ebx														; Dec the first element of median to obtain 
																		;second element

	mov		edx,4													
	mul		edx														; multiply first element by 4 
	mov edx, [esi+eax]												; Obtain first median element from stack
	mov median, edx													; Store median

	mov		eax, ebx												; Store the second element of the median elements
	mov		edx,4 
	mul		edx														; multiply eax by 4
	mov		edx, [esi+eax]											; Store second median elements to edx
	

	mov		eax, median
	add		eax, edx												; move to the second median address 
	mov		median, eax												; Store (first median element + second median element)
	
	mov		ebx, 2													
	xor		edx, edx												;Set edx to 0
	div		ebx														;Divide total median /2
	mov		median, eax												;Store value

	jmp end_median

odd_median:
	mov		edx,4													
	mul		edx														;Multiply element by 4 
	mov		ebx, [esi+eax]											;Store the elements 
	mov		median, ebx													
	jmp		end_median												


end_median:
	mov		 eax, median											
	call	 WriteDec												;Print median
	call	 CrLf

	pop		ebp														;Restore stack
	ret		8														;Return

displayMedian ENDP

END main