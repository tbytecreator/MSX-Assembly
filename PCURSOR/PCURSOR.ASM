; ===================================
; CURSOR PISCANTE 
; ===================================
; LUIZ CARLOS BITTENCOURT
; REVISTA CLUBE MSX No9 
; ===================================
            ORG &FA75
            LD HL,&09DA
            EX (SP),HL
            LD IX,&0A27
            LD IY,CARACTER
CARACTER:   CALL &0D6A
            JR Z,PISCA
            POP AF
            CP &09
            JP Z,&10E1
            JP &10DE
PISCA:      JR CARACTER
DESLIGA:    LD A,&F0
            LD (IY+15),A
ACEAPA:     EX (SP),IX
            PUSH IY
            JP (IX)
TEMPO:      LD A,(&FCA2)
            XOR &01
            RET NZ
LIGA:       LD (PISCA+1),A
            RET
; ===================================
; DESATIVA O CURSOR PISCANTE
; ===================================
DESATIVA:   LD A,&C9
            LD (&FFC5),A
            LD (&FD9A),A
            LD (&FDC2),A
            RET
; ===================================
; ATIVA O CURSOR PISCANTE
; ===================================
ATIVA:      LD HL,&FA75
            LD (&FDC3),HL
            LD HL,&FA9C
            LD (&FD9B),HL
            LD HL,&FAA6
            LD (&FFC6),HL
            LD A,&C3
            LD (&FFC5),A
            LD (&FD9A),A
            LD (&FDC2),A
; ===================================
; INICIALIZAR OS CONTADORES DE TEMPO
; ===================================
            LD HL,&000A
            LD (&FCA0),HL
            LD (&FCA2),HL
            RET 
; ===================================