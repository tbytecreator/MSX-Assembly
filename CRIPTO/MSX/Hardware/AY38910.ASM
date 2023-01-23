;================================================================================================
; AY38910.ASM
; ================================================================================================
; Manoel Neto 2019-10-04
; Biblioteca para uso do chip de som AY38910
; ================================================================================================
; Amplitude	        => Volume
; Envelope	        => Mudanças de volume em dado tempo
; Mixer	            => Liga e desliga os canais de som
; Noise	            => Sons com distorcao
; Tone	            => Tom emitido
; ================================================================================================
; REGISTRADORES
; ================================================================================================
; 00	Tone Pitch L - Channel A	LLLLLLLL Lower value = Higher pitch
; 01	Tone Pitch H - Channel A	----HHHH Lower value = Higher pitch
; 02	Tone Pitch L - Channel B	LLLLLLLL Lower value = Higher pitch
; 03	Tone Pitch H - Channel B	----HHHH Lower value = Higher pitch
; 04	Tone Pitch L - Channel C	LLLLLLLL Lower value = Higher pitch
; 05	Tone Pitch H - Channel C	----HHHH Lower value = Higher pitch
; 06	Noise Generator	          	---NNNNN Higher = Faster noise
; 07	Mixer 	       				--NNNTTT N=Noise T=Tone (Channel CBACBA 1=mute 0=normal)
; 08	Amplitude - Channel A		---EVVVV	E=Envelope (1=Enabled) VVVV=Volume
; 09	Amplitude - Channel B		---EVVVV	E=Envelope (1=Enabled) VVVV=Volume
; 10	Amplitude - Channel C		---EVVVV	E=Envelope (1=Enabled) VVVV=Volume
; 11	Envelope L (Volume over time) 	LLLLLLLL	Lower=Faster Envelope
; 12	Envelope H (Volume over time) 	HHHHHHHH	Lower=Faster Envelope
; 13	Envelope Selection	----EEEH	E=Envelope number E (See PDF) H=Hold
; ================================================================================================

; ================================================================================================
; PlaySound
; ================================================================================================
; A => NVPPPPP (N=Noise, V=Volume,P=Tom)
; ================================================================================================
; Altera => Nada
; ================================================================================================
PlaySound:
  cp 0
  jp z,Mudo
  ld h,a			            ; Salva A
	and %00000111	           	; Rotaciona os 3 bits mais baixos de -----XXX
	rrca
	rrca
	rrca
	or %00011111	           	; Converte 11100000 para 11111111
	ld c,a
	ld a,0			            ; TTTTTTTT Tone Lower 8 bits	A
	call SetRegister
	ld a,h
	and %00111000	           	; Get upper bits of tone
	rrca
	rrca
	rrca
	ld c,a
	ld a,1			            ; ----TTTT Tone Upper 4 bits
	call SetRegister
	bit 7,h			            ; Noise bit N-------
	jr z,AYNoNoise
	ld a,7			            ; Mixer  --NNNTTT (1=off) --CBACBA
	ld c,%00110110
	call SetRegister
	ld a,6			            ; Noise ---NNNNN
	ld c,%00011111
	call SetRegister
	jr AYMakeTone
AYNoNoise:
	ld a,7			            ; Mixer  --NNNTTT (1=off) --CBACBA
	ld c,%00111110
	call SetRegister
	jr AYMakeTone
AYMakeTone:
	ld a,h
	and %01000000	            ;-V------ = Volume bit
	rrca
	rrca
	rrca
	rrca
	or %00001011	            ;Shift the high volume bit into position
	ld c,a
	ld a,8			            ;4bit Volume/2bit Envelope Select for channel A
	call SetRegister
ret

Mudo:
	ld a,7		               	;Mixer  --NNNTTT (1=off) --CBACBA
	ld c,%00111111
	call SetRegister
ret
; ================================================================================================

; ================================================================================================
; Setar um registrador
; ================================================================================================
; A => Registrador no AY38910 que sera atualizado
; C => Dados a serem enviados ao registrador
; ================================================================================================
; Altera => Nada
; ================================================================================================
SetRegister:
  push bc
    out (&A0),a         ; carregar a porta de selecao de registrador
  pop bc
  ld a,c
  out (&A1),a           ; manda o novo valor para o porta de dados
ret
; ===============================================================================================