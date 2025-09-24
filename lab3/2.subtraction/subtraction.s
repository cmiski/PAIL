section .data
	result db 0
	newline db 10
	
section .text

global _start

_start:
	MOV al,7
	MOV bl,2
	SUB al,bl
	ADD al,'0'
	MOV [result],al
	
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
	
	
	
