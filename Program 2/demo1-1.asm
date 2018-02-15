TITLE Summation     (demo1.asm)

; Author: Lim Cheng Qong
; CS271	in-class demo        1/27/2018
; Description:  This program calculate Fibonacci numbers.
; Display the program title and programmer’s name. Then get the user’s name, and greet the user.
; Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter an integer
;in the range [1 .. 46].
; Get and validate the user input (n).
; Calculate and display all of the Fibonacci numbers up to and including the nth term. The results should be
;displayed 5 terms per line with at least 5 spaces between terms.
; Display a parting message that includes the user’s name, and terminate the program.

INCLUDE Irvine32.inc

; Constants declaration

; Maximum chars to read user name
MAX = 80                    

; Maximum fibonacci term 
UPPERLIMIT = 46;


.data

intro1 BYTE "Fibonacci Numbers",0
intro2 BYTE "Programmed by Lim Cheng Qing",0

question1 BYTE "What is your name? ",0 
question2 BYTE "How many Fibonacci terms do you want? ",0 
question3 BYTE "What’s your name? ",0 

format BYTE "     ",0

data1 DWORD 1
data2 DWORD 0

loop1 DWORD 0

errormessage BYTE "Out of range. Enter a number in [1 .. 46]",0

message1 BYTE "Hello, ",0 
message2 BYTE "Enter the number of Fibonacci terms to be displayed",0 
message3 BYTE "Give the number as an integer in the range [1 .. 46].",0 
message4 BYTE "Results certified by Lim Cheng Qing.", 0
message5 BYTE "Goodbye, ", 0


input1 BYTE MAX+1 DUP (?)  ;room for null
input2 DWORD ? ; store the Fibonacci term to be displayed



.code
main PROC

; introduction
; Display the program title and programmer’s name
; The programmer’s name and the user’s name must appear in the output.

; Display program name
mov edx, OFFSET intro1
call WriteString
call CrLf

; Display authors name
mov edx, OFFSET intro2
call WriteString
call CrLf
call CrLf


; Ask user for their name
; Obtaining user's name 
mov edx, OFFSET question1
call WriteString
mov  edx,OFFSET input1
mov  ecx, MAX            ;buffer size - 1
call ReadString


; Display name of the user
mov edx, OFFSET message1
call WriteString
mov edx, OFFSET input1
call WriteString
call CrLf


; userInstructions
; Display the instructions for user to input sequence number
; Prompt the user to enter the number of Fibonacci terms to be displayed. Advise the user to enter an integer
; in the range [1 .. 46].

; Display Instruction line 1 "Enter the number of Fibonacci terms to be displayed"
mov edx, OFFSET message2
call WriteString
call CrLf


; Display Instruction line 2 "Give the number as an integer in the range [1 .. 46]."
mov edx, OFFSET message3
call WriteString
call CrLf
call CrLf


; Get Fibonacci term
; Get and validate the user input (n). 
; ask user for fibonacci term

start:

mov edx, OFFSET question2
call WriteString
call ReadInt
mov input2, eax


mov eax, input2
cmp eax, 1
jl AGAIN
cmp eax, UPPERLIMIT
jg AGAIN
jmp GOODINPUT

; Display error message "Out of range. Enter a number in [1 .. 46]"

AGAIN:
mov edx, OFFSET errormessage
call WriteString
call CrLf
jmp start
GOODINPUT:
call CrLf


; Display fibonacci term
; Calculate and display all of the Fibonacci numbers up to and including the nth term. The results should be
; displayed 5 terms per line with at least 5 spaces between terms

; Note
	;	The loop is implemented as a post-test loop
	;	The loop that calculates the Fibonacci terms must be implemented using the MASM loop instruction	


    mov  ecx, input2
    mov  eax, 1    ;a = 0
    mov  ebx, 1    ;b = 1


fib:
    mov  edx, eax 
    add  edx, ebx  ;sum = a + b
	cmp eax, 0
	call WriteDec
	je t1


	t1:
    mov  eax, ebx  ;a = b
    mov  ebx, edx  ;b = sum
	mov edx, OFFSET format
	call WriteString
    loop fib

; farewell
; Display a parting message that includes the user’s name, and terminate the program.

	call CrLf
	call CrLf
	mov edx, OFFSET message4
	call writeString 
	call CrLf

	mov edx, OFFSET message5
	call WriteString 
	mov edx, OFFSET input1
	call WriteString
	call CrLf



	exit				;exit to operating system
	main ENDP

END main				; End the program
