section .data
	result db 0
	newline db 10

section .bss
	input1 RESB 4
	input2 RESB 4

section .text
global _start

_start:
	MOV eax,3
	MOV ebx,0
	MOV ecx,input1
	MOV edx,4
	INT 80h
	
	MOV eax,3
	MOV ebx,0
	MOV ecx,input2
	MOV edx,4
	INT 80h
	
	MOV al,[input1]
	SUB al,'0'
	MOV bl,al
	
	MOV al,[input2]
	SUB al,'0'
	SUB bl,al
	
	ADD bl,'0'
	MOV [result],bl
	
	MOV eax,4
	MOV ebx,1
	MOV ecx,result
	MOV edx,1
	INT 80h
	
	MOV eax,4
	MOV ebx,1
	MOV ecx,newline
	MOV edx,1
	INT 80h
	
	MOV eax,1
	XOR ebx,ebx
	INT 80h
