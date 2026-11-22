count1 equ 0ffdah
csr equ 0ffdeh
cnt3 equ 3fd6h
cport3 equ 3fd4h
do equ 0
re equ 2
mi equ 4
fa equ 6
sol equ 8
ra equ 0ah
sy equ 0ch
do1 equ 0eh
no equ 10h

start:
    mov sp,4000h
    mov dx,cnt3
    mov al,91h
    out dx,al
    mov dx,cport3
    mov al,0ffh
    out dx,al
    mov dx,offset msg
    mov ah,9
    int 21h
    
i8253:
    mov dx,csr
    mov al,01110110b
    out dx,al
input:
    mov dx,3fd0h
    in al,dx
    cmp al,11011111b
    je play1
    cmp al,01111111b
    je play2
    
    jmp input
    
play1:
    mov bx,offset data1
    mov si,offset data2
    jmp main
    
play2:
    mov bx,offset data1
    mov si,offset data3
    jmp main    
    
main:
    mov dx,count1
    mov al,[si]
    cmp al,0ffh
    jz song_end
    mov ah,0
    push si
    
stack:
    mov si,ax
    mov ax,[bx+si]
    out dx,al
    mov al,ah
    out dx,al
    pop si
    inc si
    mov al,[si]
    
j1:
    call timer 
    dec al
    jnz j1
    mov ax,10
    out dx,al
    mov al,ah
    out dx,al
    mov cx,0afh
    loop $
    inc si
    jmp main  
    
song_end:
    jmp input
    
timer:
    mov cx,2800h
    loop $
    ret
    

data1:
       ;DO,    RE,    MI,    FA
    DW  4697,  4184,  3728,  3519
       ;SOL,   RA,    SY,    DO1,  NO
    DW  3135,  2793,  2491,  2352, 10H  
    
data2:
    DB MI,2,RA,2,SOL,2,FA,2
    DB MI,2,FA,2,SOL,2,NO,2
    DB MI,2,FA,2,SOL,2,NO,2
    DB SY,2,RA,2,SOL,2,NO,2
    DB 0ffh
    
data3:
    DB RA,3,RA,1,SOL,2,MI,2
    DB RE,8,DO,6,RE,2,MI,4,SOL,4
    DB RA,2,DO1,2,RA,2,SOL,4,MI,4
    DB SOL,6,SOL,2,RA,4,SOL,4,DO1,0BH
    DB 0ffh    

MSG DB 0DH,0AH,0AH
DB 9,9,9,'========',0DH,0AH 
DB 9,9,9,'==== SPEAKER TEST PROGRAM ====',0DH,0AH
DB 9,9,9,'==== MTS-86C (8253) ====',0DH,0AH
DB 9,9,9,'========',0DH,0AH,0AH
DB 9,9,'SELECT THE DI'
DB 'P Switch (OUT-SP)',0DH,0AH,'$'