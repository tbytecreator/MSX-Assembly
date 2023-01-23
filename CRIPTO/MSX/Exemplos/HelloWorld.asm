; =======================================================================
; Teste de chamadas de funcoes gerais
; Manoel Neto 2019-0923
; =======================================================================
org &4000
db "AB"
dw ProgramStart
db 00,00,00,00,00

ProgramStart:
  call ClearScreen
  call InitTxt32Col
  ld hl, Message
  call PrintString
  call NewLine
  ld a,100
  call PrintNumber
  DI
  Halt

  include "library\CZLibrary.asm"

Message:
  db "Ola Mundo!",13

org &C000 ; PAD para 32K
