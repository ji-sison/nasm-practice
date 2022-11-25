;Sison, Ji

section .data
    arr dq  18446744073709551610, 2, 3, 10, 11 ;unsigned int can go up to 2^64 or 18,446,744,073,709,551,616
    len equ $ - arr     
    
    odd db 'ODD', 0xa
    even db 'EVEN', 0xa 
    zero db 'ZERO', 0xa
    lastd db 0 ;last digits of an int in arr
    
section .bss
    index resd 1 ;will serve as pointer to next element in array
    count resd 1 ;will serve as loop index
    
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
    

    loop_start:
        mov ebx, arr ;move arr address to ebx
        mov edx, [ebx+eax] ;move int value from ebx to edx, [ebx+eax]move point to next element in arr
        
        add eax, 8 ;increments by 8, because qword uses 8 bytes
        mov [index], eax
        mov [count], ecx
        
        cmp edx, 0 
        je isZero ;if int is 0
        
        mov byte [lastd], dl ;last digits of that int is stored low register, dl, store that value in lastd
        
        ;using divisibility property of 2, if the last digits of a number is divisible by two then the whole number is also div by 2
        ;finding if the last digits of an int in arr is even is enough to determine if it is even or odd
        ;by this method we can avoid overflow and complex division when dealing with a large number
        
        ;divide the last digits by 2
        mov dx, 0
        mov ax, [lastd]
        mov cx, 2
        div word cx
        
        ;conditional statements to print whether odd or even or zero
        cmp dx, 0   ;remainder is stored at dx,
        je isEven   ;if remainder equal zero then int is even else int is odd
        
        ;prints ODD if int is odd
        mov ecx, odd
        mov edx, 3
        mov ebx, 1
        mov eax, 4
        int 0x80
    
        
        continue:
            mov eax, [index]
            mov ecx, [count]
            loop loop_start
        
            
     jmp exit  
   ;end of loop         
 
 
 isEven:
        ;prints EVEN if int is even
        mov ecx, even
        mov edx, 4
        mov ebx, 1
        mov eax, 4
        int 0x80
        jmp continue
            
isZero:
        ;prints ZERO if int is even
        mov ecx, zero
        mov edx, 4
        mov ebx, 1
        mov eax, 4
        int 0x80
        jmp continue
 



exit:
    mov eax, 1
    int 0x80