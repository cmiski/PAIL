section .text

global _start

_start:
	MOV eax,2
	MOV ebx,9
	ADD eax,ebx
	int 80h
