;Sison, Ji

;an assembly program that will display every other character in a string starting with
the first character.

section .data
    str1 db "123456789012"
    len1 equ $ - str1
    
section .bss
    char resb 1
    count resd 1
    index resd 1

section .text
    global _start
    
_start:

    mov eax, -2
    mov ecx, len1 ;length of str1
  
  loop_start:
    add eax, 2 ;increments by 2 means only odd numbered char will be printed out incl 1st char
    
    ;compares index to the length of str1
    ;if it exceeds or have the same value which means the length is an even num (index inc by 2) then the program will exit
    mov edx, len1
    cmp eax, edx
    jge exit
    
    mov ebx, str1
    mov [index], eax ;char index at str1 starts at 0 (-2+2=0)
    mov [count], ecx ;loop index starts at length of str1 
    
    mov ah, byte [ebx+eax] ;reads char in the string and stores in ah register
    mov [char], ah ;stores in char label
    
    ;prints char
    mov edx, 1
    mov ecx, char
    mov ebx, 1
    mov eax, 4
    int 0x80

    
    mov eax, [index]
    mov ecx, [count]
    
    loop loop_start
    

    
exit:

    mov eax, 1
    int 0x80
    