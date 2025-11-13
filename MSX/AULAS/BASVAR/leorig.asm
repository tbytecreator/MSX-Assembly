org 0xc000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode
startcode:
    ld hl,(0xF7F8)
    ld a,(hl)
    ld (0xF7F8),a
    inc hl
    ld a,(hl)
    ld (0xF7F9),a
    ret
endcode: