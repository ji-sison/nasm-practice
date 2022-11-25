;Sison, Ji

section .data
    arr dq  18446744073709551610, 2, 3, 10, 11 ;unsigned int can go up to 2^64 or 18,446,744,073,709,551,616
    len equ $ - arr     
    
    odd db 'ODD', 0xa
    even db 'EVEN', 0xa 
    zero db 'ZERO', 0xa
    lastd db 0 ;last digits of an int in arr
    
    rem db 0
    
segment .bss
    count resb 1
    
section .text
    global _start

_start:

    ;len is divided by 8 to know how many elements are stored in arr1
    mov ax, len
    mov cx, 8
    div word cx
    
    mov [count], al ;quotient stored in count for loop index
    
    mov eax, 0
    mov ecx, [count] ;number of elements in arr1 as loop index
    mov ebx, arr ;move arr address to ebx

    loop_start:
        inc eax
        mov [count], eax
        
        cmp ebx, 0
        je isZero
        
        mov edx, [ebx] ;move int value from ebx to edx
        mov byte [lastd], dl ;last digits of that int is stored low register, dl, store that value in lastd
        
        ;using divisibility property of 2, if the last digits of a number is divisible by two then the whole number is also div by 2
        ;finding if the last digits of an int in arr is even is enough to determine if it is even or odd
        ;by this method we can avoid overflow and complex division when dealing with a large number
        
        mov dx, 0
        mov ax, [lastd]
        mov cx, 2
        div word cx
        
        cmp dx, 0   ;remainder is stored at dx,
        je isEven   ;if remainder equal zero then int is even else int is odd
        
        mov ecx, odd
        mov edx, 3
        mov ebx, 1
        mov eax, 4
        int 0x80
        jmp endif
        
        
        isEven:
            ;prints even if int is even
            mov ecx, even
            mov edx, 4
            mov ebx, 1
            mov eax, 4
            int 0x80
            jmp endif
            
        isZero:
            ;prints even if int is even
            mov ecx, zero
            mov edx, 4
            mov ebx, 1
            mov eax, 4
            int 0x80
            jmp endif       



endif:
    mov ecx, rem
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    
    ;prints lenr
    mov ecx, count
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    ;prints last digits in ascii
    mov ecx, lastd
    mov edx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

exit:
    mov eax, 1
    int 0x80