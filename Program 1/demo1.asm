TITLE Assignment1     (demo1.asm)

; Author: Lim Cheng Qing
; CS271	in-class demo        1/20/2011
; Description:  This program gets two integers from the user,
;	and calculates the sum, difference, product, (integer) 
;	quotient and remainder of the numbers. For example, if the user enters
;	1 and 10, the program calculates 1+10, 1-10, 1*10, 1/10.
;	Note: This program does not perform any data validation.
;	If the user gives invalid input, the output will be
;	meaningless.

INCLUDE Irvine32.inc

.data
intro		BYTE	"Elementary Arithmetic by Lim Cheng Qing ", 0
message1	BYTE	"Enter 2 numbers, and I'll show you the sum, difference,", 0
message2	BYTE	"product, quotient, and remainder. ",0

validate_mesage BYTE "The second number must be less than the first! ",0

credit_message1 BYTE "**EC: Repeat until the user chooses to quit. ", 0
credit_message2 BYTE "**EC: Program verifies second number less than first. ",0

input_message1	BYTE	"First number: ",0
input_message2	BYTE	"Second number: ",0

exit_message1	BYTE	"Would you like to exit the program?",0
exit_message2	BYTE	"Input 1 to repeat || 2 to exit",0

exit_input		DWORD	?

input_data1		DWORD	?
input_data2		DWORD	?

add_output			DWORD	?
sub_output			DWORD	?
mul_output			DWORD	?
fdiv_output			DWORD	?
div_output			DWORD	?
r_output			DWORD	?

add_symbol	BYTE " + ",0
sub_symbol	BYTE " - ",0
mul_symbol	BYTE " * ",0
div_symbol	BYTE " / ",0
equ_symbol	BYTE " = ",0
r_symbol	BYTE " remainder ",0


final_message	BYTE	"Impressed? Bye! ",0

.code
main PROC

; extra credit do-while loop
again:

;Display your name and program title on the output screen. 

mov	edx, OFFSET intro
call WriteString
call CrLf
call CrLf

;Display extra credit
mov edx, OFFSET credit_message1
call WriteString
call CrLf

mov edx, OFFSET credit_message2
call WriteString
call CrLf
call CrLf


;Display instructions for the user. 
mov	edx, OFFSET message1
call WriteString
call CrLf

mov	edx, OFFSET message2
call WriteString
call CrLf
call CrLf


;Prompt the user to enter two numbers. 
	; First input
mov	edx, OFFSET input_message1
call WriteString
call ReadInt
mov input_data1, eax

	; Second input
mov	edx, OFFSET input_message2
call WriteString
call ReadInt
mov input_data2, eax
call CrLf


; Validate the second number to be less than the first. 
	mov eax, input_data1
	cmp eax, input_data2
	jl	true1
	call CrLf



; Calculate the sum, difference, product, (integer) quotient and remainder of the numbers

; Addition process funtion
mov eax, input_data1
mov ebx, input_data2
add ebx, eax
mov add_output, ebx

	; Display addition output

		; Display first number 

		mov eax,  input_data1
		call WriteDec

		; Display add symbol

		mov edx, OFFSET add_symbol
		call WriteString

		; Display second number

		mov eax, input_data2 
		call WriteDec
		
		; Display equal symbol

		mov edx, OFFSET equ_symbol
		call WriteString

		; Display output number
	
		mov	eax, add_output
		call WriteDec
		call CrLf



; Subtract process funtion
mov eax, input_data1
mov ebx, input_data2
sub eax, ebx 
mov sub_output, eax

	; Display subtraction output

		; Display first number 

		mov eax,  input_data1
		call WriteDec

		; Display subtract symbol

		mov edx, OFFSET sub_symbol
		call WriteString

		; Display second number

		mov eax, input_data2 
		call WriteDec
		
		; Display equal symbol

		mov edx, OFFSET equ_symbol
		call WriteString

		; Display output number
	
		mov	eax, sub_output
		call WriteDec
		call CrLf



; Multiplication process funtion
mov eax, input_data1
mov ebx, input_data2
mul ebx
mov mul_output, eax

	; Display multiplication output

		; Display first number 

		mov eax,  input_data1
		call WriteDec

		; Display multiplication symbol

		mov edx, OFFSET mul_symbol
		call WriteString

		; Display second number

		mov eax, input_data2 
		call WriteDec
		
		; Display equal symbol

		mov edx, OFFSET equ_symbol
		call WriteString

		; Display output number
	
		mov	eax, mul_output
		call WriteDec
		call CrLf




; Division process funtion
	mov		edx, 0
	mov		eax, input_data1
	cdq
	mov		ebx, input_data2
	cdq
	div		ebx
	mov		div_output, eax
	mov		r_output, edx



mov eax, input_data1
mov ebx, input_data2
SUB EDX, EDX        
div ebx
mov		div_output, eax
mov		r_output, edx


	; Display Division output

		; Display first number 

		mov eax,  input_data1
		call WriteDec

		; Display division symbol

		mov edx, OFFSET div_symbol
		call WriteString

		; Display second number

		mov eax, input_data2 
		call WriteDec
		
		; Display equal symbol

		mov edx, OFFSET equ_symbol
		call WriteString

		; Display output number
	
		mov	eax, div_output
		call WriteDec

		; Display remainder string
		mov edx, OFFSET r_symbol
		call WriteString

		;Display remainder number

		mov	eax, r_output
		call WriteDec
		call CrLf	
		call CrLf
		
exitpath:

; Output for exit message
		mov edx, OFFSET exit_message1
		call WriteString
		call CrLf	
		mov edx, OFFSET exit_message2
		call WriteString
		call CrLf

; input for exit message
	call ReadInt
	mov exit_input, eax
	cmp eax, 1
	jle again
	cmp eax, 2
	jle theEnd

	jmp theEnd


	true1:
	mov edx, OFFSET validate_mesage
	call WriteString
	call CrLf
	call CrLf	
	jmp exitpath

	theEnd:
; Display a terminating message. 

	mov edx, OFFSET final_message
	call WriteString
	call CrLf


	exit				;exit to operating system
main ENDP

END main
