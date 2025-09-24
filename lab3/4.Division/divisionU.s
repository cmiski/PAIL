section .data
    msg1 db "Enter dividend: ",0
    len1 equ $-msg1
    msg2 db "Enter divisor: ",0
    len2 equ $-msg2
    qmsg db "Quotient: ",0
    lenq equ $-qmsg
    rmsg db " Remainder: ",0
    lenr equ $-rmsg
    newline db 0xA,0

section .bss
    num1 resb 12
    num2 resb 12
    quotient resb 12
    remainder resb 12

section .text
    global _start

_start:
    ; ---- Read dividend ----
    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,num1
    mov edx,12
    int 0x80

    ; ---- Convert dividend to integer ----
    mov esi,num1
    xor eax,eax
.convert1:
    mov bl,[esi]
    cmp bl,0xA          ; stop at newline
    je .done1
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc esi
    jmp .convert1
.done1:
    mov esi,eax          ; store dividend in ESI

    ; ---- Read divisor ----
    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,num2
    mov edx,12
    int 0x80

    ; ---- Convert divisor to integer ----
    mov edi,num2
    xor eax,eax
.convert2:
    mov bl,[edi]
    cmp bl,0xA          ; stop at newline
    je .done2
    sub bl,'0'
    imul eax,eax,10
    add eax,ebx
    inc edi
    jmp .convert2
.done2:
    mov edi,eax          ; store divisor in EDI

    ; ---- Perform division ----
    mov eax,esi          ; dividend
    xor edx,edx
    div edi              ; EAX=quotient, EDX=remainder
    mov esi,eax          ; quotient
    mov edi,edx          ; remainder

    ; ---- Convert quotient to string ----
    mov eax,esi
    mov ecx,quotient+11
    mov byte [ecx],0
.q_loop:
    xor edx,edx
    mov ebp,10
    div ebp
    add dl,'0'
    dec ecx
    mov [ecx],dl
    test eax,eax
    jnz .q_loop

    ; ---- Convert remainder to string ----
    mov eax,edi
    mov ecx,remainder+11
    mov byte [ecx],0
.r_loop:
    xor edx,edx
    mov ebp,10
    div ebp
    add dl,'0'
    dec ecx
    mov [ecx],dl
    test eax,eax
    jnz .r_loop

    ; ---- Print quotient ----
    mov eax,4
    mov ebx,1
    mov ecx,qmsg
    mov edx,lenq
    int 0x80
    mov eax,4
    mov ebx,1
    mov ecx,quotient
    mov edx,quotient+11
    sub edx,ecx
    int 0x80

    ; ---- Print remainder ----
    mov eax,4
    mov ebx,1
    mov ecx,rmsg
    mov edx,lenr
    int 0x80
    mov eax,4
    mov ebx,1
    mov ecx,remainder
    mov edx,remainder+11
    sub edx,ecx
    int 0x80

    ; ---- Print newline ----
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80

    ; ---- Exit ----
    mov eax,1
    xor ebx,ebx
    int 0x80

