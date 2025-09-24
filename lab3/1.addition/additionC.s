section .data 
	num1 db 2 
	num2 db 3 
	result db 0 
	newline db 10
	
section .text 
global _start 

_start: 
	MOV al,[num1] 
	ADD al,[num2] 
	
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
