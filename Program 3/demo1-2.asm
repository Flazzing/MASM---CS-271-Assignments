TITLE Assignment2     (demo1.asm)

; Author: Lim Cheng Qing
; CS271	in-class demo        1/25/2018
; Description:  This program calculate Fibonacci numbers.
	; Display the program title and programmer’s name. Then get the user’s name, and greet the user.
	; Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter an integer
	;in the range [1 .. 46].
	; Get and validate the user input (n).
	; Calculate and display all of the Fibonacci numbers up to and including the nth term. The results should be
	;displayed 5 terms per line with at least 5 spaces between terms.
	; Display a parting message that includes the user’s name, and terminate the program.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)


message1 BYTE "Welcome to the Integer Accumulator by Lim Cheng Qing.", 0
; The first line of the program message

message2 BYTE "What is your name? ",0
; Message asking for user name 

message3 BYTE "Hello, ",0
; Message to greet user

message4 BYTE "Please enter numbers in [-100, -1].",0
; message to ask user to input -100 to -1

message5 BYTE "Enter a non-negative number when you are finished to see results.",0
; Message user to enter non negative number to exit 

specialmessage BYTE "No negative numbers are added.",0
; message activated when no negative values inputed

question1 BYTE "Enter number:",0
; Question to request input to user

reply1 BYTE "You entered ",0
reply2 BYTE " valid numbers.",0
; Expected Output: You entered x valid numbers
; To inform user about the number of valid numbers being entered

reply3 BYTE "The sum of your valid numbers is ",0
; Expected Output: The sum of your valid numbers is -x
; To inform user about the number of sum  of valid numbers being entered

reply4 BYTE "The rounded average is ",0
; Expected Output: The rounded average is -x
; To inform user about the number of average  of valid numbers being entered

reply5 BYTE "Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ",0

; Final reply to user 

MAX = 80                     ;max chars to read
username BYTE MAX+1 DUP (?)  ;room for null

totalinputs DWORD ?			;user total inputs

input1 DWORD ?				;user input numbers

total DWORD ?				; the sum of the user inputed valid number
avg DWORD ?					; the average of the user inputed valid number

.code
main PROC

; Displaying outputed message to user 
mov edx, OFFSET message1
call WriteString
call CrLf

; Displaying message to ask user for their name
mov edx, OFFSET message2
call WRiteString 

;Reading and storing their name
mov  edx,OFFSET username
mov  ecx,MAX            ;buffer size - 1
call ReadString

; Printing the word "hello"
mov edx, OFFSET message3
call WriteString

; Printing the user's name
mov edx, OFFSET username
call WriteString

call CrLf
call CrLf

; Printing message to inform user to enter value from -1 to -100
mov edx, OFFSET message4
call WriteString
call CrLf

; printing message to inform user to enter non negative numbers
mov edx, OFFSET message5
call WriteString
call CrLf

; Loop to ask user to input numbers
EnterNumber:

	; printing message to inform user to enter non negative numbers 
	mov edx, OFFSET question1
	call WriteString

	call ReadInt


	; if ( input >-1 ) exit to output
	cmp eax, -1
	jg output

	; if (input < -100) exit to output
	cmp eax, -100
	jl output

	; update total
	add total, eax
	inc totalinputs

	; Loop again if input numbers is a valid number
	jmp EnterNumber

	; The execution to display the output message (with valid numbers existed)
	output:
	cmp totalinputs, 0 
	je output2

	; Expected output: You entered x valid numbers.

	mov edx, OFFSET reply1
	call WriteString
	mov eax, totalinputs
	call WriteDec
	mov edx, OFFSET reply2
	call WriteString
	call CrLf

	;Expected output: The sum of your valid numbers is -x

	mov edx, OFFSET reply3
	call WriteString
	mov eax, total
	call WriteInt
	call CrLf

	; Calculating the average value
	mov edx, -1
	mov eax, total
	mov ebx, totalinputs
	idiv ebx
	mov avg, eax

	;Expected result: The rounded average is -x
	mov edx, OFFSET reply4
	call WriteString
	mov eax, avg
	call WriteInt
	call CrLf

	; Final message to user
	; Expected result: Thank you for playing Integer Accumulator! It's been a pleasure to meet you, x.

	jmp TheEnd

	; Executed when no valid inputed number existed
	output2:

	; Expected result: no negarive value has been  entered
	mov edx, OFFSET specialmessage
	call WriteString
	call CrLf
	
	
	
	TheEnd:
	; Final message to user
	mov edx, OFFSET reply5 
	call WriteString

	mov edx, OFFSET username
	call WriteString
	call CrLf




	exit				;exit to operating system
main ENDP

END main
