; =============================================================================
; Z80.ASM
; =============================================================================
; Manoel Neto 2024-03-24
; MSX Z80 Functions
; =============================================================================

; =============================================================================
; Clear the screen
; =============================================================================
; No parameters
; =============================================================================
; Alters => Nothing
; =============================================================================
ClearScreen:
    push af
        xor a
        call CLS
    pop af
ret

; =============================================================================
; Print a new line
; =============================================================================
; No parameters
; =============================================================================
; Alters => Nothing
; =============================================================================
NewLine:
    push af
        ld a, 13
        call CHPUT
        ld a, 10
        call CHPUT
    pop af
ret

; =============================================================================
; Print a string terminated by ENTER(13)
; =============================================================================
; HL => Address of the string
; =============================================================================
; Alters => A,HL
; =============================================================================
PrintString:
    ld a,(hl)
    cp 13
    jp z,EndString
    call CHPUT
    inc hl
    jp PrintString
EndString:
ret

; =============================================================================
; Print a decimal number
; =============================================================================
; A => Number to print (8 bits, 255)
; =============================================================================
; Alters => A,HL,D
; =============================================================================
PrintDecimal:
    ld hl,Hundreds
    ld (hl),&00
    ld hl,Tens
    ld (hl),&00
    ld hl,Units
    ld (hl),&00
CountHundreds:
    ld d,&64
    ld hl,Hundreds
NextHundred:
    sub d
    jr c,CountTens
    inc (hl)
jr NextHundred

CountTens:
    add a,d
    ld d,&0a
    ld hl,Tens
NextTen:
    sub d
    jr c,CountUnits
    inc (hl)
jr NextTen

CountUnits:
    add a,d
    ld (Units),a
    ld d,0

PrintHundreds:
    ld a,(Hundreds)
    cp 0
    jr z,PrintTens
    add a,&30
    call CHPUT
    ld d,1
PrintTens:
    ld a,(Tens)
    add a,d
    cp &00
    jr z,PrintUnits
    sub d
    ld d,1
    add a,&30
    call CHPUT
PrintUnits:
    ld a,(Units)
    add a,&30
    call CHPUT
ret

; =============================================================================
; Print a binary number
; =============================================================================
; A => Number to print (8 bits, 255)
; =============================================================================
; Alters => A,HL,D
; =============================================================================
PrintBinary:
    ld b,8
NextBit:
    rla
    jr nc,PrintZero
    push af
        ld a,'1'
        call CHPUT
    pop af
    jp CheckEnd
PrintZero:
    push af
        ld a,'0'
        call CHPUT
    pop af
CheckEnd:
    djnz NextBit
ret