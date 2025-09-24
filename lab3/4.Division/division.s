section .data
    qmsg db "Quotient: ",0
    lenq equ $-qmsg
    rmsg db " Remainder: ",0
    lenr equ $-rmsg
    newline db 0xA,0

section .bss
    quotient resb 12
    remainder resb 12

section .text
    global _start

_start:
    mov eax,123       ; dividend
    mov ebx,10        ; divisor
    xor edx,edx       ; clear EDX before division
    div ebx           ; EAX = quotient, EDX = remainder

    mov esi,eax       ; store quotient
    mov edi,edx       ; store remainder

    ; Convert quotient to string
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

    ; Convert remainder to string
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

    ; Print quotient
    mov eax,4
    mov ebx,1
    mov ecx,qmsg
    mov edx,lenq
    int 0x80
    mov eax,4
    mov ebx,1
    mov ecx,ecx
    mov ecx,ecx
    mov ecx,ecx
    mov ecx,quotient
    mov edx,quotient+11
    sub edx,ecx
    int 0x80

    ; Print remainder
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

    ; Print newline
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 0x80

    ; Exit
    mov eax,1
    xor ebx,ebx
    int 0x80

