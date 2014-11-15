.model small
.stack 256
.data
    VAR1 DB 00h,00h,00h
    VAR2 DB 1Ah,2Bh,5Fh
    VAR3 DB ?,?,?
.code
.start  
    MOV AX,0E00h
    MOV SP,AX
    ;MOV BX,offset VAR1   ;carga en bx la direccion de VAR1
    LEA BX,VAR1
    LEA SI,VAR2
    LEA DI,VAR3
    MOV CX,03h
LAZO:
    MOV AL,[BX]
    MOV AH,[SI]
    CALL SUMA
    INC BX
    INC SI
    LOOP LAZO
        JMP SALIR
    SUMA:
        ADD AL,AH
        MOV [DI],AL
        INC DI  
        RET
    SALIR:
        NOP
        .exit
       ;d 0720  
END