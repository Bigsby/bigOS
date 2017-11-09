; 
; A simple boot sector that prints a message to the screen using a BIOS routine. 
;
[org 0x7c00]            ; instruct loader where the code is loaded

mov bx, WELCOME_MESSAGE
call print_string

jmp $                   ; Jump to the current address (i.e. forever).

WELCOME_MESSAGE:
    db "BigOS is up and running!", 0

print_string:
    pusha

    mov ah, 0x0e        ; set scrolling teletype

    start_lopp:

        mov al, [bx]    ; set al to the value in bx address
        
        cmp al, 0       ; compare the value al address to 0 to test for end of string
        je return       ; if it is 0, exit
                
        int 0x10        ; call BIOS interrupt
        
        add bx, word 1  ; move to next bx address
        jmp start_lopp  ; jump to start of loop

    return:
    mov al, 13          ; carriage return
    int 0x10
    mov al, 10          ; new line
    int 0x10

    popa
    ret
; 
; Padding and magic BIOS number. 
;

times 510-($-$$) db 0   ; Pad the boot sector out with zeros

dw 0xaa55               ; Last two bytes form the magic number , 
                        ; so BIOS knows we are a boot sector.
