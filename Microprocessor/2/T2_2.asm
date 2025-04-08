#start=Traffic_Lights.exe#
name "traffic"
#start=led_display.exe#
#make_bin#
name "led"

mov ax, all_red
out 4, ax


mov si, offset situation


next:
mov ax, [si]    
cmp ax, 0000_0010_0110_0001b  
je green_right  

cmp ax, 0000_1000_0100_1001b 
je green_left

cmp ax, 0000_0011_0000_1001b  
je green_vertical            
                 
cmp ax, 0000_0010_0100_1100b  
je green_vertical                 

jmp default_case  

green_right:
    out 4, ax
    mov ax, 17
    x1:
        out 199, ax
        dec ax
        push ax
        mov cx,0fh
        mov dx,4240h
        mov ah,86h
        int 15h  
        pop ax
        jnz x1
    jmp next_state

green_left:
    out 4, ax
    mov ax, 10
    x2:
        out 199, ax
        dec ax
        push ax
        mov cx,0fh
        mov dx,4240h
        mov ah,86h
        int 15h  
        pop ax
        jnz x2
    jmp next_state

green_vertical:
    out 4, ax
    mov ax, 13
    x3:
        out 199, ax
        dec ax
        push ax
        mov cx,0fh
        mov dx,4240h
        mov ah,86h
        int 15h  
        pop ax
        jnz x3
    jmp next_state
    
default_case:
    out 4, ax
    mov ax, 3
    x4:
        out 199, ax
        dec ax
        push ax
        mov cx,0fh
        mov dx,4240h
        mov ah,86h
        int 15h  
        pop ax
        jnz x4
    jmp next_state    
    
next_state:
    add si, 2 
    cmp si, sit_end
    jb  next
    mov si, offset situation
    jmp next


;                        FEDC_BA98_7654_3210
situation        dw      0000_0010_0100_1100b
s1               dw      0000_0010_0100_1010b
s2               dw      0000_0010_0110_0001b
s3               dw      0000_0010_0101_0001b
s4               dw      0000_0011_0000_1001b
s5               dw      0000_0010_1000_1001b
s6               dw      0000_1000_0100_1001b
s7               dw      0000_0100_0100_1001b
sit_end = $


all_red          equ     0000_0010_0100_1001b

