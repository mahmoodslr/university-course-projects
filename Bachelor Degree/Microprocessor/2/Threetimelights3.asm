#start=Traffic_Lights.exe#
#start=led_display.exe#

name "Threetimelights"

mov ax, all_red
out 4, ax

mov si, offset right_green

next:
mov ax, [si]
out 4, ax

cmp ax,right_green
je t1
cmp ax,left_green
je t2
cmp ax,ver_green
je t3
jmp t4

t1:
mov bx, 17
jmp timer
t2:
mov bx, 10
jmp timer
t3:
mov bx, 13
jmp timer
t4:
mov bx, 3

timer:
mov ax,bx
out 199, ax

; wait 1 seconds (1 million microseconds)
mov     cx, 0fh    ;    000f4240h = 1,000,000
mov     dx, 4240h
mov     ah, 86h
int     15h

dec bx
jnz timer

add si, 2 ; next situation
cmp si, sit_end
jb  next
mov si, offset right_green
jmp next

;                      FEDC_BA98_7654_3210
right_green     dw     0000_0010_0110_0001b
right_yellow    dw     0000_0010_0101_0001b
left_green      dw     0000_1000_0100_1001b
left_yellow     dw     0000_0100_0100_1001b
ver_green       dw     0000_0011_0000_1100b
ver_yellow      dw     0000_0010_1000_1010b
sit_end = $

all_red         equ    0000_0010_0100_1001b