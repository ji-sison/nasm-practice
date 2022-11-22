;Sison, Ji

section .data
    str1 db "helloworlds", 0xa
    len1 equ $ - str1
    newline db 0ah
    
section .bss
    char resb 1
    count resd 1
    index resd 1

section .text
    global _start
    
_start:

    mov eax, -1
    mov ecx, len1 ;length of str1
  
  loop_start:
    inc eax
    mov ebx, str1
    mov [index], eax ;char index at str1 starts at 0
    mov [count], ecx ;loop index starts at length of str1
    
    mov ah, byte [ebx+eax] ;reads char in the string and stores in ah register
    mov [char], ah ;stores in char label
    
    ;prints char
    mov edx, 1
    mov ecx, char
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    ;checks if it is the last character, if so it will not print new line
    mov ecx, [count]
    cmp ecx, 2
    je exit
    
    ;prints new line
    mov edx, 1
    mov ecx, newline
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    mov eax, [index]
    mov ecx, [count]
    
    loop loop_start
    
    
exit:
    mov eax, 1
    int 0x80